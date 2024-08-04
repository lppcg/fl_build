// ignore_for_file:, non_constant_identifier_names

import 'dart:convert';
import 'dart:io';

final envFile = Platform.environment['GITHUB_ENV'];
final isGithubAction = envFile != null;

const MORE_BUILD_DATA_PATH = 'more_build_data.json';
const JSON_ENCODER = JsonEncoder.withIndent('  ');
const LINUX_APP_DIR = 'linux.AppDir';
const APK_DIR = 'build/app/outputs/flutter-apk/';
const XCODE_CFG_PATH = 'Runner.xcodeproj/project.pbxproj';
const SHELL_SCRIPT_PATH = 'lib/data/model/app/shell_func.dart';

const APPIMAGE_RUNTIME_FILE = '/tmp/runtime-fuse3-x86_64';

final REG_APPLE_VER = RegExp(r'CURRENT_PROJECT_VERSION = .+;');
final REG_APPLE_MARKET_VER = RegExp(r'MARKETING_VERSION = .+');
final REG_PUB_VER = RegExp(r'version: (\d+\.\d+\.\d+)\+?(\d*)');

const RED = '\x1B[31m';
const GREEN = '\x1B[32m';
const BLUE = '\x1B[34m';
const MEGENTA = '\x1B[35m';
const RESET = '\x1B[0m';

/// println
void printColor(String msg, String color) {
  if (stdout.hasTerminal) {
    stdout.write(color);
    stdout.write(msg);
    stdout.writeln(RESET);
  } else {
    stdout.writeln(msg);
  }
}

void printRed(String message) {
  printColor(message, RED);
}

void printGreen(String message) {
  printColor(message, GREEN);
}

void printBlue(String message) {
  printColor(message, BLUE);
}

void printMegenta(String message) {
  printColor(message, MEGENTA);
}
