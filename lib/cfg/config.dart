import 'dart:io';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'config.g.dart';
part 'config.freezed.dart';

late final MakeCfg makeCfg;

String get appName => makeCfg.appName;
String get appNameLower => appName.toLowerCase();

final buildDataVersion = () {
  final file = File(makeCfg.buildDataPath);
  if (!file.existsSync()) return 0;
  final contents = file.readAsStringSync();
  final match = RegExp(r'static const int build = (\d+);').firstMatch(contents);
  return int.tryParse(match?.group(1) ?? '0') ?? 0;
}();

@freezed
abstract class MakeCfg with _$MakeCfg {
  const factory MakeCfg({
    required String appName,

    /// Command to run before build.
    String? beforeBuild,

    /// Command to run after build.
    String? afterBuild,
    @Default('BuildData') String buildDataClass,
    @Default('lib/data/res/build_data.dart') String buildDataPath,

    /// Custom arguments for each build type.
    @Default(<String, List<String>>{}) Map<String, List<String>> customArgs,

    /// Cmds that runs before [flutterBuild]
    @Default(<String, String>{}) Map<String, String> platformSetup,
  }) = _MakeCfg;

  factory MakeCfg.fromJson(Map<String, dynamic> json) => _$MakeCfgFromJson(json);

  factory MakeCfg.fromMap(Map<String, dynamic> map) => _$MakeCfgFromJson(map);
}
