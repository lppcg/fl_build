#!/usr/bin/env dart
// ignore_for_file: avoid_print, non_constant_identifier_names, constant_identifier_names

import 'dart:convert';
import 'dart:io';

import 'package:fl_build/config.dart';
import 'package:fl_build/make.dart';
import 'package:fl_build/scp.dart';
import 'package:fl_build/target.dart';
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

  final file = File(params['-c'] ?? 'fl_build.json');
  if (await file.exists()) {
    final content = await file.readAsString();
    final config = json.decode(content) as Map<String, dynamic>;
    makeCfg = MakeCfg.fromJson(config);
  } else {
    print('Make config is required: ${file.path}');
    exit(1);
  }

  // If [forRelease] is true, it will run all the preparation steps.
  final buildPreparation =
      params.containsKey('-bp') || params.containsKey('-r');
  if (buildPreparation) {
    await updateBuildData(); // Put it at first
    await changePubVersion();
    await changeAppleVersion();
    await dartFormat();
  }

  final forRelease = params.containsKey('-r');
  if (forRelease) {
    await gitSubmmit();
  }

  // End of all build preparations
  if (buildPreparation || forRelease) return;

  // If it's running in Github Actions, it will setup the environment.
  await setupGithub();

  // Before build
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

  // Build
  final platforms = params['-p']?.split(',');
  final scp = params.containsKey('-s') || params.containsKey('--scp');

  if (platforms == null) {
    print('No platform specified. Exit.');
    return;
  }

  for (final platform in platforms) {
    final target = Target.fromString(platform);
    final res = await Maker.run(target);
    if (res == null) continue;
    for (final path in res.pkgPath) {
      if (scp) await Scps.run(target, path);
    }
  }

  // After build
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
