import 'package:flutter/material.dart';
import 'package:todo101/share/custom_button_widget.dart';
import 'package:todo101/share/layout/response.dart';

class LoginScreenPage extends Page {
  final void Function(dynamic)? onLoggedIn;
  final void Function(int)? onRegister;
  final void Function()? onForgotPassword;
  const LoginScreenPage(
      {this.onForgotPassword, this.onLoggedIn, this.onRegister});
  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
        settings: this,
        builder: (context) => LoginScreen(
              onLoggedIn: onLoggedIn,
              onForgotPassword: onForgotPassword,
              onRegister: onRegister,
            ));
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen(
      {Key? key, this.onForgotPassword, this.onLoggedIn, this.onRegister})
      : super(key: key);
  final void Function(dynamic)? onLoggedIn;
  final void Function(int)? onRegister;
  final void Function()? onForgotPassword;

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _userName = TextEditingController();
  final TextEditingController _pass = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          width: Responsive.isDesktop(context) ? 400 : null,
          height: MediaQuery.of(context).size.height,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "LOGIN",
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                _marginBotton(height: 40),
                _textField(hintText: "User Name", controller: _userName),
                _marginBotton(),
                _textField(hintText: "password", controller: _pass),
                _marginBotton(),
                CustomButton(
                  title: "Login",
                  isFullWidthButton: true,
                  onPressed: () => widget.onLoggedIn?.call(true),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  SizedBox _marginBotton({double? height = 20}) => SizedBox(
        height: height,
      );
  TextField _textField(
      {required String? hintText, TextEditingController? controller}) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
      ),
    );
  }
}
