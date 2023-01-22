// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'resource.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$Resource {
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(String url) $default, {
    required TResult Function(Uri uri) uri,
    required TResult Function(Request request) request,
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc

class _$UrlType implements UrlType {
  const _$UrlType(this.url);

  @override
  final String url;

  @override
  String toString() {
    return 'Resource(url: $url)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UrlType &&
            (identical(other.url, url) || other.url == url));
  }

  @override
  int get hashCode => Object.hash(runtimeType, url);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(String url) $default, {
    required TResult Function(Uri uri) uri,
    required TResult Function(Request request) request,
  }) {
    return $default(url);
  }
}

abstract class UrlType implements Resource {
  const factory UrlType(final String url) = _$UrlType;

  String get url;
}

/// @nodoc

class _$UriType implements UriType {
  const _$UriType(this.uri);

  @override
  final Uri uri;

  @override
  String toString() {
    return 'Resource.uri(uri: $uri)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UriType &&
            (identical(other.uri, uri) || other.uri == uri));
  }

  @override
  int get hashCode => Object.hash(runtimeType, uri);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(String url) $default, {
    required TResult Function(Uri uri) uri,
    required TResult Function(Request request) request,
  }) {
    return uri(this.uri);
  }
}

abstract class UriType implements Resource {
  const factory UriType(final Uri uri) = _$UriType;

  Uri get uri;
}

/// @nodoc

class _$RequestType implements RequestType {
  const _$RequestType(this.request);

  @override
  final Request request;

  @override
  String toString() {
    return 'Resource.request(request: $request)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RequestType &&
            (identical(other.request, request) || other.request == request));
  }

  @override
  int get hashCode => Object.hash(runtimeType, request);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(String url) $default, {
    required TResult Function(Uri uri) uri,
    required TResult Function(Request request) request,
  }) {
    return request(this.request);
  }
}

abstract class RequestType implements Resource {
  const factory RequestType(final Request request) = _$RequestType;

  Request get request;
}
