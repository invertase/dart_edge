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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Config _$ConfigFromJson(Map<String, dynamic> json) {
  return _Config.fromJson(json);
}

/// @nodoc
mixin _$Config {
  SupabaseConfig get supabase => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ConfigCopyWith<Config> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConfigCopyWith<$Res> {
  factory $ConfigCopyWith(Config value, $Res Function(Config) then) =
      _$ConfigCopyWithImpl<$Res, Config>;
  @useResult
  $Res call({SupabaseConfig supabase});

  $SupabaseConfigCopyWith<$Res> get supabase;
}

/// @nodoc
class _$ConfigCopyWithImpl<$Res, $Val extends Config>
    implements $ConfigCopyWith<$Res> {
  _$ConfigCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? supabase = null,
  }) {
    return _then(_value.copyWith(
      supabase: null == supabase
          ? _value.supabase
          : supabase // ignore: cast_nullable_to_non_nullable
              as SupabaseConfig,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $SupabaseConfigCopyWith<$Res> get supabase {
    return $SupabaseConfigCopyWith<$Res>(_value.supabase, (value) {
      return _then(_value.copyWith(supabase: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_ConfigCopyWith<$Res> implements $ConfigCopyWith<$Res> {
  factory _$$_ConfigCopyWith(_$_Config value, $Res Function(_$_Config) then) =
      __$$_ConfigCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({SupabaseConfig supabase});

  @override
  $SupabaseConfigCopyWith<$Res> get supabase;
}

/// @nodoc
class __$$_ConfigCopyWithImpl<$Res>
    extends _$ConfigCopyWithImpl<$Res, _$_Config>
    implements _$$_ConfigCopyWith<$Res> {
  __$$_ConfigCopyWithImpl(_$_Config _value, $Res Function(_$_Config) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? supabase = null,
  }) {
    return _then(_$_Config(
      supabase: null == supabase
          ? _value.supabase
          : supabase // ignore: cast_nullable_to_non_nullable
              as SupabaseConfig,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Config implements _Config {
  const _$_Config({this.supabase = const SupabaseConfig()});

  factory _$_Config.fromJson(Map<String, dynamic> json) =>
      _$$_ConfigFromJson(json);

  @override
  @JsonKey()
  final SupabaseConfig supabase;

  @override
  String toString() {
    return 'Config(supabase: $supabase)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Config &&
            (identical(other.supabase, supabase) ||
                other.supabase == supabase));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, supabase);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ConfigCopyWith<_$_Config> get copyWith =>
      __$$_ConfigCopyWithImpl<_$_Config>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ConfigToJson(
      this,
    );
  }
}

abstract class _Config implements Config {
  const factory _Config({final SupabaseConfig supabase}) = _$_Config;

  factory _Config.fromJson(Map<String, dynamic> json) = _$_Config.fromJson;

  @override
  SupabaseConfig get supabase;
  @override
  @JsonKey(ignore: true)
  _$$_ConfigCopyWith<_$_Config> get copyWith =>
      throw _privateConstructorUsedError;
}

SupabaseConfig _$SupabaseConfigFromJson(Map<String, dynamic> json) {
  return _SupabaseConfig.fromJson(json);
}

/// @nodoc
mixin _$SupabaseConfig {
  @JsonKey(name: 'project_path')
  String get projectPath => throw _privateConstructorUsedError;
  Map<String, String> get functions => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SupabaseConfigCopyWith<SupabaseConfig> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SupabaseConfigCopyWith<$Res> {
  factory $SupabaseConfigCopyWith(
          SupabaseConfig value, $Res Function(SupabaseConfig) then) =
      _$SupabaseConfigCopyWithImpl<$Res, SupabaseConfig>;
  @useResult
  $Res call(
      {@JsonKey(name: 'project_path') String projectPath,
      Map<String, String> functions});
}

/// @nodoc
class _$SupabaseConfigCopyWithImpl<$Res, $Val extends SupabaseConfig>
    implements $SupabaseConfigCopyWith<$Res> {
  _$SupabaseConfigCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? projectPath = null,
    Object? functions = null,
  }) {
    return _then(_value.copyWith(
      projectPath: null == projectPath
          ? _value.projectPath
          : projectPath // ignore: cast_nullable_to_non_nullable
              as String,
      functions: null == functions
          ? _value.functions
          : functions // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_SupabaseConfigCopyWith<$Res>
    implements $SupabaseConfigCopyWith<$Res> {
  factory _$$_SupabaseConfigCopyWith(
          _$_SupabaseConfig value, $Res Function(_$_SupabaseConfig) then) =
      __$$_SupabaseConfigCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'project_path') String projectPath,
      Map<String, String> functions});
}

/// @nodoc
class __$$_SupabaseConfigCopyWithImpl<$Res>
    extends _$SupabaseConfigCopyWithImpl<$Res, _$_SupabaseConfig>
    implements _$$_SupabaseConfigCopyWith<$Res> {
  __$$_SupabaseConfigCopyWithImpl(
      _$_SupabaseConfig _value, $Res Function(_$_SupabaseConfig) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? projectPath = null,
    Object? functions = null,
  }) {
    return _then(_$_SupabaseConfig(
      projectPath: null == projectPath
          ? _value.projectPath
          : projectPath // ignore: cast_nullable_to_non_nullable
              as String,
      functions: null == functions
          ? _value._functions
          : functions // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_SupabaseConfig implements _SupabaseConfig {
  const _$_SupabaseConfig(
      {@JsonKey(name: 'project_path') this.projectPath = '.',
      final Map<String, String> functions = const <String, String>{
        'dart_edge': 'lib/main.dart'
      }})
      : _functions = functions;

  factory _$_SupabaseConfig.fromJson(Map<String, dynamic> json) =>
      _$$_SupabaseConfigFromJson(json);

  @override
  @JsonKey(name: 'project_path')
  final String projectPath;
  final Map<String, String> _functions;
  @override
  @JsonKey()
  Map<String, String> get functions {
    if (_functions is EqualUnmodifiableMapView) return _functions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_functions);
  }

  @override
  String toString() {
    return 'SupabaseConfig(projectPath: $projectPath, functions: $functions)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SupabaseConfig &&
            (identical(other.projectPath, projectPath) ||
                other.projectPath == projectPath) &&
            const DeepCollectionEquality()
                .equals(other._functions, _functions));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, projectPath,
      const DeepCollectionEquality().hash(_functions));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SupabaseConfigCopyWith<_$_SupabaseConfig> get copyWith =>
      __$$_SupabaseConfigCopyWithImpl<_$_SupabaseConfig>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_SupabaseConfigToJson(
      this,
    );
  }
}

abstract class _SupabaseConfig implements SupabaseConfig {
  const factory _SupabaseConfig(
      {@JsonKey(name: 'project_path') final String projectPath,
      final Map<String, String> functions}) = _$_SupabaseConfig;

  factory _SupabaseConfig.fromJson(Map<String, dynamic> json) =
      _$_SupabaseConfig.fromJson;

  @override
  @JsonKey(name: 'project_path')
  String get projectPath;
  @override
  Map<String, String> get functions;
  @override
  @JsonKey(ignore: true)
  _$$_SupabaseConfigCopyWith<_$_SupabaseConfig> get copyWith =>
      throw _privateConstructorUsedError;
}
