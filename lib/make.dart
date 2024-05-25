import 'dart:io';

import 'package:fl_build/config.dart';
import 'package:fl_build/res.dart';
import 'package:fl_build/utils.dart';

late final MakeCfg makeCfg;

String get appName => makeCfg.appName;

Future<void> flutterBuild(String buildType, {List<String>? customArgs}) async {
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

Future<void> flutterBuildIOS() async {
  await flutterBuild('ipa');
}

Future<void> flutterBuildMacOS() async {
  await flutterBuild('macos');
}

Future<void> flutterBuildAndroid() async {
  await flutterBuild('apk', customArgs: ['--split-per-abi']);

  // {originName: newName}
  final namesMap = {
    'app-arm64-v8a-release.apk': '${appName}_arm64.apk',
    'app-armeabi-v7a-release.apk': '${appName}_arm.apk',
    'app-x86_64-release.apk': '${appName}_amd64.apk',
  };
  for (final entry in namesMap.entries) {
    final origin = entry.key;
    final newName = entry.value;
    await File('$APK_DIR$origin').rename('$APK_DIR$newName');
  }
}

Future<void> setupLinuxDir() async {
  await Directory(LINUX_APP_DIR).create();
  // cp -r assets/app_icon.png linux.AppDir
  await Process.run('cp', [
    '-r',
    './assets/app_icon.png',
    LINUX_APP_DIR,
  ]);
  // Create AppRun
  final appRun = '''
#!/bin/sh
cd "\$(dirname "\$0")"
exec ./$appName
''';
  const appRunName = '$LINUX_APP_DIR/AppRun';
  await File(appRunName).writeAsString(appRun);
  // chmod +x AppRun
  await Process.run('chmod', ['+x', appRunName]);
  // Create .desktop
  final desktop = '''
[Desktop Entry]
Name=$appName
Exec=$appName
Icon=app_icon
Type=Application
Categories=Utility;
''';
  await File('$LINUX_APP_DIR/default.desktop').writeAsString(desktop);
}

Future<void> flutterBuildLinux() async {
  await setupLinuxDir();
  await installAppImageTool();
  await flutterBuild('linux');
  // cp -r build/linux/x64/release/bundle/* appName.AppDir
  await Process.run('cp', [
    '-r',
    'build/linux/x64/release/bundle',
    LINUX_APP_DIR,
  ]);
  // Run appimagetool
  await Process.run('sh', ['-c', 'ARCH=x86_64 ./appimagetool $LINUX_APP_DIR']);
  await File('$appName-x86_64.AppImage').rename('${appName}_amd64.AppImage');
}

Future<void> flutterBuildWin() async {
  await flutterBuild('windows');
  // TODO: Zip build output dir to ./${appName}_amd64.zip
}

Future<void> changeAppleVersion() async {
  for (final path in ['ios', 'macos']) {
    final file = File('$path/$XCODE_CFG_PATH');
    final contents = await file.readAsString();
    final newContents = contents
        .replaceAll(
            REG_APPLE_MARKET_VER, 'MARKETING_VERSION = 1.0.$COMMIT_COUNT;')
        .replaceAll(REG_APPLE_VER, 'CURRENT_PROJECT_VERSION = $COMMIT_COUNT;');
    await file.writeAsString(newContents);
  }
}

// ignore: constant_identifier_names
const BUILD_FUNCS = {
  'ios': flutterBuildIOS,
  'android': flutterBuildAndroid,
  'mac': flutterBuildMacOS,
  'linux': flutterBuildLinux,
  'win': flutterBuildWin,
};
