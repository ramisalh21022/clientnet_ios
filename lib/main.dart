import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'api-client.dart';
//import 'package:device_info_plus/device_info_plus.dart';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'package:flutter/widgets.dart';
import 'SplashScreen.dart';
import 'package:url_launcher/url_launcher.dart';
import 'app_colors.dart';
import 'dart:math';
import 'dart:ui';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

/* ------------------ Localization ------------------ */
class L {
  final Locale locale;
  L(this.locale);

  static L? of(BuildContext context) {
    return Localizations.of<L>(context, L);
  }

  static const Map<String, Map<String, String>> _data = {
    'ar': {
      "download_speed": "سرعة التنزيل",
      "upload_speed": "سرعة الرفع",
      "load_failed": "فشل تحميل البيانات. تحقق من اتصال الإنترنت.",
      "refresh_failed": "فشل تحديث البيانات. تحقق من اتصال الإنترنت.",
      "refresh_success": "تم تحديث البيانات بنجاح",
      'refresh': 'تحديث',
      "extend_service": "تمديد الخدمة",
      "charge_service": "شحن الخدمة",
      "service_extended_success": "تم تمديد الخدمة بنجاح",
      "service_extend_failed": "فشل تمديد الخدمة",
      "service_charged_success": "تم شحن الخدمة بنجاح",
      "service_charge_failed": "فشل شحن الخدمة",
      "select_service_type": "اختر نوع الخدمة",
      // Auth
      'login': 'تسجيل الدخول',
      'logout': 'تسجيل خروج',
      'username': 'اسم المستخدم',
      'password': 'كلمة المرور',

      // General
      'welcome': 'مرحباً',
      'balance': 'رصيد حسابك',
      'services': 'خدمات',
      'service_information': 'معلومات الخدمة',
      'account': 'الحساب',
      'subscriptions': 'اشتراكاتك',
      'transfers': 'التحويلات',
      'actions': 'الإجراءات',
      'online': 'متصل',
      'offline': 'غير متصل',
      'active': 'نشط',
      'inactive': 'غير نشط',
      'days': 'أيام',

      // Subscriptions
      'subscriptions_desc': 'عرض تفاصيل استهلاك البيانات لجميع اشتراكاتك',
      'subscriptions_details': 'تفاصيل الاشتراكات',
      'subscription_id': 'رقم الاشتراك',
      'service_name': 'اسم الخدمة',
      'service_type': 'نوع الخدمة',
      'Type': 'نوع ',

      'vip_user': 'مستخدم VIP',
      'grace_period': 'فترة السماح',
      'no_subscriptions': 'لا توجد اشتراكات',

      // Usage
      'usage_information': 'معلومات الاستهلاك',
      'usage_progress': 'تقدم الاستهلاك',
      'usage': 'الاستخدام',
      'usage_rate': 'نسبة الاستهلاك',
      'download': 'تحميل',
      'Online_Services': 'تحميل',
      'Total_Upload': 'الرفع الكلي',
      'Total_Download': 'التحميل الكلي',
      'upload': 'رفع',
      'total_usage': 'الاستهلاك الكلي',
      'total_data': 'البيانات الكلي',
      'max_usage': 'الاستهلاك الأعلى',
      'limit': 'الحد',
      'remaining': 'المتبقي',
      'remaining_days': 'الأيام المتبقية',

      // Limits
      'limits_settings': 'الحدود والإعدادات',
      'download_limit': 'حد التحميل',
      'upload_limit': 'حد الرفع',

      // Sessions
      'current_session_time': 'مدة الجلسة الحالية',
      'total_sessions_time': 'إجمالي مدة الجلسات',
      'total_sessions': 'إجمالي الجلسات',

      // Dates
      'dates': 'التواريخ',
      'start_date': 'تاريخ البدء',
      'end_date': 'تاريخ الانتهاء',
      'expiry_date': 'تاريخ الانتهاء',
      'active_for': 'نشط لمدة',

      // Actions
      'request_extension': 'طلب تمديد',
      'charge_subscription': 'شحن الاشتراك',

      // Messages
      'extension_success': 'تم تمديد الاشتراك بنجاح',
      'extension_failed': 'فشل تمديد الاشتراك',
      'no_service_types': 'لا توجد أنواع خدمات',

      // Finance
      'financial_transactions': 'المعاملات المالية',
      'transaction_type': 'نوع العملية',
      'credit': 'إضافة إلى الحساب',
      'debit': 'خصم من الحساب',
      'amount': 'المبلغ',
      'currency': 'العملة',
      'date_time': 'التاريخ والوقت',
      'description': 'الوصف',
      'external_ref': 'المرجع الخارجي',

      // UI
      'show_details': 'عرض التفاصيل',
      'personal_info': 'المعلومات الشخصية',
      'accounts': 'الحسابات',
      'sessions': 'الجلسات',
      'full_name': 'الاسم الكامل',
      'mobile_number': 'رقم الموبايل',
      'email_address': 'البريد الإلكتروني',
      'status': 'الحالة',
    },

    'en': {
      "download_speed": "Download Speed",
      "upload_speed": "Upload Speed",
      "load_failed": "Load Failed",
      "refresh_failed": "Refresh Failed",
      "refresh_success": "Refresh Success",
      'refresh': 'Refresh',
      "extend_service": " extend service",
      "charge_service": "charge service ",
      "service_extended_success": "service extended success ",
      "service_extend_failed": "service extend failed ",
      "service_charged_success": "service charged success ",
      "service_charge_failed": "service charge failed ",
      "select_service_type": "select service type ",
      // Auth
      'login': 'Login',
      'logout': 'Logout',
      'username': 'Username',
      'password': 'Password',

      // General
      'welcome': 'Welcome',
      'balance': 'Your balance',
      'services': 'Services',
      'service_information': 'service information',
      'account': 'Account',
      'subscriptions': 'Subscriptions',
      'transfers': 'Transfers',
      'actions': 'Actions',
      'online': 'Online',
      'offline': 'Offline',
      'active': 'Active',
      'inactive': 'Inactive',
      'days': 'Days',

      // Subscriptions
      'subscriptions_desc':
          'View data usage details for all your subscriptions',
      'subscriptions_details': 'Subscriptions details',
      'subscription_id': 'Subscription ID',
      'service_name': 'Service Name',
      'service_type': 'Service Type',
      'vip_user': 'VIP User',
      'grace_period': 'Grace Period',
      'no_subscriptions': 'No subscriptions found',

      // Usage
      'usage_information': 'Usage Information',
      'usage_progress': 'Usage Progress',
      'usage': 'Usage',
      'usage_rate': 'Usage Rate',
      'download': 'Download',
      'Online_Services': 'Online Services',
      'Total_Upload': 'Total Upload',
      'Total_Download': 'Total Download',

      'upload': 'Upload',
      'total_usage': 'Total Usage',
      'total_data': 'Total Data',
      'max_usage': 'Max Usage',
      'limit': 'Limit',
      'remaining': 'Remaining',
      'remaining_days': 'Remaining Days',

      // Limits
      'limits_settings': 'Limits & Settings',
      'download_limit': 'Download Limit',
      'upload_limit': 'Upload Limit',

      // Sessions
      'current_session_time': 'Current Session Time',
      'total_sessions_time': 'Total Sessions Time',
      'total_sessions': 'Total Sessions',

      // Dates
      'dates': 'Dates',
      'start_date': 'Start Date',
      'end_date': 'End Date',
      'expiry_date': 'Expiry Date',
      'active_for': 'Active for',

      // Actions
      'request_extension': 'Request Extension',
      'charge_subscription': 'Charge Subscription',

      // Messages
      'extension_success': 'Subscription extended successfully',
      'extension_failed': 'Failed to extend subscription',
      'no_service_types': 'No service types available',

      // Finance
      'financial_transactions': 'Financial Transactions',
      'transaction_type': 'Transaction Type',
      'credit': 'Credit to Account',
      'debit': 'Debit from Account',
      'amount': 'Amount',
      'currency': 'Currency',
      'date_time': 'Date & Time',
      'description': 'Description',
      'external_ref': 'External Ref',

      // UI
      'show_details': 'Show Details',
      'personal_info': 'Personal Info',
      'accounts': 'Accounts',
      'sessions': 'Sessions',
      'full_name': 'Full Name',
      'mobile_number': 'Mobile Number',
      'email_address': 'Email Address',
      'status': 'Status',
    },
  };
  String t(String key) {
    return _data[locale.languageCode]?[key] ?? key;
  }
}

