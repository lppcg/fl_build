#!/usr/bin/env dart
// ignore_for_file: avoid_print, non_constant_identifier_names, constant_identifier_names

import 'dart:convert';
import 'dart:io';

import 'package:fl_build/config.dart';
import 'package:fl_build/make.dart';
import 'package:fl_build/utils.dart';

void main(List<String> args) async {
  if (args.isEmpty) {
    print('No action. Exit.');
    return;
  }

  final params = <String, String?>{};
  for (var i = 0; i < args.length;) {
    final arg = args[i];
    if (arg.startsWith('-')) {
      if (i + 1 < args.length && !args[i + 1].startsWith('-')) {
        params[arg] = args[i + 1];
        i += 2;
      } else {
        params[arg] = null;
        i++;
      }
    } else {
      throw ArgumentError('Invalid: $arg');
    }
  }

  final file = File(params['-c'] ?? params['--fl-build-config'] ?? 'fl_build.json');
  if (await file.exists()) {
    final content = await file.readAsString();
    final config = json.decode(content) as Map<String, dynamic>;
    makeCfg = MakeCfg.fromJson(config);
  } else {
    print('Make config is required: ${file.path}');
    exit(1);
  }

  await setupGithub();

  final beforeBuild = makeCfg.beforeBuild;
  if (beforeBuild != null) {
    print('Running beforeBuild...');
    final result = await Process.run('sh', ['-c', beforeBuild]);
    print(result.stdout);
    if (result.exitCode != 0) {
      print(result.stderr);
      exit(1);
    }
  }

  // Always change version to avoid dismatch version between platforms
  await changeAppleVersion();
  await dartFormat();
  await updateBuildData();

  final platforms = params['-p']?.split(',');
  if (platforms == null) {
    print('No platform specified. Exit.');
    return;
  }
  for (final platform in platforms) {
    final func = BUILD_FUNCS[platform];
    if (func == null) {
      print('Invalid platform: $platform');
      continue;
    }
    await func();
  }

  final afterBuild = makeCfg.afterBuild;
  if (afterBuild != null) {
    print('Running afterBuild...');
    final result = await Process.run('sh', ['-c', afterBuild]);
    print(result.stdout);
    if (result.exitCode != 0) {
      print(result.stderr);
      exit(1);
    }
  }
}
