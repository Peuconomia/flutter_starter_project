import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';

abstract class ConfigReader {
  Future<void> initialize();
  bool get isDevicePreviewEnabled;
  String get baseURL;
  String get apiPath;
}

@Singleton(as: ConfigReader)
class ConfigReaderImpl implements ConfigReader {
  Map<String, dynamic>? _config;

  @override
  Future<void> initialize() async {
    var configString = "";
    var dir = Directory.current.path;
    if (dir.endsWith('/test')) {
      dir = dir.replaceAll('/test', '');
      configString = await File('$dir/configs/app_config.json').readAsString();
    } else {
      configString = await rootBundle.loadString('configs/app_config.json');
    }
    _config = json.decode(configString) as Map<String, dynamic>;
  }

  @override
  String get baseURL {
    if (_config == null) {
      return '';
    }
    return _config?['base_url'] as String? ?? '';
  }

  @override
  String get apiPath {
    if (_config == null) {
      return '';
    }
    return _config?['api_path'] as String? ?? '';
  }

  @override
  bool get isDevicePreviewEnabled {
    if (_config == null) {
      return false;
    }
    return _config?['is_device_preview_enabled'] as bool? ?? false;
  }
}
