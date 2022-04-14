import 'package:flutter/material.dart';
import 'package:todo101/config/app_config.dart';
import 'package:todo101/config/route_path_utils.dart';
import 'package:todo101/naviagator/path/base_route_path.dart';
import 'package:todo101/naviagator/path/login_route_path.dart';
import 'package:todo101/naviagator/path/main_route_path.dart';
import 'package:todo101/naviagator/path/splah_route_path.dart';
import 'package:todo101/naviagator/path/unknown_route_path.dart';

class MainRouteParser extends RouteInformationParser<BaseRoutePath> {
  @override
  Future<BaseRoutePath> parseRouteInformation(
      RouteInformation routeInformation) async {
    final uri = Uri.parse(routeInformation.location!);
    return RoutePathUtils.parseRoute(uri);
  }
  @override
  RouteInformation? restoreRouteInformation(BaseRoutePath config) {
    if (config is UnknownRoutePath) {
      return RouteInformation(location: '/${AppConfig.appRoutes.unknown}');
    } else if (config is SplashRoutePath) {
      String redirect = "";
      if (config.redirect != null) {
        redirect = "?redirect=${config.redirect?.toEncodedString()}";
      }
      return RouteInformation(location: '/$redirect');
    } else if (config is LoginRoutePath) {
      String redirect = "";
      if (config.redirect != null) {
        redirect = "?redirect=${config.redirect?.toEncodedString()}";
      }
      return RouteInformation(
          location: '/${AppConfig.appRoutes.login}$redirect');
    } else if (config is MainRoutePath) {
      var location = Uri(
              pathSegments: config.paths.last.pathSegments,
              queryParameters: config.paths.last.params.isEmpty
                  ? null
                  : config.paths.last.params)
          .toString();

      return RouteInformation(location: "/$location");
    } else {
      return const RouteInformation(location: "/");
    }
  }
}
