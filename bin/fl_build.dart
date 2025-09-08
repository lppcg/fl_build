#!/usr/bin/env dart
// ignore_for_file: avoid_print, non_constant_identifier_names, constant_identifier_names

import 'dart:convert';
import 'dart:io';

import 'package:fl_build/cfg/config.dart';
import 'package:fl_build/make.dart';
import 'package:fl_build/res.dart';
import 'package:fl_build/scp.dart';
import 'package:fl_build/target.dart';
import 'package:fl_build/utils.dart';

void main(List<String> args) async {
  final params = <String, String?>{};
  List<String> passthroughArgs = [];
  
  // Find the -- separator to split args
  final separatorIndex = args.indexOf('--');
  final mainArgs = separatorIndex >= 0 ? args.take(separatorIndex).toList() : args;
  if (separatorIndex >= 0) {
    passthroughArgs = args.skip(separatorIndex + 1).toList();
  }
  
  for (var i = 0; i < mainArgs.length;) {
    final arg = mainArgs[i];
    if (arg.startsWith('-')) {
      if (i + 1 < mainArgs.length && !mainArgs[i + 1].startsWith('-')) {
        params[arg] = mainArgs[i + 1];
        i += 2;
      } else {
        params[arg] = null;
        i++;
      }
    } else {
      printMegenta('Invalid: $arg');
    }
  }

  final file = File(params['-c'] ?? 'fl_build.json');
  if (await file.exists()) {
    final content = await file.readAsString();
    final config = json.decode(content) as Map<String, dynamic>;
    makeCfg = MakeCfg.fromJson(config);
  } else {
    printMegenta('Make config is required: ${file.path}');
    exit(1);
  }

  // Before build
  final beforeBuild = makeCfg.beforeBuild;
  if (beforeBuild != null) {
    printBlue('Before build...');
    final result = await Process.run('sh', ['-c', beforeBuild]);
    if (result.exitCode != 0) {
      print(result.stderr);
      exit(1);
    }
  }

  // If [forRelease] is true, it will run all the preparation steps.
  final buildPreparation =
      params.containsKey('-bp') || params.containsKey('-r');
  if (buildPreparation) {
    await updateBuildData(); // Put it at first
    await changePubVersion();
    await changeAppleVersion();
  }

  final forRelease = params.containsKey('-r');
  if (forRelease) {
    await gitSubmmit();
  }

  // If it's running in Github Actions, it will setup the environment.
  await setupGithubEnv();

  // Build
  final platforms = params['-p']?.split(',');
  final scp = params.containsKey('-s') || params.containsKey('--scp');

  if (platforms == null) {
    printRed('No platform specified. Exit.');
    return;
  }

  for (final platform in platforms) {
    final target = Target.fromString(platform);
    final res = await Maker.run(target, passthroughArgs: passthroughArgs);
    if (res == null) continue;
    for (final path in res.pkgPath) {
      if (scp) await Scps.run(target, path);
    }
  }

  // After build
  final afterBuild = makeCfg.afterBuild;
  if (afterBuild != null) {
    printBlue('After build...');
    final result = await Process.run('sh', ['-c', afterBuild]);
    if (result.exitCode != 0) {
      print(result.stderr);
      exit(1);
    }
  }
}
