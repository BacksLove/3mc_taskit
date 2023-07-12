import 'package:flutter/material.dart';
import 'package:taks_3mc/features/authentication/presentation/pages/authentication_page.dart';
import 'package:taks_3mc/features/authentication/presentation/pages/login_page.dart';
import 'package:taks_3mc/features/authentication/presentation/pages/otp_page.dart';
import 'package:taks_3mc/features/authentication/presentation/pages/signup_page.dart';
import 'package:taks_3mc/features/home/presentation/pages/home_page.dart';
import 'package:taks_3mc/features/map/presentation/pages/map_page.dart';
import 'package:taks_3mc/features/task/presentation/pages/create_task_page.dart';

// Route Names

// Auth
const String authPage = 'auth';
const String loginPage = 'login';
const String signupPage = 'signup';
const String otpPage = 'otpPage';

// Home
const String homePage = 'home';

// Tasks
const String createTaskPage = 'createTask';

// Map
const String mapPage = 'map';

// Control our page route flow
Route<dynamic> controller(RouteSettings settings) {
  switch (settings.name) {
    case authPage:
      return MaterialPageRoute(
          builder: (context) => const AuthenticationPage());
    case loginPage:
      return MaterialPageRoute(builder: (context) => const LoginPage());
    case signupPage:
      return MaterialPageRoute(builder: (context) => const SignupPage());
    case homePage:
      return MaterialPageRoute(builder: (context) => const HomePage());
    case otpPage:
      {
        final verificationId = settings.arguments as String;
        return MaterialPageRoute(
            builder: (context) => OtpPage(verificationId: verificationId));
      }

    case createTaskPage:
      return MaterialPageRoute(builder: (context) => const CreateTaskPage());
    case mapPage:
      return MaterialPageRoute(builder: (context) => const MapPage());

    default:
      throw ('This route name does not exit');
  }
}
