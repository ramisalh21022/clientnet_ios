import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import 'package:dio/dio.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

/// ----------------- ApiClient -----------------
class ApiConfig {
  static const String baseUrl = 'https://api.alfateh.cloudtech-it.com';
  static const Duration timeout = Duration(seconds: 30);
}

class ApiException implements Exception {
  final String message;
  final int? statusCode;
  ApiException(this.message, {this.statusCode});
  @override
  String toString() => 'ApiException($statusCode): $message';
}

class ApiClient {
  static final ApiClient _instance = ApiClient._internal();
  factory ApiClient() => _instance;

  late final Dio dio;
  PersistCookieJar? _cookieJar;

  ApiClient._internal() {
    dio = Dio(
      BaseOptions(
        baseUrl: ApiConfig.baseUrl,
        connectTimeout: ApiConfig.timeout,
        receiveTimeout: ApiConfig.timeout,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'User-Agent': 'FlutterClient/1.0', // متوافق مع السيرفر
        },
      ),
    );
  }

  Future<void> initCookieJar() async {
    if (_cookieJar != null) return;
    final dir = await getApplicationDocumentsDirectory();
    _cookieJar = PersistCookieJar(storage: FileStorage('${dir.path}/cookies'));
    dio.interceptors.add(CookieManager(_cookieJar!));

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          print('➡️ ${options.method} ${options.path}');
          handler.next(options);
        },
        onResponse: (response, handler) {
          print('✅ ${response.statusCode} ${response.requestOptions.path}');
          handler.next(response);
        },
        onError: (e, handler) {
          print('❌ ${e.response?.statusCode} ${e.requestOptions.path}');
          handler.next(e);
        },
      ),
    );
  }

  Future<void> initSession() async {
    await initCookieJar();
    try {
      // أي طلب GET للـ root لإنشاء session + cookies
      final res = await dio.get('/');
      print('SESSION INIT: ${res.statusCode}');
    } catch (e) {
      print('SESSION INIT FAILED: $e');
    }
  }

  Future<dynamic> post(
    String path, {
    Map<String, dynamic>? data,
    String? token,
  }) async {
    try {
      final response = await dio.post(
        path,
        data: data != null ? jsonEncode(data) : null,
        options: Options(
          headers: token != null ? {'Authorization': 'Bearer $token'} : null,
        ),
      );
      return response.data;
    } on DioException catch (e) {
      final msg = e.response?.data?['message'] ?? e.message ?? 'Server error';
      throw ApiException(msg, statusCode: e.response?.statusCode);
    }
  }

  Future<dynamic> get(String path, {String? token}) async {
    try {
      final response = await dio.get(
        path,
        options: Options(
          headers: token != null ? {'Authorization': 'Bearer $token'} : null,
        ),
      );
      return response.data;
    } on DioException catch (e) {
      final msg = e.response?.data?['message'] ?? e.message ?? 'Server error';
      throw ApiException(msg, statusCode: e.response?.statusCode);
    }
  }
}

/// ----------------- DeviceIdService -----------------
class DeviceIdService {
  static const _key = 'device_id';
  static Future<String> getDeviceId() async {
    final prefs = await SharedPreferences.getInstance();
    String? deviceId = prefs.getString(_key);
    if (deviceId != null && deviceId.isNotEmpty) return deviceId;
    final newId = const Uuid().v4();
    await prefs.setString(_key, newId);
    return newId;
  }
}

/// ----------------- AuthService -----------------
class AuthService {
  final ApiClient _api = ApiClient();
  static const String _tokenKey = 'auth_tokens';

  Future<AuthTokens?> getSavedTokens() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonStr = prefs.getString(_tokenKey);
    if (jsonStr == null) return null;
    final data = jsonDecode(jsonStr);
    return AuthTokens(
      accessToken: data['accessToken'],
      refreshToken: data['refreshToken'],
      createdAt: DateTime.parse(data['createdAt']),
    );
  }

  Future<void> saveTokens(AuthTokens tokens) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, jsonEncode(tokens.toJson()));
  }

  bool isAccessTokenValid(AuthTokens tokens) {
    return DateTime.now().difference(tokens.createdAt).inDays < 7;
  }

  Future<AuthTokens?> refreshToken(String refreshToken) async {
    try {
      final res = await _api.post(
        '/api/auth/token/refresh',
        data: {'refreshToken': refreshToken},
      );
      final tokens = AuthTokens.fromJson(res);
      await saveTokens(tokens);
      return tokens;
    } catch (_) {
      return null;
    }
  }

  Future<AuthTokens?> getValidToken() async {
    final tokens = await getSavedTokens();
    if (tokens == null) return null;
    if (isAccessTokenValid(tokens)) return tokens;
    return await refreshToken(tokens.refreshToken);
  }

  Future<Map<String, dynamic>> login({
    required String username,
    required String password,
  }) async {
    await _api.initSession();
    final deviceId = await DeviceIdService.getDeviceId();
    final data = {
      'username': username,
      'password': password,
      'deviceId': deviceId,
    };
    final res = await _api.post('/api/auth/login', data: data);
    final tokens = AuthTokens.fromJson(res);
    await saveTokens(tokens);
    return res;
  }

  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_tokens');
    await prefs.clear();
  }
}

class AuthTokens {
  final String accessToken;
  final String refreshToken;
  final DateTime createdAt;

