// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'vercel_edge_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

VercelEdgeConfig _$VercelEdgeConfigFromJson(Map<String, dynamic> json) {
  return _VercelEdgeConfig.fromJson(json);
}

/// @nodoc
mixin _$VercelEdgeConfig {
  Iterable<EntryPoint> get entrypoints => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $VercelEdgeConfigCopyWith<VercelEdgeConfig> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VercelEdgeConfigCopyWith<$Res> {
  factory $VercelEdgeConfigCopyWith(
          VercelEdgeConfig value, $Res Function(VercelEdgeConfig) then) =
      _$VercelEdgeConfigCopyWithImpl<$Res, VercelEdgeConfig>;
  @useResult
  $Res call({Iterable<EntryPoint> entrypoints});
}

/// @nodoc
class _$VercelEdgeConfigCopyWithImpl<$Res, $Val extends VercelEdgeConfig>
    implements $VercelEdgeConfigCopyWith<$Res> {
  _$VercelEdgeConfigCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? entrypoints = null,
  }) {
    return _then(_value.copyWith(
      entrypoints: null == entrypoints
          ? _value.entrypoints
          : entrypoints // ignore: cast_nullable_to_non_nullable
              as Iterable<EntryPoint>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_VercelEdgeConfigCopyWith<$Res>
    implements $VercelEdgeConfigCopyWith<$Res> {
  factory _$$_VercelEdgeConfigCopyWith(
          _$_VercelEdgeConfig value, $Res Function(_$_VercelEdgeConfig) then) =
      __$$_VercelEdgeConfigCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Iterable<EntryPoint> entrypoints});
}

/// @nodoc
class __$$_VercelEdgeConfigCopyWithImpl<$Res>
    extends _$VercelEdgeConfigCopyWithImpl<$Res, _$_VercelEdgeConfig>
    implements _$$_VercelEdgeConfigCopyWith<$Res> {
  __$$_VercelEdgeConfigCopyWithImpl(
      _$_VercelEdgeConfig _value, $Res Function(_$_VercelEdgeConfig) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? entrypoints = null,
  }) {
    return _then(_$_VercelEdgeConfig(
      entrypoints: null == entrypoints
          ? _value.entrypoints
          : entrypoints // ignore: cast_nullable_to_non_nullable
              as Iterable<EntryPoint>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_VercelEdgeConfig implements _VercelEdgeConfig {
  const _$_VercelEdgeConfig({required this.entrypoints});

  factory _$_VercelEdgeConfig.fromJson(Map<String, dynamic> json) =>
      _$$_VercelEdgeConfigFromJson(json);

  @override
  final Iterable<EntryPoint> entrypoints;

  @override
  String toString() {
    return 'VercelEdgeConfig(entrypoints: $entrypoints)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_VercelEdgeConfig &&
            const DeepCollectionEquality()
                .equals(other.entrypoints, entrypoints));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(entrypoints));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_VercelEdgeConfigCopyWith<_$_VercelEdgeConfig> get copyWith =>
      __$$_VercelEdgeConfigCopyWithImpl<_$_VercelEdgeConfig>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_VercelEdgeConfigToJson(
      this,
    );
  }
}

abstract class _VercelEdgeConfig implements VercelEdgeConfig {
  const factory _VercelEdgeConfig(
      {required final Iterable<EntryPoint> entrypoints}) = _$_VercelEdgeConfig;

  factory _VercelEdgeConfig.fromJson(Map<String, dynamic> json) =
      _$_VercelEdgeConfig.fromJson;

  @override
  Iterable<EntryPoint> get entrypoints;
  @override
  @JsonKey(ignore: true)
  _$$_VercelEdgeConfigCopyWith<_$_VercelEdgeConfig> get copyWith =>
      throw _privateConstructorUsedError;
}

EntryPoint _$EntryPointFromJson(Map<String, dynamic> json) {
  return _EntryPoint.fromJson(json);
}

/// @nodoc
mixin _$EntryPoint {
  String? get name => throw _privateConstructorUsedError;
  String? get schedule => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $EntryPointCopyWith<EntryPoint> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EntryPointCopyWith<$Res> {
  factory $EntryPointCopyWith(
          EntryPoint value, $Res Function(EntryPoint) then) =
      _$EntryPointCopyWithImpl<$Res, EntryPoint>;
  @useResult
  $Res call({String? name, String? schedule});
}

/// @nodoc
class _$EntryPointCopyWithImpl<$Res, $Val extends EntryPoint>
    implements $EntryPointCopyWith<$Res> {
  _$EntryPointCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? schedule = freezed,
  }) {
    return _then(_value.copyWith(
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      schedule: freezed == schedule
          ? _value.schedule
          : schedule // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_EntryPointCopyWith<$Res>
    implements $EntryPointCopyWith<$Res> {
  factory _$$_EntryPointCopyWith(
          _$_EntryPoint value, $Res Function(_$_EntryPoint) then) =
      __$$_EntryPointCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? name, String? schedule});
}

/// @nodoc
class __$$_EntryPointCopyWithImpl<$Res>
    extends _$EntryPointCopyWithImpl<$Res, _$_EntryPoint>
    implements _$$_EntryPointCopyWith<$Res> {
  __$$_EntryPointCopyWithImpl(
      _$_EntryPoint _value, $Res Function(_$_EntryPoint) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? schedule = freezed,
  }) {
    return _then(_$_EntryPoint(
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      schedule: freezed == schedule
          ? _value.schedule
          : schedule // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_EntryPoint implements _EntryPoint {
  const _$_EntryPoint({required this.name, required this.schedule});

  factory _$_EntryPoint.fromJson(Map<String, dynamic> json) =>
      _$$_EntryPointFromJson(json);

  @override
  final String? name;
  @override
  final String? schedule;

  @override
  String toString() {
    return 'EntryPoint(name: $name, schedule: $schedule)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_EntryPoint &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.schedule, schedule) ||
                other.schedule == schedule));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, name, schedule);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_EntryPointCopyWith<_$_EntryPoint> get copyWith =>
      __$$_EntryPointCopyWithImpl<_$_EntryPoint>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_EntryPointToJson(
      this,
    );
  }
}

abstract class _EntryPoint implements EntryPoint {
  const factory _EntryPoint(
      {required final String? name,
      required final String? schedule}) = _$_EntryPoint;

  factory _EntryPoint.fromJson(Map<String, dynamic> json) =
      _$_EntryPoint.fromJson;

  @override
  String? get name;
  @override
  String? get schedule;
  @override
  @JsonKey(ignore: true)
  _$$_EntryPointCopyWith<_$_EntryPoint> get copyWith =>
      throw _privateConstructorUsedError;
}
