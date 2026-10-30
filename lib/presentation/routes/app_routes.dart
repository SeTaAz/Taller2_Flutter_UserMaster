import 'package:flutter/material.dart';

import '../../domain/entities/user_profile.dart';
import '../pages/dashboard_page.dart';
import '../pages/forgot_password_page.dart';
import '../pages/login_page.dart';
import '../pages/register_page.dart';
import '../pages/splash_page.dart';

class AppRoutes {
  static const splash = '/';
  static const login = '/login';
  static const register = '/register';
  static const forgotPassword = '/forgot-password';
  static const dashboard = '/dashboard';

  static Map<String, WidgetBuilder> get routes => {
    splash: (_) => const SplashPage(),
    login: (_) => const LoginPage(),
    register: (_) => const RegisterPage(),
    forgotPassword: (_) => const ForgotPasswordPage(),
    dashboard: (context) {
      final profile = ModalRoute.of(context)?.settings.arguments;
      if (profile is! UserProfile) {
        throw FlutterError(
          'The dashboard route requires a UserProfile argument.',
        );
      }
      return DashboardPage(profile: profile);
    },
  };
}
