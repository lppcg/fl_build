// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

MakeCfg _$MakeCfgFromJson(Map<String, dynamic> json) {
  return _MakeCfg.fromJson(json);
}

/// @nodoc
mixin _$MakeCfg {
  String get appName => throw _privateConstructorUsedError;

  /// Command to run before build.
  String? get beforeBuild => throw _privateConstructorUsedError;

  /// Command to run after build.
  String? get afterBuild => throw _privateConstructorUsedError;
  String get buildDataClass => throw _privateConstructorUsedError;
  String get buildDataPath => throw _privateConstructorUsedError;

  /// Custom arguments for each build type.
  Map<String, List<String>> get customArgs =>
      throw _privateConstructorUsedError;

  /// Cmds that runs before [flutterBuild]
  Map<String, String> get platformSetup => throw _privateConstructorUsedError;

  /// Serializes this MakeCfg to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MakeCfg
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MakeCfgCopyWith<MakeCfg> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MakeCfgCopyWith<$Res> {
  factory $MakeCfgCopyWith(MakeCfg value, $Res Function(MakeCfg) then) =
      _$MakeCfgCopyWithImpl<$Res, MakeCfg>;
  @useResult
  $Res call(
      {String appName,
      String? beforeBuild,
      String? afterBuild,
      String buildDataClass,
      String buildDataPath,
      Map<String, List<String>> customArgs,
      Map<String, String> platformSetup});
}

/// @nodoc
class _$MakeCfgCopyWithImpl<$Res, $Val extends MakeCfg>
    implements $MakeCfgCopyWith<$Res> {
  _$MakeCfgCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MakeCfg
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? appName = null,
    Object? beforeBuild = freezed,
    Object? afterBuild = freezed,
    Object? buildDataClass = null,
    Object? buildDataPath = null,
    Object? customArgs = null,
    Object? platformSetup = null,
  }) {
    return _then(_value.copyWith(
      appName: null == appName
          ? _value.appName
          : appName // ignore: cast_nullable_to_non_nullable
              as String,
      beforeBuild: freezed == beforeBuild
          ? _value.beforeBuild
          : beforeBuild // ignore: cast_nullable_to_non_nullable
              as String?,
      afterBuild: freezed == afterBuild
          ? _value.afterBuild
          : afterBuild // ignore: cast_nullable_to_non_nullable
              as String?,
      buildDataClass: null == buildDataClass
          ? _value.buildDataClass
          : buildDataClass // ignore: cast_nullable_to_non_nullable
              as String,
      buildDataPath: null == buildDataPath
          ? _value.buildDataPath
          : buildDataPath // ignore: cast_nullable_to_non_nullable
              as String,
      customArgs: null == customArgs
          ? _value.customArgs
          : customArgs // ignore: cast_nullable_to_non_nullable
              as Map<String, List<String>>,
      platformSetup: null == platformSetup
          ? _value.platformSetup
          : platformSetup // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MakeCfgImplCopyWith<$Res> implements $MakeCfgCopyWith<$Res> {
  factory _$$MakeCfgImplCopyWith(
          _$MakeCfgImpl value, $Res Function(_$MakeCfgImpl) then) =
      __$$MakeCfgImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String appName,
      String? beforeBuild,
      String? afterBuild,
      String buildDataClass,
      String buildDataPath,
      Map<String, List<String>> customArgs,
      Map<String, String> platformSetup});
}

