// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MakeCfg _$MakeCfgFromJson(Map<String, dynamic> json) => _MakeCfg(
  appName: json['appName'] as String,
  beforeBuild: json['beforeBuild'] as String?,
  afterBuild: json['afterBuild'] as String?,
  buildDataClass: json['buildDataClass'] as String? ?? 'BuildData',
  buildDataPath:
      json['buildDataPath'] as String? ?? 'lib/data/res/build_data.dart',
  customArgs:
      (json['customArgs'] as Map<String, dynamic>?)?.map(
        (k, e) =>
            MapEntry(k, (e as List<dynamic>).map((e) => e as String).toList()),
      ) ??
      const <String, List<String>>{},
  platformSetup:
      (json['platformSetup'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ) ??
      const <String, String>{},
);

Map<String, dynamic> _$MakeCfgToJson(_MakeCfg instance) => <String, dynamic>{
  'appName': instance.appName,
  'beforeBuild': instance.beforeBuild,
  'afterBuild': instance.afterBuild,
  'buildDataClass': instance.buildDataClass,
  'buildDataPath': instance.buildDataPath,
  'customArgs': instance.customArgs,
  'platformSetup': instance.platformSetup,
};