  AuthTokens({
    required this.accessToken,
    required this.refreshToken,
    required this.createdAt,
  });

  factory AuthTokens.fromJson(Map<String, dynamic> json) {
    return AuthTokens(
      accessToken: json['accessToken'],
      refreshToken: json['refreshToken'],
      createdAt: DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() => {
    'accessToken': accessToken,
    'refreshToken': refreshToken,
    'createdAt': createdAt.toIso8601String(),
  };
}

class CustomerService {
  final ApiClient _api = ApiClient();
  final String baseUrl = 'https://api.alfateh.cloudtech-it.com/api';

  Future<dynamic> getProfile(String token) async {
    return await _api.get('/api/customers/me', token: token);
  }

  Future<dynamic> getAccounts(String token) async {
    return await _api.get('/api/customers/me/accounts', token: token);
  }

  Future<dynamic> getTransactions(
    String token, {
    int page = 0,
    int size = 10,
  }) async {
    return await _api.get(
      '/api/customers/me/transactions?page=$page&size=$size',
      token: token,
    );
  }

  Future<dynamic> getSessions(
    String token, {
    required int page,
    required int size,
    String? search,
    DateTime? from,
    DateTime? to,
  }) async {
    return await _api.get(
      '/api/customers/me/sessions?page=$page&size=$size',
      token: token,
    );
  }

  // 🔹 جميع الاشتراكات
  Future<List<dynamic>> getSubscriptions(String token) async {
    final response = await http.get(
      Uri.parse('$baseUrl/customers/me/subscriptions'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body) as List<dynamic>;
    } else {
      throw Exception('Failed to load subscriptions');
    }
  }

  // 🔹 تفاصيل اشتراك واحد (زر "إظهار التفاصيل")
  Future<SubscriptionDTO> getSubscriptionDetails(int id, String token) async {
    final response = await http.get(
      Uri.parse('https://api.alfateh.cloudtech-it.com/api/subscriptions/$id'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to load subscription details');
    }

    return SubscriptionDTO.fromJson(jsonDecode(response.body));
  }

  Future<void> requestExtension(int subscriptionId, String token) async {
    final res = await http.put(
      Uri.parse('$baseUrl/services/extend-expiry/$subscriptionId'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (res.statusCode != 200) {
      throw Exception('Failed to extend subscription');
    }
  }
}

class SubscriptionService {
  final ApiClient _api = ApiClient();

  Future<dynamic> getSubscriptionById(String token, int subscriptionId) async {
    return await _api.get('/api/subscriptions/$subscriptionId', token: token);
  }
}

class ServiceActionsService {
  final ApiClient _api = ApiClient();

  Future<String> extendExpiry(String token, int subscriptionId) async {
    return await _api.post(
      '/api/services/extend-expiry/$subscriptionId',
      token: token,
    );
  }

  Future<String> chargeServiceType(
    String token,
    int subscriptionId,
    int serviceTypeId,
  ) async {
    return await _api.post(
      '/api/services/charge-service-type/$subscriptionId/$serviceTypeId',
      token: token,
    );
  }

  Future<dynamic> getServiceTypes(String token) async {
    return await _api.get('/api/services/service-types', token: token);
  }
}

class SubscriptionDTO {
  final int customerId;
  final int subscriptionId;
  final String serviceName;
  final String serviceType;
  final String username;
  final String startDate;
  final String expiryDate;
  final int graceTimeDays;
  final bool online;

  final int currentInputOctets;
  final int currentOutputOctets;
  final int currentSessionsTime;

  final int downloadLimit;
  final int uploadLimit;
  final int serviceDownloadLimit;
  final int serviceUploadLimit;
  final int serviceTimeLimit;

  SubscriptionDTO({
    required this.customerId,
    required this.subscriptionId,
    required this.serviceName,
    required this.serviceType,
    required this.username,
    required this.startDate,
    required this.expiryDate,
    required this.graceTimeDays,
    required this.online,
    required this.currentInputOctets,
    required this.currentOutputOctets,
    required this.currentSessionsTime,
    required this.downloadLimit,
    required this.uploadLimit,
    required this.serviceDownloadLimit,
    required this.serviceUploadLimit,
    required this.serviceTimeLimit,
  });

  factory SubscriptionDTO.fromJson(Map<String, dynamic> json) {
    return SubscriptionDTO(
      customerId: json['customerId'],
      subscriptionId: json['subscriptionId'],
      serviceName: json['serviceName'] ?? '',
      serviceType: json['serviceType'] ?? '',
      username: json['username'] ?? '',
      startDate: (json['startDate']),
      expiryDate: (json['expiryDate']),
      graceTimeDays: json['graceTimeDays'] ?? 0,
      online: json['online'] ?? false,
      currentInputOctets: json['currentInputOctets'] ?? 0,
      currentOutputOctets: json['currentOutputOctets'] ?? 0,
      currentSessionsTime: json['currentSessionsTime'] ?? 0,
      downloadLimit: json['downloadLimit'] ?? 0,
      uploadLimit: json['uploadLimit'] ?? 0,
      serviceDownloadLimit: json['serviceDownloadLimit'] ?? 0,
      serviceUploadLimit: json['serviceUploadLimit'] ?? 0,
      serviceTimeLimit: json['serviceTimeLimit'] ?? 0,
    );
  }
}
