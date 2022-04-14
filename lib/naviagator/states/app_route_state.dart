import 'dart:async';

import 'package:flutter/material.dart';
import 'package:todo101/config/app_config.dart';

class AppRouteState extends ChangeNotifier {
  bool _initialized;
  bool _loggedIn;
  bool _register;
  bool _forgotPassword;
  bool _verifyAccount;
  bool _licenseExpired;
  Map<String, dynamic> _tenantInfo;
  List<NavigatorPathParams> _paths;
  StreamSubscription? _navSubscription;
  NavigatorPathParams? _redirect;

  AppRouteState()
      : _initialized = false,
        _loggedIn = false,
        _register = false,
        _forgotPassword = false,
        _verifyAccount = false,
        _redirect = null,
        _licenseExpired = false,
        _tenantInfo = {},
        _paths = [] {
    _navSubscription = AppNavigation.stream.listen(
      (event) {
        if (event is AppNavigatorPushEvent) {
          _paths.add(event.path);
          notifyListeners();
        } else if (event is AppNavigatorReplaceEvent) {
          if (event.removeHistory) {
            _paths = [event.path];
          } else {
            _paths.removeLast();
            _paths.add(event.path);
          }
          notifyListeners();
        } else if (event is AppNavigatorPopEvent) {
          if (_paths.isEmpty) return;
          if (event.popToRoot) {
            _paths = [];
          } else {
            _paths.removeLast();
          }
          notifyListeners();
        } else if (event is AppNavigatorLogoutEvent) {
          loggedIn = false;
          register = false;
          forgotPassword = false;
          licenseExpired = false;
          paths = [];
        }
      },
    );
  }

  set initialized(bool v) {
    _initialized = v;
    notifyListeners();
  }

  set loggedIn(bool v) {
    _loggedIn = v;
    // if (!_loggedIn) {
    //   //Logout
    //   _register = false;
    // _forgotPassword = false;
    // _paths = []; //todo lele remove empty paths
    // }
    notifyListeners();
  }

  set register(bool v) {
    _register = v;
    notifyListeners();
  }

  set forgotPassword(bool v) {
    _forgotPassword = v;
    notifyListeners();
  }

  set verifyAccount(bool v) {
    _verifyAccount = v;
    notifyListeners();
  }

  set paths(List<NavigatorPathParams> v) {
    _paths = v;
    notifyListeners();
  }

  void addPath(NavigatorPathParams v) {
    _paths.add(v);
    notifyListeners();
  }

  set redirect(NavigatorPathParams? v) {
    _redirect = v;
    notifyListeners();
  }

  set licenseExpired(bool v) {
    _licenseExpired = v;
    notifyListeners();
  }

  set tenantInfo(Map<String, dynamic> v) {
    _tenantInfo = v;
    notifyListeners();
  }

  NavigatorPathParams? get redirect => _redirect;

  bool get initialized => _initialized;

  bool get loggedIn => _loggedIn;

  bool get register => _register;

  bool get forgotPassword => _forgotPassword;

  bool get verifyAccount => _verifyAccount;

  bool get unknown => _initialized && _isUnkownPath();

  Map<String, dynamic> get tenantInfo => _tenantInfo;

  List<NavigatorPathParams> get paths => _paths;

  bool get licenseExpired => _licenseExpired;

  bool _isUnkownPath() {
    if (_paths.isNotEmpty) {
      final segment = paths.last.pathSegments.first;
      return segment.toLowerCase() != AppConfig.appRoutes.login.toLowerCase() &&
          segment.toLowerCase() != AppConfig.appRoutes.register.toLowerCase() &&
          segment.toLowerCase() !=
              AppConfig.appRoutes.forgotPassword.toLowerCase() &&
          !AppConfig.appModules
              .any((element) => segment.toLowerCase() == element.path);
    }
    return false;
  }

  @override
  void dispose() {
    if (_navSubscription != null) {
      _navSubscription!.cancel();
      _navSubscription = null;
    }
    super.dispose();
  }
}

class NavigatorPathParams {
  final List<String> pathSegments;
  final Map<String, dynamic> params;

  NavigatorPathParams({this.pathSegments = const [], this.params = const {}});
  @override
  String toString() {
    return Uri(
            pathSegments: pathSegments,
            queryParameters: params.isEmpty ? null : params)
        .toString();
  }

  String toEncodedString() {
    return Uri.encodeFull(toString());
  }

  static NavigatorPathParams? fromEncodedString(String encodedStr) {
    final decode = Uri.decodeFull(encodedStr);
    final uri = Uri.parse(decode);
    return NavigatorPathParams(
        pathSegments: uri.pathSegments, params: uri.queryParametersAll);
  }
}

class AppNavigation {
  // ignore: close_sinks
  static final StreamController<AppNavigatorEvent> _navStreamController =
      StreamController<AppNavigatorEvent>.broadcast();

  static Stream<AppNavigatorEvent> get stream => _navStreamController.stream;
  static void dispose() {
    _navStreamController.close();
  }

  static push(NavigatorPathParams path) {
    _navStreamController.sink.add(AppNavigatorPushEvent(path));
  }

  static replace(NavigatorPathParams path, {bool removeHistory = false}) {
    _navStreamController.sink
        .add(AppNavigatorReplaceEvent(path, removeHistory: removeHistory));
  }

  static pop({bool popToRoot = false}) {
    _navStreamController.sink.add(AppNavigatorPopEvent(popToRoot: popToRoot));
  }

  static popAndReturnData(List<dynamic>? data) {
    _navStreamController.sink.add(AppNavigatorKeepData(dataKeep: data));
  }

  static sendNavigatorEvent(AppNavigatorEvent event) {
    _navStreamController.sink.add(event);
  }

  static goToScreenWithKeyItem(String key, Map<String, dynamic> param) {
    var module =
        AppConfig.appModules.where((element) => element.key == key).first;
    AppNavigation.push(
        NavigatorPathParams(pathSegments: [module.path], params: param));
  }
}

///Events for Navigator
abstract class AppNavigatorEvent {}

class AppNavigatorKeepData extends AppNavigatorEvent {
  final List<dynamic>? dataKeep;
  AppNavigatorKeepData({required this.dataKeep});
}

class AppNavigatorPushEvent extends AppNavigatorEvent {
  final NavigatorPathParams path;

  AppNavigatorPushEvent(this.path);
}

class AppNavigatorReplaceEvent extends AppNavigatorEvent {
  final NavigatorPathParams path;
  final bool removeHistory;

  AppNavigatorReplaceEvent(this.path, {this.removeHistory = false});
}

class AppNavigatorPopEvent extends AppNavigatorEvent {
  final bool popToRoot;

  AppNavigatorPopEvent({this.popToRoot = false});
}

class AppNavigatorLogoutEvent extends AppNavigatorEvent {
  AppNavigatorLogoutEvent();
}
