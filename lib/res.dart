// ignore_for_file:, non_constant_identifier_names

import 'dart:convert';
import 'dart:io';

final COMMIT_COUNT = () {
  final result = Process.runSync('git', ['rev-list', '--count', 'HEAD']);
  final val = int.tryParse(result.stdout.toString().trim()) ?? 0;
  // - Before pushing, ver = 1.
  // - After pushing, ver = 2, but the version wrote in remote file is still 1.
  // So, we need to increment the version by 1 to correctly match the version.
  return val + 1;
}();

const MORE_BUILD_DATA_PATH = 'more_build_data.json';
const JSON_ENCODER = JsonEncoder.withIndent('  ');
const LINUX_APP_DIR = 'linux.AppDir';
const APK_DIR = 'build/app/outputs/flutter-apk/';
const XCODE_CFG_PATH = 'Runner.xcodeproj/project.pbxproj';
const SHELL_SCRIPT_PATH = 'lib/data/model/app/shell_func.dart';

final REG_APPLE_VER = RegExp(r'CURRENT_PROJECT_VERSION = .+;');
final REG_APPLE_MARKET_VER = RegExp(r'MARKETING_VERSION = .+');
final REG_PUB_VER = RegExp(r'version: \d+\.\d+\.\d+\+?\d*');
