import 'package:flutter/material.dart';
import 'package:todo101/config/app_config.dart';
import 'package:todo101/config/feutures.dart';
import 'package:todo101/naviagator/main_route_delegate.dart';
import 'package:todo101/naviagator/main_route_parser.dart';

void main() async {
  await configApp();
  runApp(const MyApp());
}

Future<void> configApp() async {
  AppConfig.appModules = appModels;
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const _ToDoAppWidget();
  }
}

class _ToDoAppWidget extends StatefulWidget {
  const _ToDoAppWidget({Key? key}) : super(key: key);

  @override
  _ToDoAppWidgetState createState() => _ToDoAppWidgetState();
}

class _ToDoAppWidgetState extends State<_ToDoAppWidget> {
  late MainRouteDelegate _delegate;
  late MainRouteParser _parser;
  @override
  void initState() {
    super.initState();
    _delegate = MainRouteDelegate();
    _parser = MainRouteParser();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routeInformationParser: _parser,
      routerDelegate: _delegate,
      backButtonDispatcher: RootBackButtonDispatcher(),
      theme: AppConfig.theme,
    );
  }
}
