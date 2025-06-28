import 'package:flutter/material.dart';
import 'package:new_flutter/core/common/screens/under_build_screen.dart';
import 'package:new_flutter/core/routes/base_routes.dart';
import 'package:new_flutter/features/Auth/presentation/pages/login/widgets/login_view.dart';
import 'package:new_flutter/features/Profile/profile_page.dart';
import 'package:new_flutter/features/ai__train_model/screens/home_screen.dart';
import 'package:new_flutter/features/home/about.dart';
import 'package:new_flutter/features/splash/presentation/splash_view.dart';
import 'package:new_flutter/start_app/start_page.dart';

class AppRoutes {
  static const String splash = 'splash';
  static const String login = 'login';
  static const String startApp = 'StartApp';
  static const String about = 'about';
  static const String profile = 'profile';
  static const String photoAnalysis = 'photo_analysis';
  static Route<void> onGenerateRoute(RouteSettings settings) {

    switch (settings.name) {

      case splash:
        return BaseRoute(page: const splashview());
      case startApp:
        return BaseRoute(page: const StartApp());
      case login:
        // Assuming you have a LoginPage widget
        return BaseRoute(page: const LoginView());
      case about:
        return BaseRoute(page: const Aboutus());
      case profile:
        return BaseRoute(page: const ProfilePage());
case photoAnalysis:
        return BaseRoute(page: const HomeScreen());
      default:
        return BaseRoute(page: const PageUnderBuildScreen());
    }
  }
}