const double gb = 1024 * 1024 * 1024;

double toGB(int bytes) => bytes / 1024 / 1024 / 1024;

String formatGB(int bytes) => toGB(bytes).toStringAsFixed(2);

double percent(int used, int limit) => limit == 0 ? 0 : (used / limit) * 100;

// تحويل ثواني إلى ساعات ودقائق
String secondsToHMS(int seconds) {
  final h = seconds ~/ 3600;
  final m = (seconds % 3600) ~/ 60;
  return '${h}h ${m}m';
}

/// تحويل تاريخ UTC String إلى صيغة جميلة محلية
String formatDateUTC(String utcDateStr) {
  final dt = DateTime.parse(utcDateStr).toUtc();
  return DateFormat('MMMM d, yyyy').format(dt.toLocal());
}

/// حساب الفرق بين تاريخ النهاية وتاريخ اليوم (Remaining Days)
int remainingDays(String expiryDateStr) {
  final expiry = DateTime.parse(expiryDateStr).toUtc().toLocal();
  final now = DateTime.now();
  return expiry.difference(now).inDays;
}

/// حساب عدد الأيام النشطة من بداية الاشتراك حتى اليوم
int activeDays(String startDateStr, String expiryDateStr) {
  final start = DateTime.parse(startDateStr).toUtc().toLocal();
  final expiry = DateTime.parse(expiryDateStr).toUtc().toLocal();
  final now = DateTime.now();
  if (now.isBefore(start)) return 0;
  if (now.isAfter(expiry)) return expiry.difference(start).inDays;
  return now.difference(start).inDays;
}

/// حساب نسبة الاستخدام
double usagePercent(double used, double limit) {
  if (limit == 0) return 0.0;
  return used / limit; // لـ LinearProgressIndicator تحتاج 0.0 - 1.0
}

String _formatDate(String dateString) {
  final date = DateTime.parse(dateString);
  return "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
}

/// تحويل من Octets إلى GB
double octetsToGB(int octets) => octets / 1024 / 1024 / 1024;
String getUsernameLabel(BuildContext context, String tt) {
  final t = L.of(context)!;
  return t.t(tt);
}

class SubscriptionDetailsScreen extends StatefulWidget {
  final SubscriptionDTO s;
  final String token;

  const SubscriptionDetailsScreen({
    super.key,
    required this.s,
    required this.token,
  });

  @override
  State<SubscriptionDetailsScreen> createState() =>
      _SubscriptionDetailsScreenState();
}

class _SubscriptionDetailsScreenState extends State<SubscriptionDetailsScreen> {
  late SubscriptionDTO s;
  final customerService = CustomerService();

  @override
  void initState() {
    super.initState();
    s = widget.s;
  }

  @override
  Widget build(BuildContext context) {
    final t = L.of(context)!;
    String _formatDate(String dateString) {
      final date = DateTime.parse(dateString);
      return "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
    }

    // حساب القيم
    final downloadGB = octetsToGB(s.currentInputOctets);
    final uploadGB = octetsToGB(s.currentOutputOctets);
    final totalGB = downloadGB + uploadGB;

    final downloadLimitGB = octetsToGB(s.serviceDownloadLimit);
    final uploadLimitGB = octetsToGB(s.serviceUploadLimit);
    final totalLimitGB = downloadLimitGB + uploadLimitGB;

    final remainingDownloadGB = downloadLimitGB - downloadGB;
    final remainingUploadGB = uploadLimitGB - uploadGB;
    final remainingTotalGB = totalLimitGB - totalGB;

    final downloadPercent = downloadGB / downloadLimitGB;
    final uploadPercent = uploadGB / uploadLimitGB;
    final totalPercent = totalGB / totalLimitGB;

    final activeDaysValue = activeDays(s.startDate, s.expiryDate);
    final remainingDaysValue = remainingDays(s.expiryDate);

    final usageRate = totalLimitGB > 0 ? (totalGB / totalLimitGB) * 100 : 0.0;

    return Scaffold(
      backgroundColor: AppColors.primary200.withOpacity(0.05),
      appBar: AppBar(
        backgroundColor: AppColors.primary600,
        title: Text(
          s.serviceName,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔹 Status
            Align(
              alignment: Alignment.centerLeft,
              child: Chip(
                label: Text(
                  s.online ? t.t('online') : t.t('offline'),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                backgroundColor: s.online
                    ? AppColors.success.withOpacity(0.2)
                    : Colors.grey.shade300,
              ),
            ),
            const SizedBox(height: 12),

            // 🔹 Service Info Card
            _sectionCard(
              t.t('service_information'),
              children: [
                infoRow(t.t('subscription_id'), s.subscriptionId.toString()),
                infoRow(t.t('service_name'), s.serviceName),
                infoRow(t.t('service_type'), s.serviceType),
                infoRow(t.t('username'), s.username),
                infoRow(t.t('vip_user'), 'No'),
                infoRow(t.t('grace_period'), '${s.graceTimeDays} days'),
              ],
            ),

            // 🔹 Usage Info
            _sectionCard(
              t.t('usage_information'),
              children: [
                infoRow(t.t('download'), '${downloadGB.toStringAsFixed(2)} GB'),
                infoRow(t.t('upload'), '${uploadGB.toStringAsFixed(2)} GB'),
                infoRow(t.t('total_usage'), '${totalGB.toStringAsFixed(2)} GB'),
              ],
            ),

            // 🔹 Limits
            _sectionCard(
              t.t('limits_settings'),
              children: [
                infoRow(
                  t.t('download_limit'),
                  '${downloadLimitGB.toStringAsFixed(2)} GB',
                ),
                infoRow(
                  t.t('upload_limit'),
                  '${uploadLimitGB.toStringAsFixed(2)} GB',
                ),
                infoRow(
                  t.t('current_session_time'),
                  secondsToHMS(s.currentSessionsTime),
                ),
                infoRow(t.t('total_sessions_time'), '0h 0m'),
              ],
            ),

            // 🔹 Usage Progress
            _sectionCard(
              t.t('usage_progress'),
              children: [
                usageProgressRow(
                  t.t('Download'),
                  downloadGB,
                  downloadLimitGB,
                  remainingDownloadGB,
                  downloadPercent,
                ),
                usageProgressRow(
                  t.t('Upload'),
                  uploadGB,
                  uploadLimitGB,
                  remainingUploadGB,
                  uploadPercent,
                ),
                usageProgressRow(
                  t.t('Total Data'),
                  totalGB,
                  totalLimitGB,
                  remainingTotalGB,
                  totalPercent,
                ),
                infoRow(t.t('remaining_days'), '$remainingDaysValue'),
                infoRow(t.t('usage_rate'), '${usageRate.toStringAsFixed(1)}%'),
              ],
            ),

            // 🔹 Dates
            _sectionCard(
              t.t('dates'),
              children: [
                infoRow(t.t('start_date'), s.startDate),
                infoRow(t.t('expiry_date'), _formatDate(s.expiryDate)),
                infoRow(t.t('active_for'), '$activeDaysValue days'),
              ],
            ),

            // 🔹 Actions Buttons
            _sectionCard(
              t.t('actions'),
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary600,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  onPressed: () async {
                    try {
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (_) =>
                            const Center(child: CircularProgressIndicator()),
                      );

                      await customerService.requestExtension(
                        s.subscriptionId,
                        widget.token,
                      );

                      final updated = await customerService
                          .getSubscriptionDetails(
                            s.subscriptionId,
                            widget.token,
                          );

                      if (!mounted) return;
                      Navigator.pop(context);

                      setState(() => s = updated);

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(t.t('extension_success')),
                          backgroundColor: Colors.green,
                        ),
                      );
                    } catch (e) {
                      if (!mounted) return;
                      Navigator.pop(context);

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(t.t('extension_failed')),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
                  child: Text(
                    t.t('request_extension'),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 8),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.primary600,
                    side: BorderSide(color: AppColors.primary600),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  onPressed: null,
                  child: Text(t.t('charge_subscription')),
                ),
                const SizedBox(height: 8),
                Text(
                  t.t('no_service_types'),
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------- Helper Widgets ----------------
Widget _sectionCard(String title, {required List<Widget> children}) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 10),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      gradient: LinearGradient(
        colors: [
          AppColors.primary100.withOpacity(0.4),
          AppColors.primary200.withOpacity(0.5),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      boxShadow: [
        BoxShadow(
          color: AppColors.primary400.withOpacity(0.25),
          blurRadius: 20,
          offset: const Offset(0, 12),
        ),
      ],
    ),
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.black87,
            ),
          ),
          const Divider(),
          ...children,
        ],
      ),
    ),
  );
}

