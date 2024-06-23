import 'dart:convert';
import 'dart:io';

import 'package:fl_build/config.dart';
import 'package:fl_build/res.dart';

extension IterX<T> on Iterable<T> {
  T? firstWhereOrNull(bool Function(T) test) {
    for (final element in this) {
      if (test(element)) {
        return element;
      }
    }
    return null;
  }
}

/// Only can be used in local. If you want to read version at remote (Github
/// Actions), use [buildDataVersion] instead.
final _commitCount = () {
  final result = Process.runSync('git', ['rev-list', '--count', 'HEAD']);
  final val = int.tryParse(result.stdout.toString().trim()) ?? 0;
  // - Before pushing, ver = 1.
  // - After pushing, ver = 2, but the version wrote in remote file is still 1.
  // So, we need to increment the version by 1 to correctly match the version.
  return val + 1;
}();

/// commit + push + gita_tag_push
Future<void> gitSubmmit() async {
  final commitConfirm = await askConfirm('Commit?');
  if (commitConfirm != true) return;
  final commit = await Process.run(
    'git',
    ['commit', '-S', '-m', 'chore: bump version'],
  );
  if (commit.exitCode != 0) {
    print(commit.stderr);
    exit(1);
  }

  final pushConfirm = await askConfirm('Push?');
  if (pushConfirm != true) return;
  final push = await Process.run('git', ['push']);
  if (push.exitCode != 0) {
    print(push.stderr);
    exit(1);
  }

  final tagConfirm = await askConfirm('Tag push?');
  if (tagConfirm != true) return;
  final tagPush = await Process.run(
    'zsh',
    ['-c', '. ~/.zshrc && git_tag_push'],
    runInShell: true,
  );
  if (tagPush.exitCode != 0) {
    print(tagPush.stderr);
    exit(1);
  }
}

Future<void> updateBuildData() async {
  final moreJson = await () async {
    final file = File(MORE_BUILD_DATA_PATH);
    if (!await file.exists()) return <String, dynamic>{};
    final moreData = await file.readAsString();
    final commentRemoved = moreData.split('\n').where((line) {
      final trimmed = line.trim();
      return !trimmed.startsWith('//');
    }).join('\n');
    return json.decode(commentRemoved) as Map<String, dynamic>;
  }();
  final data = {
    'name': appName,
    'build': _commitCount,
    ...moreJson,
  };
  print(JSON_ENCODER.convert(data));

  final buffer = StringBuffer();
  buffer.writeln('// This file is generated by fl_build. Do not edit.');
  buffer.writeln('');
  buffer.writeln('class ${makeCfg.buildDataClass} {');
  for (var entry in data.entries) {
    final type = entry.value.runtimeType;
    final value = json.encode(entry.value);
    buffer.writeln('  static const $type ${entry.key} = $value;');
  }
  buffer.writeln('}');
  await File(makeCfg.buildDataPath).writeAsString(buffer.toString());
}

Future<void> changeAppleVersion() async {
  for (final path in ['ios', 'macos']) {
    final file = File('$path/$XCODE_CFG_PATH');
    final contents = await file.readAsString();
    final newContents = contents
        .replaceAll(
            REG_APPLE_MARKET_VER, 'MARKETING_VERSION = 1.0.$_commitCount;')
        .replaceAll(REG_APPLE_VER, 'CURRENT_PROJECT_VERSION = $_commitCount;');
    await file.writeAsString(newContents);
  }
}

Future<void> dartFormat() async {
  final result = await Process.run('dart', ['format', '.'],
      runInShell: true); // runInShell required on Win to omit .bat ext
  print(result.stdout);
  if (result.exitCode != 0) {
    print(result.stderr);
    exit(1);
  }
}

Future<void> setupLinuxDir() async {
  await Directory(LINUX_APP_DIR).create();

  // cp -r assets/app_icon.png linux.AppDir
  const appIconPath = 'assets/app_icon.png';
  if (!await File(appIconPath).exists()) {
    print('No app_icon.png found in assets.');
    exit(1);
  }
  await Process.run('cp', ['-r', appIconPath, LINUX_APP_DIR]);

  // Create AppRun
  final appRun = '''
#!/bin/sh
cd "\$(dirname "\$0")"
exec ./$appName
''';
  const appRunPath = '$LINUX_APP_DIR/AppRun';
  await File(appRunPath).writeAsString(appRun);

  // chmod +x AppRun
  await Process.run('chmod', ['+x', appRunPath]);

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

Future<void> installLinuxEnv() async {
  if (!Platform.isLinux) return;

  final result = await Process.run('which', ['appimagetool']);
  if (result.exitCode != 0) {
    print('appimagetool is not installed. Installing...');
    const url = 'https://github.com/AppImage/appimagetool/releases/download/'
        'continuous/appimagetool-x86_64.AppImage';
    final dl = await Process.run(
      'sudo',
      ['wget', '-O', '/usr/bin/appimagetool', url],
    );
    if (dl.exitCode != 0) {
      print(dl.stderr);
      exit(1);
    }
    final chmod = await Process.run(
      'sudo',
      ['chmod', '755', '/usr/bin/appimagetool'],
    );
    if (chmod.exitCode != 0) {
      print(chmod.stderr);
      exit(1);
    }
  }

  print('Installing dependencies...');
  const deps = 'clang cmake ninja-build pkg-config libgtk-3-dev '
      'libvulkan-dev desktop-file-utils';
  final apts = await Process.run(
    'sudo',
    ['apt', 'install', '-y', ...deps.split(' ')],
  );
  if (apts.exitCode != 0) {
    print(apts.stderr);
    exit(1);
  }
}

Future<void> setupGithub() async {
  if (envFile == null) {
    print('GITHUB_ENV is not set. Skip writing env.');
    return;
  }

  await installLinuxEnv();

  final env = StringBuffer();
  env.writeln('APP_NAME=$appName');
  env.writeln('BUILD_NUMBER=$buildDataVersion');
  await File(envFile!).writeAsString(env.toString());
}

Future<void> changePubVersion() async {
  final file = File('pubspec.yaml');
  final pubspec = await file.readAsString();
  // Use [replaceFirst] to avoid mistakenly changing other versions.
  final newPubspec = pubspec.replaceFirst(
    REG_PUB_VER,
    'version: 1.0.$_commitCount+$_commitCount',
  );
  await file.writeAsString(newPubspec);
}

Future<bool?> askConfirm(String message, {bool? defaultYes}) async {
  final defaultStr = switch (defaultYes) {
    true => '(Y/n)',
    false => '(y/N)',
    null => '(y/n)',
  };
  stdout.write('$PINK$message$RESET [$defaultStr]: ');
  final input = stdin.readLineSync();
  if (input == null || input.isEmpty) return defaultYes;
  return input.toLowerCase() == 'y';
}
