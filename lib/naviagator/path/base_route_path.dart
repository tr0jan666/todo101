import 'package:todo101/naviagator/states/app_route_state.dart';

abstract class BaseRoutePath {
  NavigatorPathParams? redirect;
  Map<String, dynamic>? params;
  BaseRoutePath({this.redirect, this.params});
}