Widget usageProgressRow(
  String title,
  double used,
  double limit,
  double remaining,
  double percent,
) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        '$title: ${used.toStringAsFixed(2)} / ${limit.toStringAsFixed(2)} GB',
        style: const TextStyle(color: Colors.black87),
      ),
      const SizedBox(height: 4),
      ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: LinearProgressIndicator(
          value: percent.clamp(0.0, 1.0),
          minHeight: 10,
          backgroundColor: AppColors.primary100.withOpacity(0.3),
          valueColor: AlwaysStoppedAnimation(AppColors.primary600),
        ),
      ),
      Text(
        'Remaining: ${remaining.toStringAsFixed(2)} GB',
        style: const TextStyle(color: Colors.black87),
      ),
      const SizedBox(height: 8),
    ],
  );
}

Widget infoRow(String title, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: const TextStyle(color: Colors.black54)),
        Text(value, style: const TextStyle(fontWeight: FontWeight.w500)),
      ],
    ),
  );
}

// Format date
String formatDate(DateTime utc) {
  return DateFormat('MMMM d, yyyy').format(utc.toLocal());
}

class _TransfersView extends StatefulWidget {
  final String user;
  final String balance;
  final String token;

  const _TransfersView({
    required this.user,
    required this.balance,
    required this.token,
  });

  @override
  State<_TransfersView> createState() => _TransfersViewState();
}

class _TransfersViewState extends State<_TransfersView> {
  final CustomerService service = CustomerService();
  final ScrollController _scroll = ScrollController();

  List<Map<String, dynamic>> transactions = [];
  int page = 0;
  bool loading = false;
  bool hasMore = true;
  int total = 0;

  @override
  void initState() {
    super.initState();
    loadMore();

    _scroll.addListener(() {
      if (_scroll.position.pixels >= _scroll.position.maxScrollExtent - 200 &&
          !loading &&
          hasMore) {
        loadMore();
      }
    });
  }

  Future<void> loadMore() async {
    setState(() => loading = true);

    final res = await service.getTransactions(
      widget.token,
      page: page,
      size: 10,
    );

    setState(() {
      transactions.addAll(
        (res['content'] as List).cast<Map<String, dynamic>>(),
      );
      total = res['totalElements'];
      hasMore = !res['last'];
      page++;
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final t = L.of(context)!;

    return ListView(
      controller: _scroll,
      padding: const EdgeInsets.all(16),
      children: [
        const SizedBox(height: 16),

        Text(
          t.t('financial_transactions'),
          style: Theme.of(context).textTheme.titleLarge,
        ),

        Text('$total transactions', style: const TextStyle(color: Colors.grey)),

        const SizedBox(height: 16),

        ...transactions.map((tx) => transactionCard(context, tx)),

        if (loading)
          const Padding(
            padding: EdgeInsets.all(16),
            child: Center(child: CircularProgressIndicator()),
          ),
      ],
    );
  }
}

// 🔹 Sessions Tab باستخدام PaginatedDataTable
class SessionsTab extends StatefulWidget {
  final String token;
  const SessionsTab({super.key, required this.token});

  @override
  State<SessionsTab> createState() => _SessionsTabState();
}

class _SessionsTabState extends State<SessionsTab> {
  final _controller = ScrollController();
  final _searchCtrl = TextEditingController();

  List<dynamic> sessions = [];
  int page = 0;
  final int size = 20;
  bool loading = false;
  bool hasMore = true;
  int totalSessions = 0;

  DateTime? fromDate;
  DateTime? toDate;

  @override
  void initState() {
    super.initState();
    fetchMore();

    _controller.addListener(() {
      if (_controller.position.pixels >
              _controller.position.maxScrollExtent - 300 &&
          !loading &&
          hasMore) {
        fetchMore();
      }
    });
  }

  Future<void> fetchMore({bool reset = false}) async {
    if (loading) return;

    if (reset) {
      page = 0;
      sessions.clear();
      hasMore = true;
    }

    setState(() => loading = true);

    final res = await CustomerService().getSessions(
      widget.token,
      page: page,
      size: size,
      search: _searchCtrl.text.trim(),
      from: fromDate,
      to: toDate,
    );

    final List content = res['content'] ?? [];

    setState(() {
      sessions.addAll(content);
      totalSessions = res['totalElements'] ?? sessions.length;
      hasMore = content.length == size;
      page++;
      loading = false;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 🔍 Search
        Padding(
          padding: const EdgeInsets.all(12),
          child: TextField(
            controller: _searchCtrl,
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.search),
              hintText: 'Search username',
            ),
            onSubmitted: (_) => fetchMore(reset: true),
          ),
        ),

        // 📅 Filters
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              child: const Text('From date'),
              onPressed: () async {
                fromDate = await showDatePicker(
                  context: context,
                  firstDate: DateTime(2020),
                  lastDate: DateTime.now(),
                );
                fetchMore(reset: true);
              },
            ),
            TextButton(
              child: const Text('To date'),
              onPressed: () async {
                toDate = await showDatePicker(
                  context: context,
                  firstDate: DateTime(2020),
                  lastDate: DateTime.now(),
                );
                fetchMore(reset: true);
              },
            ),
          ],
        ),

        Padding(
          padding: const EdgeInsets.all(8),
          child: Text(
            'Total Sessions: $totalSessions',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),

        // ⚡ Infinite list
        Expanded(
          child: ListView.builder(
            controller: _controller,
            itemCount: sessions.length + (hasMore ? 1 : 0),
            itemBuilder: (context, i) {
              if (i >= sessions.length) {
                return const Padding(
                  padding: EdgeInsets.all(16),
                  child: Center(child: CircularProgressIndicator()),
                );
              }
              return sessionCard(context, sessions[i]);
            },
          ),
        ),
      ],
    );
  }
}

// 🔹 DataTable Source
class SessionDataTableSource extends DataTableSource {
  final List<dynamic> sessions;
  SessionDataTableSource(this.sessions);

