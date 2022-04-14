import 'package:flutter/material.dart';
import 'package:todo101/config/app_config.dart';
import 'package:todo101/naviagator/base_page.dart';
import 'package:todo101/naviagator/path/base_route_path.dart';
import 'package:todo101/naviagator/states/app_route_state.dart';

class InnerRouteDelegate extends RouterDelegate<BaseRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<BaseRoutePath> {
  final GlobalKey<NavigatorState> mainNavigatorKey =
      GlobalKey<NavigatorState>();

  AppRouteState _appState;
  AppRouteState get appState => _appState;
  set appState(AppRouteState newState) {
    if (newState == _appState) {
      return;
    }
    _appState = newState;
    notifyListeners();
  }

  InnerRouteDelegate(this._appState);

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: [
        for (var path in appState.paths) ...{
          for (var pathSeg in path.pathSegments) ...{_buildPage(pathSeg, path)}
        }
      ],
      onPopPage: (route, result) {
        if (!route.didPop(result)) {
          return false;
        }
        appState.paths.removeLast();
        notifyListeners();
        return true;
      },
    );
  }

  Page _buildPage(String pathSeg, NavigatorPathParams path) {
    Page page = AppConfig.appModules
        .firstWhere(
            (element) => element.path.toLowerCase() == pathSeg.toLowerCase(),
            orElse: () => AppConfig.appModules.first)
        .page;
    if (page is BasePage) {
      page.params = path.params;
    }
    return page;
  }

  @override
  GlobalKey<NavigatorState>? get navigatorKey => mainNavigatorKey;

  @override
  Future<void> setNewRoutePath(BaseRoutePath configuration) async {}
}
