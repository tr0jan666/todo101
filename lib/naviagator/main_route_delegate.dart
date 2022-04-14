import 'package:flutter/cupertino.dart';
import 'package:todo101/config/app_config.dart';
import 'package:todo101/naviagator/path/base_route_path.dart';
import 'package:todo101/naviagator/path/login_route_path.dart';
import 'package:todo101/naviagator/path/main_route_path.dart';
import 'package:todo101/naviagator/path/splah_route_path.dart';
import 'package:todo101/naviagator/path/unknown_route_path.dart';
import 'package:todo101/naviagator/states/app_route_state.dart';
import 'package:todo101/page/login_page.dart';
import 'package:todo101/page/main_page.dart';
import 'package:todo101/page/splash_page.dart';
import 'package:todo101/page/unknow_page.dart';
import 'package:todo101/untils/common_utils.dart';

class MainRouteDelegate extends RouterDelegate<BaseRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<BaseRoutePath> {
  AppRouteState appState = AppRouteState();
  final GlobalKey<NavigatorState> rootNavigatorKey =
      GlobalKey<NavigatorState>();

  MainRouteDelegate() {
    appState.addListener(notifyListeners);
  }
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Navigator(
          key: navigatorKey,
          pages: [
            //Splash
            if (!appState.initialized)
              SplashScreenPage(onCompleted: (isAuth) {
                appState.initialized = true;
                appState.loggedIn = isAuth;
                if (appState.loggedIn) {
                  appState.paths = [
                    NavigatorPathParams(
                        pathSegments: [AppConfig.appModules.first.path])
                  ];
                }
                notifyListeners();
              }),

            //Login
            if (appState.initialized && !appState.loggedIn)
              LoginScreenPage(
                onLoggedIn: (cridential) {
                  appState.loggedIn = true;
                  if (appState.redirect == null) {
                    appState.paths = [
                      NavigatorPathParams(
                          pathSegments: [AppConfig.appModules.first.path])
                    ];
                  } else {
                    final redirect = appState.redirect;
                    appState.redirect = null;
                    appState.paths = [redirect!];
                  }
                  notifyListeners();
                },
                onRegister: (result) {
                  
                },
                onForgotPassword: () {
                 
                },
              ),
            //Main screen
            if (appState.initialized && appState.loggedIn)
              MainLayoutPage(appState),

            //404
            if (appState.unknown) const UnknownScreenPage(),
          ],
          onPopPage: (route, result) {
            if (!route.didPop(result)) return false;
            return false;
          },
        )
      ],
    );
  }

  @override
  GlobalKey<NavigatorState>? get navigatorKey => rootNavigatorKey;

  @override
  Future<void> setNewRoutePath(BaseRoutePath configuration) async {
    if (configuration is SplashRoutePath) {
      appState.initialized = false;
      appState.redirect = configuration.redirect;
    } else if (configuration is UnknownRoutePath) {
    } else if (configuration is LoginRoutePath) {
      appState.register = false;
      appState.forgotPassword = false;
      appState.licenseExpired = false;
      appState.redirect = configuration.redirect;
    } else if (configuration is MainRoutePath) {
      appState.licenseExpired = false;
      appState.register = false;
      appState.forgotPassword = false;
      appState.paths = configuration.paths;
      if (!appState.initialized) {
        final path = appState.paths.first;
        if (path.pathSegments.first.isNotEmpty &&
            !CommonUtils.equalsTo(
                path.pathSegments.first, AppConfig.appRoutes.login)) {
          appState.redirect = NavigatorPathParams(
              pathSegments: path.pathSegments, params: path.params);
        }
      }
    }
  }

  @override
  BaseRoutePath? get currentConfiguration {
    if (!appState.initialized) {
      return SplashRoutePath(redirect: appState.redirect);
    } else if (appState.unknown) {
      return UnknownRoutePath();
    } else if (!appState.loggedIn) {
      return LoginRoutePath(redirect: appState.redirect);
    } else if (appState.loggedIn) {
      return MainRoutePath(appState.paths);
    } else {
      return null;
    }
  }
}