  @override
  DataRow? getRow(int index) {
    if (index >= sessions.length) return null;
    final s = sessions[index];
    final start = DateTime.tryParse(s['startTime'] ?? '')?.toLocal();
    final end = s['endTime'] != null
        ? DateTime.tryParse(s['endTime'])?.toLocal()
        : null;
    final uploadMB = ((s['inputOctects'] ?? 0) / 1024 / 1024).toStringAsFixed(
      2,
    );
    final downloadMB = ((s['outputOctets'] ?? 0) / 1024 / 1024).toStringAsFixed(
      2,
    );
    final totalMB = (double.parse(uploadMB) + double.parse(downloadMB))
        .toStringAsFixed(2);

    String format(DateTime? dt) {
      if (dt == null) return 'Now';
      return '${dt.year}-${dt.month.toString().padLeft(2, '0')}-${dt.day.toString().padLeft(2, '0')} '
          '${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
    }

    return DataRow(
      cells: [
        DataCell(Text(s['username'] ?? '')),
        DataCell(Text(format(start))),
        DataCell(Text(format(end))),
        DataCell(Text(uploadMB)),
        DataCell(Text(downloadMB)),
        DataCell(Text(totalMB)),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => sessions.length;

  @override
  int get selectedRowCount => 0;
}

class LDelegate extends LocalizationsDelegate<L> {
  const LDelegate();

  @override
  bool isSupported(Locale locale) => ['ar', 'en'].contains(locale.languageCode);

  @override
  Future<L> load(Locale locale) async {
    return L(locale);
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<L> old) => false;
}

class Subscription {
  final int id;
  final String serviceName;
  final String username;
  final String serviceType;
  final bool online;
  final double downloadLimit;
  final double usage;

  Subscription({
    required this.id,
    required this.serviceName,
    required this.username,
    required this.serviceType,
    required this.online,
    required this.downloadLimit,
    required this.usage,
  });

  factory Subscription.fromJson(Map<String, dynamic> json) {
    return Subscription(
      id: json['id'],
      serviceName: json['serviceName'],
      username: json['username'],
      serviceType: json['serviceType'],
      online: json['online'],
      downloadLimit: (json['downloadLimit'] ?? 0).toDouble(),
      usage: (json['usage'] ?? 0).toDouble(),
    );
  }
}

/* ------------------ App ------------------ */
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale = const Locale('ar');

  void setLang(String code) {
    setState(() {
      _locale = Locale(code);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      /// ✅ اللغة الحالية (هذا الذي يغيّر النصوص فعلًا)
      locale: _locale,

      /// ✅ اللغات المدعومة
      supportedLocales: const [Locale('ar'), Locale('en')],

      /// ✅ بدونها الترجمة لا تعمل
      localizationsDelegates: const [
        LDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],

      /// 🌙☀️ الوضع التلقائي حسب النظام
      themeMode: ThemeMode.system,

      /// ☀️ Light Theme (Material 3)
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.blue,
        brightness: Brightness.light,
        fontFamily: 'Roboto', // اختياري
      ),

      /// 🌙 Dark Theme (Material 3)
      darkTheme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.blue,
        brightness: Brightness.dark,
        fontFamily: 'Roboto', // اختياري
      ),

      /// 🏠 أول شاشة
      home: SplashScreen(onLangChange: setLang),
    );
  }
}

// ----------------- LoginScreen -----------------
class LoginScreen extends StatefulWidget {
  final Function(String) onLangChange;
  const LoginScreen({super.key, required this.onLangChange});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  final u = TextEditingController();
  final p = TextEditingController();
  String error = '';
  bool showPassword = false;
  bool loading = false;

