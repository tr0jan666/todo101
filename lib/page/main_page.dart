import 'package:flutter/material.dart';
import 'package:todo101/naviagator/inner_route_delegate.dart';
import 'package:todo101/naviagator/states/app_route_state.dart';

class MainLayoutPage extends Page {
  final AppRouteState _appState;

  const MainLayoutPage(this._appState);
  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
      settings: this,
        builder: (context) => MainLayout(
              appState: _appState,
            ));
  }
}

class MainLayout extends StatefulWidget {
  final AppRouteState appState;

  const MainLayout({Key? key, required this.appState}) : super(key: key);

  @override
  _MainLayoutState createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  late InnerRouteDelegate _innerRouteDelegate;
  late ChildBackButtonDispatcher _backButtonDispatcher;
  @override
  void initState() {
    super.initState();
    _innerRouteDelegate = InnerRouteDelegate(widget.appState);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _backButtonDispatcher = Router.of(context)
        .backButtonDispatcher!
        .createChildBackButtonDispatcher();
  }

  @override
  void didUpdateWidget(covariant MainLayout oldWidget) {
    super.didUpdateWidget(oldWidget);
    _innerRouteDelegate.appState = widget.appState;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Router(
        routerDelegate: _innerRouteDelegate,
        backButtonDispatcher: _backButtonDispatcher,
      )),
    );
  }
}
