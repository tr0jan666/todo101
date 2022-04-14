import 'package:flutter/material.dart';
import 'package:todo101/config/app_module.dart';
import 'package:todo101/config/route_config.dart';
import 'package:todo101/config/theme/base_theme.dart';

class AppConfig {
  AppConfig._();

  static ThemeData theme = baseLightTheme;

  
  ///App Routes
  static AppRoutes appRoutes = AppRoutes();


  ///App Modules
  static List<AppModule> appModules = const <AppModule>[];

  ///Configs for Splash screen
  static SplashScreenConfig splashConfig = SplashScreenConfig(
    buildContent: (ctx) => const CircularProgressIndicator(
      backgroundColor: Colors.white,
    ),
  );

  ///Configs for Login screen
  static LoginScreenConfig loginConfig = LoginScreenConfig();

  ///Configs for Forgot Password Screen
  static ForgotPasswordScreenConfig forgotPasswordConfig =
      ForgotPasswordScreenConfig();

  ///Configs for Register Screen
  static RegisterScreenConfig registerConfig = RegisterScreenConfig();

  // config for Verify Account Screen
 }

class SplashScreenConfig {
  final Decoration Function(BuildContext)? decoration;
  final Widget Function(BuildContext context) buildContent;
  final Future<void> Function()? loadAsync;

  SplashScreenConfig({
    this.decoration,
    required this.buildContent,
    this.loadAsync,
  });
}

class LoginScreenConfig {
  final Decoration Function(BuildContext)? decoration;
  final Widget? usernameIcon;
  final String? usernameLabelText;
  final String? usernameHintText;
  final Widget? passwordIcon;
  final String? passwordLabelText;
  final String? passwordHintText;
  final bool hasRegister;

  LoginScreenConfig({
    this.decoration,
    this.usernameIcon = const Icon(
      Icons.email,
      color: Colors.grey,
    ),
    this.usernameLabelText,
    this.usernameHintText = "Email address",
    this.passwordIcon = const Icon(
      Icons.lock,
      color: Colors.grey,
    ),
    this.passwordLabelText,
    this.passwordHintText = "Password",
    this.hasRegister = true,
  });
}

class RegisterScreenConfig {
  final Decoration Function(BuildContext)? decoration;
  final Decoration Function(BuildContext)? decorationRegisterSuccess;

  RegisterScreenConfig({
    this.decoration,
    this.decorationRegisterSuccess,
  });
}

class ForgotPasswordScreenConfig {
  final Decoration Function(BuildContext)? decoration;

  ForgotPasswordScreenConfig({
    this.decoration,
  });
}