  late AnimationController _animController;
  late Animation<double> _fadeAnim;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {});

    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _fadeAnim = CurvedAnimation(parent: _animController, curve: Curves.easeIn);
    _animController.forward();
  }

  @override
  void dispose() {
    _animController.dispose();
    u.dispose();
    p.dispose();
    super.dispose();
  }

  void login() async {
    setState(() {
      error = '';
      loading = true;
    });

    if (u.text.trim().isEmpty || p.text.trim().isEmpty) {
      setState(() {
        error = 'الرجاء إدخال اسم المستخدم وكلمة المرور';
        loading = false;
      });
      return;
    }

    final auth = AuthService();
    try {
      final res = await auth.login(
        username: u.text.trim(),
        password: p.text.trim(),
      );
      final token = res['accessToken'];

      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => HomeScreen(
            username: u.text.trim(),
            onLangChange: widget.onLangChange,
            token: token,
          ),
        ),
      );
    } catch (e) {
      if (!mounted) return;
      setState(() => error = 'خطأ في تسجيل الدخول، حاول مرة أخرى');
    } finally {
      if (mounted) setState(() => loading = false);
    }
  }

  Widget _bgGlow(double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.primary300.withOpacity(0.12),
      ),
    );
  }

  InputDecoration _inputDecoration({
    required IconData icon,
    required String label,
    Widget? suffix,
  }) {
    return InputDecoration(
      labelText: label,
      labelStyle: TextStyle(
        color: Colors.white.withOpacity(0.8),
        fontWeight: FontWeight.w500,
      ),
      prefixIcon: Icon(icon, color: Colors.white70),
      suffixIcon: suffix,
      filled: true,
      fillColor: Colors.white.withOpacity(0.05),
      contentPadding: const EdgeInsets.symmetric(vertical: 18),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: BorderSide(color: Colors.white.withOpacity(0.15)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: BorderSide(color: AppColors.primary200, width: 1.5),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = L.of(context);

    return Scaffold(
      body: FadeTransition(
        opacity: _fadeAnim,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.primary400.withOpacity(0.95),
                AppColors.primary500.withOpacity(0.90),
                AppColors.primary400.withOpacity(0.85),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Stack(
            children: [
              /// 🌫️ خلفية دوائر ضوئية خفيفة
              Positioned(top: -100, left: -60, child: _bgGlow(220)),
              Positioned(bottom: -120, right: -80, child: _bgGlow(260)),

              Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 28,
                    vertical: 24,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      /// 🔥 شعار alfateh
                      Image.asset("assets/alfateh.png", width: 130),
                      const SizedBox(height: 12),

                      const Text(
                        "ALFATEH ISP",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.6,
                          shadows: [
                            Shadow(
                              color: Colors.black38,
                              blurRadius: 8,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 36),

                      /// 💎 Glass Login Card
                      /// 💎 Glass Login Card
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.07),
                          borderRadius: BorderRadius.circular(28),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.15),
                            width: 1,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.35),
                              blurRadius: 40,
                              offset: const Offset(0, 20),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(28),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                            child: Padding(
                              padding: const EdgeInsets.all(26),
                              child: Column(
                                children: [
                                  /// Username
                                  TextField(
                                    controller: u,
                                    style: const TextStyle(color: Colors.white),
                                    decoration: _inputDecoration(
                                      icon: Icons.person,
                                      label: t?.t('username') ?? 'Username',
                                    ),
                                  ),

                                  const SizedBox(height: 18),

                                  /// Password
                                  TextField(
                                    controller: p,
                                    obscureText: !showPassword,
                                    style: const TextStyle(color: Colors.white),
                                    decoration: _inputDecoration(
                                      icon: Icons.lock,
                                      label: t?.t('password') ?? 'Password',
                                      suffix: IconButton(
                                        icon: Icon(
                                          showPassword
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                          color: AppColors.primary200,
                                        ),
                                        onPressed: () => setState(
                                          () => showPassword = !showPassword,
                                        ),
                                      ),
                                    ),
                                  ),

                                  const SizedBox(height: 18),

                                  if (error.isNotEmpty)
                                    Text(
                                      error,
                                      style: const TextStyle(
                                        color: AppColors.danger,
                                      ),
                                    ),

                                  const SizedBox(height: 20),

                                  /// زر الدخول
                                  SizedBox(
                                    width: double.infinity,
                                    height: 55,
                                    child: DecoratedBox(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(18),
                                        gradient: LinearGradient(
                                          colors: [
                                            AppColors.primary500,
                                            AppColors.primary600,
                                          ],
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: AppColors.primary400
                                                .withOpacity(0.5),
                                            blurRadius: 20,
                                            offset: const Offset(0, 10),
                                          ),
                                        ],
                                      ),
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.transparent,
                                          shadowColor: Colors.transparent,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              18,
                                            ),
                                          ),
                                        ),
                                        onPressed: loading ? null : login,
                                        child: loading
                                            ? const CircularProgressIndicator(
                                                color: Colors.white,
                                              )
                                            : Text(
                                                t?.t('login') ?? 'Login',
                                                style: const TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                  letterSpacing: 1.1,
                                                ),
                                              ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 50),

                      /// Footer
                      Column(
                        children: [
                          const Divider(color: Colors.white24),
                          const SizedBox(height: 12),
                          const Text(
                            'نصل اليك اينما كنت',
                            style: TextStyle(
                              color: Color.fromARGB(179, 12, 10, 10),
                              fontSize: 13,
                            ),
                          ),
                          const SizedBox(height: 6),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/* ------------------ Home ------------------ */
class HomeScreen extends StatefulWidget {
  final String username;
  final Function(String) onLangChange;
  final String token;

  const HomeScreen({
    super.key,
    required this.username,
    required this.onLangChange,
    required this.token,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  int _currentIndex = 0;

  Map<String, dynamic>? _accountData;
  late AnimationController _glowController;

  @override
  void initState() {
    super.initState();
    _glowController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final t = L.of(context)!; // القاموس للترجمة

      bool success = await _loadAccountData();

      if (!success && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(t.t('load_failed')), // مفتاح الترجمة
            backgroundColor: Colors.redAccent,
          ),
        );
      }
    });
  }

  Future<bool> _loadAccountData() async {
    try {
      final data = await fetchAccountData(widget.token);
      if (mounted) {
        setState(() {
          _accountData = data;
        });
      }
      return true; // ✅ التحميل ناجح
    } catch (_) {
      if (mounted) {
        setState(() {
          _accountData = {'error': 'failed'}; // مجرد علامة خطأ
        });
      }
      return false; // ❌ التحميل فشل
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = L.of(context);

    final personalInfo = _accountData?['personalInfo'] ?? {};
    final accounts = _accountData?['accounts'] as List<dynamic>? ?? [];

    final fullName = personalInfo['fullName'] ?? widget.username;
    final balanceText = accounts.isNotEmpty
        ? '${accounts[0]['balance']} ${accounts[0]['currency']}'
        : '—';

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,

      /// 🔹 AppBar محسّن للوضوح
      appBar: _buildPremiumHeader(
        context,
        fullName,
        balanceText,
        widget.onLangChange,
      ),

      body: Stack(
        children: [
          /// 🔹 الخلفية المتدرجة مع حركة Glow
          AnimatedBuilder(
            animation: _glowController,
            builder: (context, _) {
              return Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.primary800, // غامق
                      AppColors.primary600, // متوسط
                      AppColors.primary500, // فاتح
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary300.withOpacity(
                        0.15 + (0.15 * sin(_glowController.value * 2 * pi)),
                      ),
                      blurRadius: 120,
                      spreadRadius: 30,
                    ),
                  ],
                ),
              );
            },
          ),

          /// 🔹 المحتوى الثابت
          SafeArea(
            child: _accountData == null
                ? const Center(
                    child: CircularProgressIndicator(color: Colors.white),
                  )
                : _accountData!.containsKey('error')
                ? const Center(
                    child: Text(
                      'Failed to load data',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                : AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    transitionBuilder: (child, animation) {
                      return FadeTransition(
                        opacity: animation,
                        child: SlideTransition(
                          position: Tween<Offset>(
                            begin: const Offset(0.1, 0),
                            end: Offset.zero,
                          ).animate(animation),
                          child: child,
                        ),
                      );
                    },
                    child: IndexedStack(
                      key: ValueKey(_currentIndex),
                      index: _currentIndex,
                      children: [
                        /// 🔹 الخدمات
                        Container(
                          color: Colors.transparent,
                          child: servicesTab(context, widget.token),
                        ),

                        /// 🔹 الاشتراكات
                        Container(
                          color: Colors.transparent,
                          child: subscriptionsTab(
                            context,
                            fullName,
                            balanceText,
                            widget.token,
                          ),
                        ),

                        /// 🔹 الحساب
                        Container(
                          color: Colors.transparent,
                          child: accountTab(context, widget.token),
                        ),

                        /// 🔹 التحويلات
                        Container(
                          color: Colors.transparent,
                          child: transfersTab(
                            context,
                            fullName,
                            balanceText,
                            widget.token,
                          ),
                        ),

                        /// 🔹 الجلسات
                        Container(
                          color: Colors.transparent,
                          child: SessionsTab(token: widget.token),
                        ),
                      ],
                    ),
                  ),
          ),
        ],
      ),

      /// 🔹 Bottom Nav محسّن
      bottomNavigationBar: _buildPremiumBottomNav(context),
    );
  }

  /// ---------------- Premium Glass Header محسّن للنصوص
  PreferredSizeWidget _buildPremiumHeader(
    BuildContext context,
    String username,
    String balance,
    Function(String) onLangChange,
  ) {
    final t = L.of(context);

    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      toolbarHeight: 95,
      flexibleSpace: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          child: Container(color: AppColors.primary500.withOpacity(0.25)),
        ),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// اسم الشبكة
          Text(
            'ALFATEH ISP',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Colors.white,
              shadows: [
                Shadow(
                  color: Colors.black45,
                  blurRadius: 4,
                  offset: Offset(1, 1),
                ),
              ],
            ),
          ),

          /// اسم المستخدم
          Text(
            username,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.white,
              fontSize: 15,
            ),
          ),

          /// الرصيد
          Text(
            '${t?.t('balance')}: $balance',
            style: const TextStyle(fontSize: 13, color: Colors.white70),
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.refresh, color: Colors.white),
          onPressed: _loadAccountData,
        ),
        PopupMenuButton<String>(
          onSelected: onLangChange,
          icon: const Icon(Icons.language, color: Colors.white),
          itemBuilder: (_) => const [
            PopupMenuItem(value: 'ar', child: Text('عربي')),
            PopupMenuItem(value: 'en', child: Text('English')),
          ],
        ),
        IconButton(
          icon: const Icon(Icons.logout, color: Colors.redAccent),
          onPressed: () async {
            await AuthService.logout();
            if (!context.mounted) return;
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (_) => LoginScreen(onLangChange: onLangChange),
              ),
              (_) => false,
            );
          },
        ),
      ],
    );
  }

  /// ---------------- Premium Bottom Nav محسّن للنصوص
  Widget _buildPremiumBottomNav(BuildContext context) {
    final t = L.of(context);

    return NavigationBar(
      selectedIndex: _currentIndex,
      onDestinationSelected: (index) => setState(() => _currentIndex = index),
      height: 70,
      backgroundColor: AppColors.primary800,
      indicatorColor: AppColors.primary200,
      labelTextStyle: MaterialStateProperty.all(
        const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
      ),
      destinations: [
        NavigationDestination(
          icon: const Icon(Icons.miscellaneous_services_outlined),
          selectedIcon: const Icon(Icons.miscellaneous_services),
          label: t?.t('services') ?? 'Services',
        ),
        NavigationDestination(
          icon: const Icon(Icons.assignment_outlined),
          selectedIcon: const Icon(Icons.assignment),
          label: t?.t('subscriptions') ?? 'Subscriptions',
        ),
        NavigationDestination(
          icon: const Icon(Icons.person_outline),
          selectedIcon: const Icon(Icons.person),
          label: t?.t('account') ?? 'Account',
        ),
        NavigationDestination(
          icon: const Icon(Icons.swap_horiz_outlined),
          selectedIcon: const Icon(Icons.swap_horiz),
          label: t?.t('transfers') ?? 'Transfers',
        ),
        NavigationDestination(
          icon: const Icon(Icons.timer_outlined),
          selectedIcon: const Icon(Icons.timer),
          label: t?.t('sessions') ?? 'Sessions',
        ),
      ],
    );
  }
}

/* ------------------ Tabs ------------------ */
//* ------------------ Tab الاشتراكات ------------------ */
Widget servicesTab(BuildContext context, String token) {
  final customerService = CustomerService();

  return FutureBuilder<List<SubscriptionDTO>>(
    future: customerService
        .getSubscriptions(token)
        .then((list) => list.map((e) => SubscriptionDTO.fromJson(e)).toList()),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(child: CircularProgressIndicator());
      }

      if (snapshot.hasError) {
        return Center(child: Text('Error: ${snapshot.error}'));
      }

      final subs = snapshot.data ?? [];

      if (subs.isEmpty) {
        return const Center(child: Text('No services found'));
      }

      return ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: subs.length,
        itemBuilder: (_, i) {
          return ServiceSubscriptionCard(subscription: subs[i], token: token);
        },
      );
    },
  );
}

class ServiceSubscriptionCard extends StatefulWidget {
  final SubscriptionDTO subscription;
  final String token;

  const ServiceSubscriptionCard({
    super.key,
    required this.subscription,
    required this.token,
  });

