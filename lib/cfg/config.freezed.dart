// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MakeCfg {

 String get appName;/// Command to run before build.
 String? get beforeBuild;/// Command to run after build.
 String? get afterBuild; String get buildDataClass; String get buildDataPath;/// Custom arguments for each build type.
 Map<String, List<String>> get customArgs;/// Cmds that runs before [flutterBuild]
 Map<String, String> get platformSetup;
/// Create a copy of MakeCfg
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MakeCfgCopyWith<MakeCfg> get copyWith => _$MakeCfgCopyWithImpl<MakeCfg>(this as MakeCfg, _$identity);

  /// Serializes this MakeCfg to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MakeCfg&&(identical(other.appName, appName) || other.appName == appName)&&(identical(other.beforeBuild, beforeBuild) || other.beforeBuild == beforeBuild)&&(identical(other.afterBuild, afterBuild) || other.afterBuild == afterBuild)&&(identical(other.buildDataClass, buildDataClass) || other.buildDataClass == buildDataClass)&&(identical(other.buildDataPath, buildDataPath) || other.buildDataPath == buildDataPath)&&const DeepCollectionEquality().equals(other.customArgs, customArgs)&&const DeepCollectionEquality().equals(other.platformSetup, platformSetup));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,appName,beforeBuild,afterBuild,buildDataClass,buildDataPath,const DeepCollectionEquality().hash(customArgs),const DeepCollectionEquality().hash(platformSetup));

@override
String toString() {
  return 'MakeCfg(appName: $appName, beforeBuild: $beforeBuild, afterBuild: $afterBuild, buildDataClass: $buildDataClass, buildDataPath: $buildDataPath, customArgs: $customArgs, platformSetup: $platformSetup)';
}


}

/// @nodoc
abstract mixin class $MakeCfgCopyWith<$Res>  {
  factory $MakeCfgCopyWith(MakeCfg value, $Res Function(MakeCfg) _then) = _$MakeCfgCopyWithImpl;
@useResult
$Res call({
 String appName, String? beforeBuild, String? afterBuild, String buildDataClass, String buildDataPath, Map<String, List<String>> customArgs, Map<String, String> platformSetup
});




}
/// @nodoc
class _$MakeCfgCopyWithImpl<$Res>
    implements $MakeCfgCopyWith<$Res> {
  _$MakeCfgCopyWithImpl(this._self, this._then);

  final MakeCfg _self;
  final $Res Function(MakeCfg) _then;

/// Create a copy of MakeCfg
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? appName = null,Object? beforeBuild = freezed,Object? afterBuild = freezed,Object? buildDataClass = null,Object? buildDataPath = null,Object? customArgs = null,Object? platformSetup = null,}) {
  return _then(_self.copyWith(
appName: null == appName ? _self.appName : appName // ignore: cast_nullable_to_non_nullable
as String,beforeBuild: freezed == beforeBuild ? _self.beforeBuild : beforeBuild // ignore: cast_nullable_to_non_nullable
as String?,afterBuild: freezed == afterBuild ? _self.afterBuild : afterBuild // ignore: cast_nullable_to_non_nullable
as String?,buildDataClass: null == buildDataClass ? _self.buildDataClass : buildDataClass // ignore: cast_nullable_to_non_nullable
as String,buildDataPath: null == buildDataPath ? _self.buildDataPath : buildDataPath // ignore: cast_nullable_to_non_nullable
as String,customArgs: null == customArgs ? _self.customArgs : customArgs // ignore: cast_nullable_to_non_nullable
as Map<String, List<String>>,platformSetup: null == platformSetup ? _self.platformSetup : platformSetup // ignore: cast_nullable_to_non_nullable
as Map<String, String>,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _MakeCfg implements MakeCfg {
  const _MakeCfg({required this.appName, this.beforeBuild, this.afterBuild, this.buildDataClass = 'BuildData', this.buildDataPath = 'lib/data/res/build_data.dart', final  Map<String, List<String>> customArgs = const <String, List<String>>{}, final  Map<String, String> platformSetup = const <String, String>{}}): _customArgs = customArgs,_platformSetup = platformSetup;
  factory _MakeCfg.fromJson(Map<String, dynamic> json) => _$MakeCfgFromJson(json);

@override final  String appName;
/// Command to run before build.
@override final  String? beforeBuild;
/// Command to run after build.
@override final  String? afterBuild;
@override@JsonKey() final  String buildDataClass;
@override@JsonKey() final  String buildDataPath;
/// Custom arguments for each build type.
 final  Map<String, List<String>> _customArgs;
/// Custom arguments for each build type.
@override@JsonKey() Map<String, List<String>> get customArgs {
  if (_customArgs is EqualUnmodifiableMapView) return _customArgs;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_customArgs);
}

/// Cmds that runs before [flutterBuild]
 final  Map<String, String> _platformSetup;
/// Cmds that runs before [flutterBuild]
@override@JsonKey() Map<String, String> get platformSetup {
  if (_platformSetup is EqualUnmodifiableMapView) return _platformSetup;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_platformSetup);
}


/// Create a copy of MakeCfg
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MakeCfgCopyWith<_MakeCfg> get copyWith => __$MakeCfgCopyWithImpl<_MakeCfg>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MakeCfgToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MakeCfg&&(identical(other.appName, appName) || other.appName == appName)&&(identical(other.beforeBuild, beforeBuild) || other.beforeBuild == beforeBuild)&&(identical(other.afterBuild, afterBuild) || other.afterBuild == afterBuild)&&(identical(other.buildDataClass, buildDataClass) || other.buildDataClass == buildDataClass)&&(identical(other.buildDataPath, buildDataPath) || other.buildDataPath == buildDataPath)&&const DeepCollectionEquality().equals(other._customArgs, _customArgs)&&const DeepCollectionEquality().equals(other._platformSetup, _platformSetup));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,appName,beforeBuild,afterBuild,buildDataClass,buildDataPath,const DeepCollectionEquality().hash(_customArgs),const DeepCollectionEquality().hash(_platformSetup));

