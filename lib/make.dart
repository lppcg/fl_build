import 'dart:io';

import 'package:fl_build/config.dart';
import 'package:fl_build/target.dart';
import 'package:fl_build/res.dart';
import 'package:fl_build/utils.dart';

final class MakeResult {
  final List<String> pkgPath;

  MakeResult({required this.pkgPath});
}

abstract final class Maker {
  static Future<MakeResult?> run(Target target) async {
    switch (target) {
      case Target.android:
        return await flutterBuildAndroid();
      case Target.ios:
        return await flutterBuildIOS();
      case Target.mac:
        return await flutterBuildMacOS();
      case Target.win:
        return await flutterBuildWin();
      case Target.linux:
        return await flutterBuildLinux();
      default:
        throw ArgumentError('Unsupported target: $target');
    }
  }

  static Future<void> _flutterBuild(
    String buildType, {
    List<String>? customArgs,
  }) async {
    final setup = makeCfg.platformSetup.entries
        .firstWhereOrNull((e) => e.key == buildType)
        ?.value;
    if (setup != null) {
      print('Running platformSetup...');
      final result = await Process.run('sh', ['-c', setup]);
      print(result.stdout);
      if (result.exitCode != 0) {
        print(result.stderr);
        exit(1);
      }
    }

    final makeCfgArgs = makeCfg.customArgs.entries
        .firstWhereOrNull((e) => e.key == buildType)
        ?.value;
    final args = [
      'build',
      buildType,
      '--build-number=$COMMIT_COUNT',
      '--build-name=1.0.$COMMIT_COUNT',
      if (customArgs != null) ...customArgs,
      if (makeCfgArgs != null) ...makeCfgArgs,
    ];

    print('\n[$buildType]\nflutter ${args.join(' ')}');

    final buildResult = await Process.run('flutter', args);
    final exitCode = buildResult.exitCode;
    if (exitCode != 0) {
      print(buildResult.stdout);
      print(buildResult.stderr);
      exit(exitCode);
    }
  }

  static Future<MakeResult?> flutterBuildIOS() async {
    await _flutterBuild('ipa');
    return null;
  }

  static Future<MakeResult?> flutterBuildMacOS() async {
    await _flutterBuild('macos');
    return null;
  }

  static Future<MakeResult?> flutterBuildAndroid() async {
    await _flutterBuild('apk', customArgs: ['--split-per-abi']);

    // {originName: newName}
    final namesMap = {
      'app-arm64-v8a-release.apk': '${appName}_${COMMIT_COUNT}_arm64.apk',
      'app-armeabi-v7a-release.apk': '${appName}_${COMMIT_COUNT}_arm.apk',
      'app-x86_64-release.apk': '${appName}_${COMMIT_COUNT}_amd64.apk',
    };
    for (final entry in namesMap.entries) {
      final origin = entry.key;
      final newName = entry.value;
      await File('$APK_DIR$origin').rename('$APK_DIR$newName');
    }

    return MakeResult(
        pkgPath: namesMap.values.map((e) => '$APK_DIR$e').toList());
  }

  static Future<MakeResult?> flutterBuildLinux() async {
    await setupLinuxDir();
    await _flutterBuild('linux');
    // cp -r build/linux/x64/release/bundle/* appName.AppDir
    await Process.run('cp', [
      '-r',
      'build/linux/x64/release/bundle',
      LINUX_APP_DIR,
    ]);
    // Run appimagetool
    final appimg = await Process.run(
      'appimagetool',
      [LINUX_APP_DIR],
      environment: {'ARCH': 'x86_64'},
    );
    if (appimg.exitCode != 0) {
      print(appimg.stdout);
      print(appimg.stderr);
      exit(appimg.exitCode);
    }

    final pkgPath = '${appName}_${COMMIT_COUNT}_amd64.AppImage';
    await File('$appName-x86_64.AppImage').rename(pkgPath);
    return MakeResult(pkgPath: [pkgPath]);
  }

  static Future<MakeResult?> flutterBuildWin() async {
    await _flutterBuild('windows');
    // TODO: Zip build output dir to ./${appName}_${COMMIT_COUNT}_amd64.zip

    return MakeResult(pkgPath: []);
  }
}