  @override
  State<ServiceSubscriptionCard> createState() =>
      _ServiceSubscriptionCardState();
}

class _ServiceSubscriptionCardState extends State<ServiceSubscriptionCard> {
  late SubscriptionDTO s;

  final customerService = CustomerService();
  final tKey = L;

  @override
  void initState() {
    super.initState();
    s = widget.subscription;
  }

  @override
  Widget build(BuildContext context) {
    final t = L.of(context)!;
    final bool isOnline = s.online == true;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(26),
        gradient: LinearGradient(
          colors: [
            AppColors.primary800.withOpacity(0.85),
            AppColors.primary600.withOpacity(0.85),
            AppColors.primary500.withOpacity(0.85),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(color: AppColors.primary200.withOpacity(0.3)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.35),
            blurRadius: 25,
            offset: const Offset(0, 15),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// 🔹 العنوان + الحالة
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      const Icon(Icons.wifi, color: Colors.white, size: 22),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          s.serviceName ?? '-',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: isOnline ? AppColors.success : AppColors.danger,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: (isOnline ? AppColors.success : AppColors.danger)
                            .withOpacity(0.5),
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  child: Text(
                    isOnline ? t.t('online') : t.t('offline'),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 22),

            premiumRow(Icons.person, t.t('username'), s.username ?? '-'),
            premiumRow(Icons.category, t.t('Type'), s.serviceType ?? '-'),
            premiumRow(
              Icons.calendar_today,
              t.t('expiry_date'),
              s.expiryDate ?? '-',
            ),

            const SizedBox(height: 24),

            /// 🔹 الأزرار
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.update, size: 18),
                    label: Text(t.t('request_extension')),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary500,
                      foregroundColor: Colors.white,
                      elevation: 4,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    onPressed: () async {
                      try {
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (_) =>
                              const Center(child: CircularProgressIndicator()),
                        );

                        await customerService.requestExtension(
                          s.subscriptionId,
                          widget.token,
                        );

                        final updated = await customerService
                            .getSubscriptionDetails(
                              s.subscriptionId,
                              widget.token,
                            );

                        if (!mounted) return;
                        Navigator.pop(context);

                        setState(() => s = updated);

                        _showSnack(context, t.t('extension_success'));
                      } catch (_) {
                        if (!mounted) return;
                        Navigator.pop(context);
                        _showSnack(
                          context,
                          t.t('extension_failed'),
                          error: true,
                        );
                      }
                    },
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: OutlinedButton.icon(
                    icon: const Icon(Icons.flash_on, size: 18),
                    label: Text(t.t('charge_service')),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.white,
                      side: BorderSide(
                        color: AppColors.primary200.withOpacity(0.5),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    onPressed: () {
                      _showServiceTypeDialog(
                        context,
                        widget.token,
                        s.subscriptionId,
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Widget premiumRow(IconData icon, String title, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10),
    child: Row(
      children: [
        Icon(icon, color: Colors.white54, size: 18),
        const SizedBox(width: 12),
        Expanded(
          flex: 3,
          child: Text(
            title,
            style: TextStyle(
              color: Colors.white70, // secondary text
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Expanded(
          flex: 4,
          child: Text(
            value,
            textAlign: TextAlign.end,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    ),
  );
}

void _showServiceTypeDialog(
  BuildContext context,
  String token,
  int subscriptionId,
) async {
  final serviceActions = ServiceActionsService();
  final t = L.of(context)!;

  try {
    final types = await serviceActions.getServiceTypes(token);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.7,
          minChildSize: 0.4,
          maxChildSize: 0.95,
          builder: (_, controller) {
            return Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.primary800, AppColors.primary700],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(28),
                ),
              ),
              child: Column(
                children: [
                  Container(
                    width: 40,
                    height: 5,
                    margin: const EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                      color: Colors.white38,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),

                  Text(
                    t.t('select_service_type'),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 20),

                  Expanded(
                    child: ListView.builder(
                      controller: controller,
                      itemCount: types.length,
                      itemBuilder: (_, i) {
                        final s = types[i];
                        return _modernServiceCard(
                          context,
                          s,
                          token,
                          subscriptionId,
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  } catch (_) {
    _showSnack(context, t.t('failed_load_service_types'), error: true);
  }
}

Widget _modernServiceCard(
  BuildContext context,
  Map service,
  String token,
  int subscriptionId,
) {
  final t = L.of(context)!;

  return GestureDetector(
    onTap: () {
      Navigator.pop(context);
      _showServiceDetails(context, service, token, subscriptionId);
    },
    child: Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.06),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withOpacity(0.15)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// 🔥 اسم الباقة
          Text(
            service['serviceTypeName'],
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 6),

          Text(
            "${service['price']} ${service['currency']}",
            style: const TextStyle(
              color: AppColors.primary200,
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 16),

          /// 📊 تفاصيل
          Row(
            children: [
              Expanded(
                child: _infoItem(
                  icon: Icons.download_rounded,
                  label: t.t('download_speed'),
                  value: _formatSpeed(service['downloadSpeedBits']),
                ),
              ),
              Expanded(
                child: _infoItem(
                  icon: Icons.upload_rounded,
                  label: t.t('upload_speed'),
                  value: _formatSpeed(service['uploadSpeedBits']),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          Row(
            children: [
              Expanded(
                child: _infoItem(
                  icon: Icons.data_usage_rounded,
                  label: t.t('download_limit'),
                  value: _formatBytes(service['downloadLimitBytes']),
                ),
              ),
              Expanded(
                child: _infoItem(
                  icon: Icons.cloud_upload_rounded,
                  label: t.t('upload_limit'),
                  value: _formatBytes(service['uploadLimitBytes']),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

Widget _infoItem({
  required IconData icon,
  required String label,
  required String value,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          Icon(icon, size: 16, color: AppColors.primary200),
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(color: Colors.white70, fontSize: 12),
          ),
        ],
      ),
      const SizedBox(height: 4),
      Text(
        value,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      ),
    ],
  );
}

String _formatSpeed(int bits) {
  final mbps = bits / 1000000;
  return "${mbps.toStringAsFixed(0)} Mbps";
}

String _formatBytes(int bytes) {
  final gb = bytes / (1024 * 1024 * 1024);
  return "${gb.toStringAsFixed(0)} GB";
}

void _showServiceDetails(
  BuildContext context,
  Map service,
  String token,
  int subscriptionId,
) {
  final serviceActions = ServiceActionsService();
  final t = L.of(context)!;

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) {
      return Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.primary800, AppColors.primary700],
          ),
          borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              service['serviceTypeName'],
              style: const TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            Text(
              "${service['price']} ${service['currency']}",
              style: const TextStyle(color: AppColors.primary200, fontSize: 18),
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  gradient: LinearGradient(
                    colors: [AppColors.primary500, AppColors.primary600],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary400.withOpacity(0.5),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  onPressed: () async {
                    Navigator.pop(context);

                    try {
                      await serviceActions.chargeServiceType(
                        token,
                        subscriptionId,
                        service['serviceTypeId'],
                      );

                      _showSnack(context, t.t('service_charged_success'));
                    } catch (_) {
                      _showSnack(
                        context,
                        t.t('service_charge_failed'),
                        error: true,
                      );
                    }
                  },
                  child: Text(
                    t.t('charge_now'),
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      );
    },
  );
}

void _showSnack(BuildContext context, String msg, {bool error = false}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(msg),
      backgroundColor: error ? Colors.redAccent : Colors.green,
    ),
  );
}

Widget _infoRow(IconData icon, String label, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      children: [
        Icon(icon, size: 18, color: Colors.blueGrey),
        const SizedBox(width: 8),
        Text('$label: ', style: const TextStyle(fontWeight: FontWeight.w600)),
        Expanded(child: Text(value)),
      ],
    ),
  );
}

Widget subscriptionsTab(
  BuildContext context,
  String username,
  String balanceText,
  String token,
) {
  final t = L.of(context)!;
  final customerService = CustomerService();

  return Container(
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          AppColors.primary800.withOpacity(0.85),
          AppColors.primary600.withOpacity(0.85),
          AppColors.primary500.withOpacity(0.85),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    ),
    child: FutureBuilder<List<dynamic>>(
      future: customerService.getSubscriptions(token),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(color: Colors.white),
          );
        }

        if (snapshot.hasError) {
          return Center(
            child: Text(
              'Error: ${snapshot.error}',
              style: const TextStyle(color: Colors.white),
            ),
          );
        }

        final subsData = snapshot.data ?? [];

        if (subsData.isEmpty) {
          return const Center(
            child: Text(
              'No subscriptions found',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          );
        }

        int onlineCount = subsData.where((s) => s['online'] == true).length;

        double totalDownload = subsData.fold(
          0,
          (sum, s) => sum + (s['currentInputOctets'] ?? 0),
        );

        double totalUpload = subsData.fold(
          0,
          (sum, s) => sum + (s['currentOutputOctets'] ?? 0),
        );

        return ListView(
          padding: const EdgeInsets.all(20),
          children: [
            /// 🔹 ملخص الاشتراكات
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: AppColors.primary900.withOpacity(0.3),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.25),
                    blurRadius: 30,
                    offset: const Offset(0, 15),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  _premiumSummaryRow(
                    Icons.wifi,
                    t.t('Online_Services'),
                    '$onlineCount / ${subsData.length}',
                  ),
                  const SizedBox(height: 20),
                  _premiumSummaryRow(
                    Icons.upload,
                    t.t('Total_Upload'),
                    '${(totalDownload / 1024 / 1024 / 1024).toStringAsFixed(2)} GB',
                  ),
                  const SizedBox(height: 20),
                  _premiumSummaryRow(
                    Icons.download,
                    t.t('Total_Download'),
                    '${(totalUpload / 1024 / 1024 / 1024).toStringAsFixed(2)} GB',
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            /// 🔹 كروت الاشتراكات
            ...subsData.map((s) {
              return TweenAnimationBuilder(
                duration: const Duration(milliseconds: 500),
                tween: Tween(begin: 0.0, end: 1.0),
                builder: (context, double value, child) {
                  return Opacity(
                    opacity: value,
                    child: Transform.translate(
                      offset: Offset(0, 40 * (1 - value)),
                      child: child,
                    ),
                  );
                },
                child: subscriptionDetailsCard(
                  context,
                  service: s['serviceName'] ?? '-',
                  username: s['username'] ?? '-',
                  type: s['serviceType'] ?? '-',
                  status: s['online'] == true ? 'Online' : 'Offline',
                  startDate: s['startDate'] ?? '-',
                  endDate: s['expiryDate'] ?? '-',
                  onShowDetails: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => SubscriptionDetailsScreen(
                          s: SubscriptionDTO.fromJson(s),
                          token: token,
                        ),
                      ),
                    );
                  },
                ),
              );
            }).toList(),
          ],
        );
      },
    ),
  );
}

Widget _premiumSummaryRow(IconData icon, String title, String value) {
  return Row(
    children: [
      Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColors.primary700.withOpacity(0.3),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Icon(icon, color: AppColors.neutral50, size: 20),
      ),
      const SizedBox(width: 14),
      Expanded(
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.white70,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      Text(
        value,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    ],
  );
}

Widget subscriptionDetailsCard(
  BuildContext context, {
  required String service,
  required String username,
  required String type,
  required String status,
  required String startDate,
  required String endDate,
  required VoidCallback onShowDetails,
}) {
  final t = L.of(context)!;
  final bool isOnline = status.toLowerCase() == 'online';

  return Container(
    margin: const EdgeInsets.only(bottom: 18),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          AppColors.primary800.withOpacity(0.85),
          AppColors.primary600.withOpacity(0.85),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(24),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.35),
          blurRadius: 25,
          offset: const Offset(0, 12),
        ),
      ],
      border: Border.all(color: AppColors.primary200.withOpacity(0.3)),
    ),
    padding: const EdgeInsets.all(20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// العنوان + حالة الاتصال
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                service,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              decoration: BoxDecoration(
                color: isOnline ? AppColors.success : AppColors.danger,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Text(
                status,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 18),

        detailRow(t.t('username'), username),
        detailRow(t.t('Type'), type),
        detailRow(t.t('start_date'), startDate),
        detailRow(t.t('expiry_date'), _formatDate(endDate)),

        const SizedBox(height: 20),

        /// زر عرض التفاصيل
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary500,
              foregroundColor: Colors.white,
              elevation: 4,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            onPressed: onShowDetails,
            child: Text(
              t.t('show_details'),
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget detailRow(String title, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.white70,
          ),
        ),
        Flexible(
          child: Text(
            value,
            textAlign: TextAlign.end,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget accountTab(BuildContext context, String token) {
  final t = L.of(context)!;

  return FutureBuilder<Map<String, dynamic>>(
    future: fetchAccountData(token),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(
          child: CircularProgressIndicator(color: Colors.white),
        );
      }

      if (snapshot.hasError) {
        return Center(
          child: Text(
            'Error: ${snapshot.error}',
            style: const TextStyle(color: Colors.white),
          ),
        );
      }

      final data = snapshot.data!;
      final personalInfo = data['personalInfo'];
      final accounts = data['accounts'] as List<dynamic>;

      return SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.primary800.withOpacity(0.85),
                AppColors.primary600.withOpacity(0.85),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 🟦 Header
              Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: AppColors.primary500,
                    child: const Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        personalInfo['fullName'] ?? '',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        '${t.t('status')}: ${personalInfo['Status'] == '1' ? t.t('active') : t.t('inactive')}',
                        style: TextStyle(
                          color: personalInfo['Status'] == '1'
                              ? AppColors.success
                              : AppColors.danger,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              const Divider(height: 24, thickness: 1.2, color: Colors.white24),

              // 🟦 Contact Info
              infocard(
                personalInfo,
                Icons.phone,
                t.t('mobile_number'),
                personalInfo['mobile'],
              ),
              infocard(
                personalInfo,
                Icons.email,
                t.t('email_address'),
                personalInfo['email'] ?? 'N/A',
              ),

              const Divider(height: 24, thickness: 1.2, color: Colors.white24),

              // 🟦 Linked Accounts
              Text(
                t.t('accounts'),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              ...accounts.map((a) => linkedAccountCard(a)).toList(),
            ],
          ),
        ),
      );
    },
  );
}

// 🔹 Row with icon
Widget infocard(Map personalInfo, IconData icon, String title, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: Row(
      children: [
        Icon(icon, color: Colors.white70),
        const SizedBox(width: 12),
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.white70,
          ),
        ),
        const Spacer(),
        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ],
    ),
  );
}

// 🔹 Linked Account Card
Widget linkedAccountCard(Map<String, dynamic> account) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 6),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          AppColors.primary700.withOpacity(0.9),
          AppColors.primary500.withOpacity(0.9),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.25),
          blurRadius: 15,
          offset: const Offset(0, 8),
        ),
      ],
      border: Border.all(color: AppColors.primary200.withOpacity(0.3)),
    ),
    child: ListTile(
      leading: Icon(Icons.account_balance_wallet, color: AppColors.neutral50),
      title: Text(
        account['accountName'] ?? '',
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(
        'ID: ${account['accountId']}',
        style: const TextStyle(color: Colors.white70),
      ),
      trailing: Text(
        '${account['balance']} ${account['currency']}',
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    ),
  );
}

