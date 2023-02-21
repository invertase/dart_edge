import 'package:edge/src/config/vercel_edge_config.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'edge_config.freezed.dart';
part 'edge_config.g.dart';

@freezed
class EdgeConfig with _$EdgeConfig {
  const factory EdgeConfig({
    required VercelEdgeConfig? vercel_edge,
  }) = _EdgeConfig;

  const EdgeConfig._();

  factory EdgeConfig.empty() => EdgeConfig.fromJson({});

  factory EdgeConfig.fromJson(Map<String, dynamic> json) =>
      _$EdgeConfigFromJson(json);
}
