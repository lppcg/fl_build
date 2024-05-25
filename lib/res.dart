// ignore_for_file: constant_identifier_names, non_constant_identifier_names

import 'dart:convert';
import 'dart:io';

final COMMIT_COUNT = () {
  final result = Process.runSync('git', ['rev-list', '--count', 'HEAD']);
  return int.tryParse(result.stdout.toString().trim()) ?? 0;
}();

const MORE_BUILD_DATA_PATH = 'more_build_data.json';
const JSON_ENCODER = JsonEncoder.withIndent('  ');
const LINUX_APP_DIR = 'linux.AppDir';
const APK_DIR = 'build/app/outputs/flutter-apk/';
const XCODE_CFG_PATH = 'Runner.xcodeproj/project.pbxproj';
const SHELL_SCRIPT_PATH = 'lib/data/model/app/shell_func.dart';

final REG_APPLE_VER = RegExp(r'CURRENT_PROJECT_VERSION = .+;');
final REG_APPLE_MARKET_VER = RegExp(r'MARKETING_VERSION = .+');