// 🔹 Session Card Premium بالعناصر العنابية
Widget sessionCard(BuildContext context, Map<String, dynamic> s) {
  final t = L.of(context)!;
  final startTime = DateTime.tryParse(s['startTime'] ?? '')?.toLocal();
  final endTime = s['endTime'] != null
      ? DateTime.tryParse(s['endTime'])?.toLocal()
      : null;
  final uploadMB = ((s['inputOctets'] ?? 0) / 1024 / 1024).toDouble();
  final downloadMB = ((s['outputOctets'] ?? 0) / 1024 / 1024).toDouble();
  final totalMB = uploadMB + downloadMB;

  String formatDateTime(DateTime dt) =>
      '${dt.year}-${dt.month.toString().padLeft(2, '0')}-${dt.day.toString().padLeft(2, '0')} '
      '${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';

  final bool isActive = endTime == null;

  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          AppColors.primary700.withOpacity(0.9),
          AppColors.primary500.withOpacity(0.9),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.25),
          blurRadius: 20,
          offset: const Offset(0, 10),
        ),
      ],
      border: Border.all(color: AppColors.primary200.withOpacity(0.3)),
    ),
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Username + Status
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  s['username'] ?? '-',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.white,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: isActive ? AppColors.success : AppColors.danger,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Text(
                  isActive ? t.t('active') : t.t('ended'),
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          /// Start / End Time
          if (startTime != null)
            Text(
              '${t.t('start')}: ${formatDateTime(startTime)}\n${t.t('end')}: ${isActive ? t.t('now') : formatDateTime(endTime!)}',
              style: const TextStyle(color: Colors.white70, fontSize: 13),
            ),

          const SizedBox(height: 12),

          /// Upload / Download
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.upload_rounded,
                    size: 16,
                    color: Colors.orangeAccent,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '${uploadMB.toStringAsFixed(2)} MB',
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  const Icon(
                    Icons.download_rounded,
                    size: 16,
                    color: Colors.lightBlueAccent,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '${downloadMB.toStringAsFixed(2)} MB',
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 12),

          /// Progress Bar محسّن
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: LinearProgressIndicator(
              value: (totalMB / 1000).clamp(0, 1),
              minHeight: 10,
              backgroundColor: AppColors.primary200.withOpacity(0.3),
              valueColor: AlwaysStoppedAnimation(
                isActive
                    ? AppColors.primary500
                    : AppColors.danger.withOpacity(0.8),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

// ------------------ Tab Sessions مع العدد
Widget sessionsTab({
  required BuildContext context,
  required List<dynamic> sessions,
  required int totalSessions,
}) {
  final t = L.of(context)!;
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.all(16),
        child: Text(
          '${t.t('total_sessions')}: $totalSessions',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      Expanded(
        child: ListView.builder(
          itemCount: sessions.length,
          itemBuilder: (_, i) => sessionCard(context, sessions[i]),
        ),
      ),
    ],
  );
}

// 🔹 Fetch Account Data
Future<Map<String, dynamic>> fetchAccountData(String token) async {
  final customerService = CustomerService();

  final personalInfo = await customerService.getProfile(token);
  final accounts = await customerService.getAccounts(token);
  final sessionsData = await customerService.getSessions(
    token,
    page: 0,
    size: 10,
  );

  return {
    'personalInfo': personalInfo,
    'accounts': accounts,
    'sessions': sessionsData['content'] ?? [],
    'totalSessions': sessionsData['totalElements'] ?? 0,
    'totalPages': sessionsData['totalPages'] ?? 1,
  };
}

// 🔹 Tab Transfers مع الهوية العنابية
Widget transfersTab(
  BuildContext context,
  String user,
  String balance,
  String token,
) {
  final customerService = CustomerService();
  final t = L.of(context)!;

  return Container(
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          AppColors.primary700.withOpacity(0.9),
          AppColors.primary500.withOpacity(0.9),
          AppColors.primary400.withOpacity(0.9),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    ),
    child: FutureBuilder<Map<String, dynamic>>(
      future: customerService
          .getTransactions(token)
          .then((value) => value as Map<String, dynamic>),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(color: Colors.white),
          );
        }

        final data = snapshot.data ?? {};
        final transactions =
            (data['content'] as List<dynamic>?)?.cast<Map<String, dynamic>>() ??
            [];
        final total = data['totalElements'] ?? 0;

        return ListView(
          padding: const EdgeInsets.symmetric(vertical: 20),
          children: [
            /// 🔹 العنوان
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    t.t('financial_transactions'),
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '$total ${t.t('transactions')}',
                    style: const TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            /// 🔹 الكروت
            ...transactions.map((tx) {
              return TweenAnimationBuilder(
                duration: const Duration(milliseconds: 400),
                tween: Tween(begin: 0.0, end: 1.0),
                builder: (context, double value, child) {
                  return Opacity(
                    opacity: value,
                    child: Transform.translate(
                      offset: Offset(0, 30 * (1 - value)),
                      child: child,
                    ),
                  );
                },
                child: transactionCard(context, tx),
              );
            }).toList(),
          ],
        );
      },
    ),
  );
}