@override
String toString() {
  return 'MakeCfg(appName: $appName, beforeBuild: $beforeBuild, afterBuild: $afterBuild, buildDataClass: $buildDataClass, buildDataPath: $buildDataPath, customArgs: $customArgs, platformSetup: $platformSetup)';
}


}

/// @nodoc
abstract mixin class _$MakeCfgCopyWith<$Res> implements $MakeCfgCopyWith<$Res> {
  factory _$MakeCfgCopyWith(_MakeCfg value, $Res Function(_MakeCfg) _then) = __$MakeCfgCopyWithImpl;
@override @useResult
$Res call({
 String appName, String? beforeBuild, String? afterBuild, String buildDataClass, String buildDataPath, Map<String, List<String>> customArgs, Map<String, String> platformSetup
});




}
/// @nodoc
class __$MakeCfgCopyWithImpl<$Res>
    implements _$MakeCfgCopyWith<$Res> {
  __$MakeCfgCopyWithImpl(this._self, this._then);

  final _MakeCfg _self;
  final $Res Function(_MakeCfg) _then;

/// Create a copy of MakeCfg
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? appName = null,Object? beforeBuild = freezed,Object? afterBuild = freezed,Object? buildDataClass = null,Object? buildDataPath = null,Object? customArgs = null,Object? platformSetup = null,}) {
  return _then(_MakeCfg(
appName: null == appName ? _self.appName : appName // ignore: cast_nullable_to_non_nullable
as String,beforeBuild: freezed == beforeBuild ? _self.beforeBuild : beforeBuild // ignore: cast_nullable_to_non_nullable
as String?,afterBuild: freezed == afterBuild ? _self.afterBuild : afterBuild // ignore: cast_nullable_to_non_nullable
as String?,buildDataClass: null == buildDataClass ? _self.buildDataClass : buildDataClass // ignore: cast_nullable_to_non_nullable
as String,buildDataPath: null == buildDataPath ? _self.buildDataPath : buildDataPath // ignore: cast_nullable_to_non_nullable
as String,customArgs: null == customArgs ? _self._customArgs : customArgs // ignore: cast_nullable_to_non_nullable
as Map<String, List<String>>,platformSetup: null == platformSetup ? _self._platformSetup : platformSetup // ignore: cast_nullable_to_non_nullable
as Map<String, String>,
  ));
}


}

// dart format on
