import 'package:freezed_annotation/freezed_annotation.dart';

part 'vercel_edge_config.freezed.dart';
part 'vercel_edge_config.g.dart';

@freezed
class VercelEdgeConfig with _$VercelEdgeConfig {
  const factory VercelEdgeConfig({
    required Iterable<EntryPoint> entrypoints,
  }) = _VercelEdgeConfig;

  factory VercelEdgeConfig.fromJson(Map<String, dynamic> json) =>
      _$VercelEdgeConfigFromJson(Map<String, dynamic>.from(json));
}

@freezed
class EntryPoint with _$EntryPoint {
  const factory EntryPoint({
    required String? name,
    required String? schedule,
  }) = _EntryPoint;

  factory EntryPoint.fromJson(Map<String, dynamic> json) =>
      _$EntryPointFromJson(Map<String, dynamic>.from(json));
}
