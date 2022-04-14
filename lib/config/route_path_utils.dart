import 'package:todo101/config/app_config.dart';
import 'package:todo101/naviagator/path/base_route_path.dart';
import 'package:todo101/naviagator/path/login_route_path.dart';
import 'package:todo101/naviagator/path/main_route_path.dart';
import 'package:todo101/naviagator/path/unknown_route_path.dart';
import 'package:todo101/naviagator/states/app_route_state.dart';
import 'package:todo101/untils/common_utils.dart';

class RoutePathUtils {
  RoutePathUtils._();

  static BaseRoutePath parseRoute(Uri inputUri) {
    final uri = inputUri;
    if (uri.pathSegments.isEmpty) {
      final path =
          NavigatorPathParams(pathSegments: [AppConfig.appModules.first.path]);
      return MainRoutePath([path]);
    } else {
      final first = uri.queryParameters.containsKey("page")
          ? uri.queryParameters["page"]!
          : uri.pathSegments[0];
      if (CommonUtils.equalsTo(first, AppConfig.appRoutes.login)) {
        NavigatorPathParams? redirect;
        if (uri.queryParameters.containsKey("redirect")) {
          final str = uri.queryParameters["redirect"];
          if (str != null && str.isNotEmpty) {
            redirect = NavigatorPathParams.fromEncodedString(str);
          }
        }
        return LoginRoutePath(redirect: redirect);
      } else if (AppConfig.appModules
          .any((m) => m.path.toLowerCase() == first.toLowerCase())) {
        final path = NavigatorPathParams(
            pathSegments: uri.pathSegments, params: uri.queryParameters);
        return MainRoutePath([path]);
      } else {
        return UnknownRoutePath();
      }
    }
  }
}
