import 'package:freezed_annotation/freezed_annotation.dart';

import 'request.dart';

part 'resource.freezed.dart';

@Freezed(
  copyWith: false,
  fromJson: false,
  toJson: false,
  when: FreezedWhenOptions(maybeWhen: false, whenOrNull: false),
  map: FreezedMapOptions.none,
)
class Resource with _$Resource {
  const factory Resource(String url) = StringValue;
  const factory Resource.uri(Uri uri) = UriValue;
  const factory Resource.request(Request request) = RequestValue;
}