/// @nodoc
class __$$MakeCfgImplCopyWithImpl<$Res>
    extends _$MakeCfgCopyWithImpl<$Res, _$MakeCfgImpl>
    implements _$$MakeCfgImplCopyWith<$Res> {
  __$$MakeCfgImplCopyWithImpl(
      _$MakeCfgImpl _value, $Res Function(_$MakeCfgImpl) _then)
      : super(_value, _then);

  /// Create a copy of MakeCfg
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? appName = null,
    Object? beforeBuild = freezed,
    Object? afterBuild = freezed,
    Object? buildDataClass = null,
    Object? buildDataPath = null,
    Object? customArgs = null,
    Object? platformSetup = null,
  }) {
    return _then(_$MakeCfgImpl(
      appName: null == appName
          ? _value.appName
          : appName // ignore: cast_nullable_to_non_nullable
              as String,
      beforeBuild: freezed == beforeBuild
          ? _value.beforeBuild
          : beforeBuild // ignore: cast_nullable_to_non_nullable
              as String?,
      afterBuild: freezed == afterBuild
          ? _value.afterBuild
          : afterBuild // ignore: cast_nullable_to_non_nullable
              as String?,
      buildDataClass: null == buildDataClass
          ? _value.buildDataClass
          : buildDataClass // ignore: cast_nullable_to_non_nullable
              as String,
      buildDataPath: null == buildDataPath
          ? _value.buildDataPath
          : buildDataPath // ignore: cast_nullable_to_non_nullable
              as String,
      customArgs: null == customArgs
          ? _value._customArgs
          : customArgs // ignore: cast_nullable_to_non_nullable
              as Map<String, List<String>>,
      platformSetup: null == platformSetup
          ? _value._platformSetup
          : platformSetup // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MakeCfgImpl implements _MakeCfg {
  const _$MakeCfgImpl(
      {required this.appName,
      this.beforeBuild,
      this.afterBuild,
      this.buildDataClass = 'BuildData',
      this.buildDataPath = 'lib/data/res/build_data.dart',
      final Map<String, List<String>> customArgs =
          const <String, List<String>>{},
      final Map<String, String> platformSetup = const <String, String>{}})
      : _customArgs = customArgs,
        _platformSetup = platformSetup;

  factory _$MakeCfgImpl.fromJson(Map<String, dynamic> json) =>
      _$$MakeCfgImplFromJson(json);

  @override
  final String appName;

  /// Command to run before build.
  @override
  final String? beforeBuild;

  /// Command to run after build.
  @override
  final String? afterBuild;
  @override
  @JsonKey()
  final String buildDataClass;
  @override
  @JsonKey()
  final String buildDataPath;

  /// Custom arguments for each build type.
  final Map<String, List<String>> _customArgs;

  /// Custom arguments for each build type.
  @override
  @JsonKey()
  Map<String, List<String>> get customArgs {
    if (_customArgs is EqualUnmodifiableMapView) return _customArgs;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_customArgs);
  }

  /// Cmds that runs before [flutterBuild]
  final Map<String, String> _platformSetup;

  /// Cmds that runs before [flutterBuild]
  @override
  @JsonKey()
  Map<String, String> get platformSetup {
    if (_platformSetup is EqualUnmodifiableMapView) return _platformSetup;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_platformSetup);
  }

  @override
  String toString() {
    return 'MakeCfg(appName: $appName, beforeBuild: $beforeBuild, afterBuild: $afterBuild, buildDataClass: $buildDataClass, buildDataPath: $buildDataPath, customArgs: $customArgs, platformSetup: $platformSetup)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MakeCfgImpl &&
            (identical(other.appName, appName) || other.appName == appName) &&
            (identical(other.beforeBuild, beforeBuild) ||
                other.beforeBuild == beforeBuild) &&
            (identical(other.afterBuild, afterBuild) ||
                other.afterBuild == afterBuild) &&
            (identical(other.buildDataClass, buildDataClass) ||
                other.buildDataClass == buildDataClass) &&
            (identical(other.buildDataPath, buildDataPath) ||
                other.buildDataPath == buildDataPath) &&
            const DeepCollectionEquality()
                .equals(other._customArgs, _customArgs) &&
            const DeepCollectionEquality()
                .equals(other._platformSetup, _platformSetup));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      appName,
      beforeBuild,
      afterBuild,
      buildDataClass,
      buildDataPath,
      const DeepCollectionEquality().hash(_customArgs),
      const DeepCollectionEquality().hash(_platformSetup));

  /// Create a copy of MakeCfg
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MakeCfgImplCopyWith<_$MakeCfgImpl> get copyWith =>
      __$$MakeCfgImplCopyWithImpl<_$MakeCfgImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MakeCfgImplToJson(
      this,
    );
  }
}

abstract class _MakeCfg implements MakeCfg {
  const factory _MakeCfg(
      {required final String appName,
      final String? beforeBuild,
      final String? afterBuild,
      final String buildDataClass,
      final String buildDataPath,
      final Map<String, List<String>> customArgs,
      final Map<String, String> platformSetup}) = _$MakeCfgImpl;

  factory _MakeCfg.fromJson(Map<String, dynamic> json) = _$MakeCfgImpl.fromJson;

  @override
  String get appName;

  /// Command to run before build.
  @override
  String? get beforeBuild;

  /// Command to run after build.
  @override
  String? get afterBuild;
  @override
  String get buildDataClass;
  @override
  String get buildDataPath;

  /// Custom arguments for each build type.
  @override
  Map<String, List<String>> get customArgs;

  /// Cmds that runs before [flutterBuild]
  @override
  Map<String, String> get platformSetup;

  /// Create a copy of MakeCfg
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MakeCfgImplCopyWith<_$MakeCfgImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
