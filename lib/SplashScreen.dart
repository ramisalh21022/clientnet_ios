import 'package:flutter/material.dart';
import 'api-client.dart';
import 'main.dart';
import 'dart:math';
import 'app_colors.dart';

Future<void> checkAuthOnAppStart(
  BuildContext context,
  Function(String) onLangChange,
) async {
  final auth = AuthService();
  final api = ApiClient();

  try {
    /// 1️⃣ جلب توكن صالح
    final tokens = await auth.getValidToken();
    if (tokens == null) throw Exception('No valid token');

    /// 2️⃣ جلب بيانات الحساب
    final userData = await api.get(
      '/api/customers/me',
      token: tokens.accessToken,
    );
    print(tokens.accessToken);
    if (!context.mounted) return;

    /// 3️⃣ الانتقال إلى Home
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => HomeScreen(
          username: userData['fullName'],
          onLangChange: onLangChange,
          token: tokens.accessToken,
        ),
      ),
    );
  } catch (_) {
    if (!context.mounted) return;

    /// ❌ أي خطأ = Login
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => LoginScreen(onLangChange: onLangChange),
      ),
    );
  }
}

class SplashScreen extends StatefulWidget {
  final Function(String) onLangChange;

  const SplashScreen({super.key, required this.onLangChange});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  bool _navigated = false;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(const Duration(milliseconds: 1800));
      if (!mounted || _navigated) return;
      _navigated = true;
      await checkAuthOnAppStart(context, widget.onLangChange);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          return Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.primary800,
                  AppColors.primary600,
                  AppColors.primary500,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Stack(
              children: [
                /// 🌫️ دوائر ضوئية خلفية
                Positioned(
                  top: -80,
                  left: -60,
                  child: _glowCircle(
                    200,
                    AppColors.primary300.withOpacity(0.15),
                  ),
                ),
                Positioned(
                  bottom: -100,
                  right: -80,
                  child: _glowCircle(
                    250,
                    AppColors.primary200.withOpacity(0.12),
                  ),
                ),

                SafeArea(
                  child: Column(
                    children: [
                      /// 🔥 منتصف الشاشة
                      Expanded(
                        child: Center(
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              /// 💎 نبض ضوئي خلف الشعار
                              Container(
                                width: 220,
                                height: 220,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColors.primary300.withOpacity(
                                        0.3 +
                                            (0.2 *
                                                sin(
                                                  _controller.value * 2 * pi,
                                                )),
                                      ),
                                      blurRadius: 60,
                                      spreadRadius: 10,
                                    ),
                                  ],
                                ),
                              ),

                              /// ✨ Light Sweep Effect
                              ClipOval(
                                child: Stack(
                                  children: [
                                    Image.asset(
                                      "assets/alfateh.png",
                                      width: 180,
                                    ),
                                    Positioned.fill(
                                      child: Transform.translate(
                                        offset: Offset(
                                          200 * _controller.value - 100,
                                          0,
                                        ),
                                        child: Container(
                                          width: 80,
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              colors: [
                                                Colors.white.withOpacity(0.0),
                                                Colors.white.withOpacity(0.4),
                                                Colors.white.withOpacity(0.0),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      /// 🔻 الجزء السفلي
                      Padding(
                        padding: const EdgeInsets.only(bottom: 40),
                        child: Column(
                          children: [
                            const Text(
                              'نصل اليك اينما كنت',
                              style: TextStyle(
                                color: AppColors.neutral50,
                                fontSize: 22,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 1.3,
                              ),
                            ),

                            const SizedBox(height: 6),

                            const SizedBox(
                              width: 28,
                              height: 28,
                              child: CircularProgressIndicator(
                                strokeWidth: 2.5,
                                valueColor: AlwaysStoppedAnimation(
                                  AppColors.primary200,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _glowCircle(double size, Color color) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(shape: BoxShape.circle, color: color),
    );
  }
}
