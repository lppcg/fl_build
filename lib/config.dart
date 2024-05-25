final class MakeCfg {
  final String appName;
  /// Command to run before build.
  final String? beforeBuild;
  /// Command to run after build.
  final String? afterBuild;
  final String buildDataClass;
  final String buildDataPath;
  /// Custom arguments for each build type.
  final Map<String, List<String>> customArgs;

  MakeCfg({
    required this.appName,
    this.beforeBuild,
    this.afterBuild,
    required this.buildDataClass,
    required this.buildDataPath,
    required this.customArgs,
  });

  factory MakeCfg.fromJson(Map<String, dynamic> json) {
    try {
      return MakeCfg(
        appName: json['appName'] as String,
        beforeBuild: json['beforeBuild'] as String?,
        afterBuild: json['afterBuild'] as String?,
        buildDataClass: json['buildDataClass'] as String? ?? 'BuildData',
        buildDataPath:
            json['buildDataPath'] as String? ?? 'lib/data/res/build_data.dart',
        customArgs: (json['customArgs'] as Map<String, dynamic>?)?.map(
          (key, value) => MapEntry(key, (value as List).cast<String>()),
        ) ?? {},
      );
    } catch (e) {
      throw ArgumentError('Invalid config: $e');
    }
  }
}
