import 'package:flutter/material.dart';
import 'package:todo101/share/layout/response.dart';

class SplashScreenPage extends Page {
  final void Function(bool)? onCompleted;
  const SplashScreenPage({this.onCompleted});
  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
        settings: this,
        builder: (context) => SplashScreen(
              onCompleted: onCompleted,
            ));
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key, this.onCompleted}) : super(key: key);
  final void Function(bool)? onCompleted;
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _runTaskAsync().then((isAuthenticated) {
      widget.onCompleted?.call(isAuthenticated);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: Responsive.isDesktop(context) ? 400 : 300,
        child: Column(
          children: const [
            Expanded(child: Icon(Icons.note_alt)),
            Text("TODO"),
            SizedBox(
              height: 50,
            )
          ],
        ),
      ),
    );
  }

  Future<bool> _runTaskAsync() async {
    // handle status login
    return Future.value(false);
  }
}
