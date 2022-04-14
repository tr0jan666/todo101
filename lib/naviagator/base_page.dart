import 'package:flutter/material.dart';

abstract class BasePage extends Page {
  BasePage() : super();
  Route buildRoute(BuildContext context);
  final Map<String, dynamic> _params ={};
  Map<String, dynamic> get params => _params;
  set params(Map<String, dynamic> param) {
    _params.addAll(param);
  }

  @override
  Route createRoute(BuildContext context) {
    return buildRoute(context);
  }
}