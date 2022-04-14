
import 'package:flutter/material.dart';

class AppModule {
  final String key;
  final String path;
  final Page page;
  late Map<String, dynamic> _param;

  AppModule({
    required this.key,
    required this.page,
    required this.path,
  });
  Map<String, dynamic> get params => _param;
  set params(Map<String, dynamic> param) {
    _param = param;
  }
}