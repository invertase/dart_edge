// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'edge_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

EdgeConfig _$EdgeConfigFromJson(Map<String, dynamic> json) {
  return _EdgeConfig.fromJson(json);
}

/// @nodoc
mixin _$EdgeConfig {
  VercelEdgeConfig? get vercel_edge => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $EdgeConfigCopyWith<EdgeConfig> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EdgeConfigCopyWith<$Res> {
  factory $EdgeConfigCopyWith(
          EdgeConfig value, $Res Function(EdgeConfig) then) =
      _$EdgeConfigCopyWithImpl<$Res, EdgeConfig>;
  @useResult
  $Res call({VercelEdgeConfig? vercel_edge});

  $VercelEdgeConfigCopyWith<$Res>? get vercel_edge;
}

/// @nodoc
class _$EdgeConfigCopyWithImpl<$Res, $Val extends EdgeConfig>
    implements $EdgeConfigCopyWith<$Res> {
  _$EdgeConfigCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? vercel_edge = freezed,
  }) {
    return _then(_value.copyWith(
      vercel_edge: freezed == vercel_edge
          ? _value.vercel_edge
          : vercel_edge // ignore: cast_nullable_to_non_nullable
              as VercelEdgeConfig?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $VercelEdgeConfigCopyWith<$Res>? get vercel_edge {
    if (_value.vercel_edge == null) {
      return null;
    }

    return $VercelEdgeConfigCopyWith<$Res>(_value.vercel_edge!, (value) {
      return _then(_value.copyWith(vercel_edge: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_EdgeConfigCopyWith<$Res>
    implements $EdgeConfigCopyWith<$Res> {
  factory _$$_EdgeConfigCopyWith(
          _$_EdgeConfig value, $Res Function(_$_EdgeConfig) then) =
      __$$_EdgeConfigCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({VercelEdgeConfig? vercel_edge});

  @override
  $VercelEdgeConfigCopyWith<$Res>? get vercel_edge;
}

/// @nodoc
class __$$_EdgeConfigCopyWithImpl<$Res>
    extends _$EdgeConfigCopyWithImpl<$Res, _$_EdgeConfig>
    implements _$$_EdgeConfigCopyWith<$Res> {
  __$$_EdgeConfigCopyWithImpl(
      _$_EdgeConfig _value, $Res Function(_$_EdgeConfig) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? vercel_edge = freezed,
  }) {
    return _then(_$_EdgeConfig(
      vercel_edge: freezed == vercel_edge
          ? _value.vercel_edge
          : vercel_edge // ignore: cast_nullable_to_non_nullable
              as VercelEdgeConfig?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_EdgeConfig extends _EdgeConfig {
  const _$_EdgeConfig({required this.vercel_edge}) : super._();

  factory _$_EdgeConfig.fromJson(Map<String, dynamic> json) =>
      _$$_EdgeConfigFromJson(json);

  @override
  final VercelEdgeConfig? vercel_edge;

  @override
  String toString() {
    return 'EdgeConfig(vercel_edge: $vercel_edge)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_EdgeConfig &&
            (identical(other.vercel_edge, vercel_edge) ||
                other.vercel_edge == vercel_edge));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, vercel_edge);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_EdgeConfigCopyWith<_$_EdgeConfig> get copyWith =>
      __$$_EdgeConfigCopyWithImpl<_$_EdgeConfig>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_EdgeConfigToJson(
      this,
    );
  }
}

abstract class _EdgeConfig extends EdgeConfig {
  const factory _EdgeConfig({required final VercelEdgeConfig? vercel_edge}) =
      _$_EdgeConfig;
  const _EdgeConfig._() : super._();

  factory _EdgeConfig.fromJson(Map<String, dynamic> json) =
      _$_EdgeConfig.fromJson;

  @override
  VercelEdgeConfig? get vercel_edge;
  @override
  @JsonKey(ignore: true)
  _$$_EdgeConfigCopyWith<_$_EdgeConfig> get copyWith =>
      throw _privateConstructorUsedError;
}