// 🔹 Transaction Card مع الهوية العنابية
Widget transactionCard(BuildContext context, Map<String, dynamic> tx) {
  final loc = L.of(context)!;
  final date = DateTime.parse(tx['trxDate']).toLocal();
  final isCredit = tx['direction'] == 2;

  String formatDate(DateTime d) =>
      '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')} '
      '${d.hour.toString().padLeft(2, '0')}:${d.minute.toString().padLeft(2, '0')}';

  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          AppColors.primary600.withOpacity(0.85),
          AppColors.primary500.withOpacity(0.85),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(24),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.25),
          blurRadius: 20,
          offset: const Offset(0, 12),
        ),
      ],
      border: Border.all(color: Colors.white.withOpacity(0.08)),
    ),
    child: Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        childrenPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
        title: Text(
          '#${tx['trxNo']}',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Colors.white,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 6),
            Text(
              '${tx['amount']} ${tx['Currency']}',
              style: TextStyle(
                color: isCredit ? AppColors.success : AppColors.danger,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              timeAgo(date),
              style: const TextStyle(fontSize: 12, color: Colors.white70),
            ),
          ],
        ),
        trailing: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: isCredit
                ? AppColors.success.withOpacity(0.15)
                : AppColors.danger.withOpacity(0.15),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Icon(
            isCredit ? Icons.arrow_downward : Icons.arrow_upward,
            color: isCredit ? AppColors.success : AppColors.danger,
          ),
        ),
        children: [
          _detailRow(
            loc.t('transaction_type'),
            isCredit ? loc.t('credit') : loc.t('debit'),
          ),
          _detailRow(loc.t('date_time'), formatDate(date)),
          _detailRow(loc.t('description'), tx['description'] ?? '-'),
          _detailRow(loc.t('external_ref'), tx['externalRef'] ?? '-'),
        ],
      ),
    ),
  );
}

Widget _detailRow(String label, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.white70,
            fontWeight: FontWeight.w500,
          ),
        ),
        Flexible(
          child: Text(
            value,
            textAlign: TextAlign.end,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
      ],
    ),
  );
}

String timeAgo(DateTime date) {
  final diff = DateTime.now().difference(date);

  if (diff.inMinutes < 1) return 'Just now';
  if (diff.inMinutes < 60) return '${diff.inMinutes} minutes ago';
  if (diff.inHours < 24) return '${diff.inHours} hours ago';
  if (diff.inDays < 7) return '${diff.inDays} days ago';

  return '${date.year}-${date.month}-${date.day}';
}

Widget welcomeHeader(BuildContext context, String username, String balance) {
  final t = L.of(context);

  return Card(
    elevation: 4,
    margin: const EdgeInsets.only(bottom: 16),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    child: ListTile(
      leading: const CircleAvatar(
        radius: 24,
        backgroundColor: Colors.blue,
        child: Icon(Icons.person, color: Colors.white),
      ),
      title: Text(
        '${t?.t('welcome')}, $username',
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        '${t?.t('balance')} $balance ل.س',
        style: TextStyle(color: Colors.grey.shade700),
      ),
    ),
  );
}

Future<void> _launchUrl(String url) async {
  final uri = Uri.parse(url);
  if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
    throw 'Could not launch $url';
  }
}

/* ------------------ Footer ------------------ */
Widget footer() {
  return Container(
    width: double.infinity,
    color: Colors.blue.shade900,
    padding: const EdgeInsets.all(12),
    child: const Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: 6),
        Text('Phone : +963000001', style: TextStyle(color: Colors.white70)),

        Text(
          'Email : info@cloudtech-it.com تم إنشاء التطبيق من قبل شركة ',
          style: TextStyle(color: Colors.white54, fontSize: 12),
        ),
      ],
    ),
  );
}
