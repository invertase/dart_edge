// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edge_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_EdgeConfig _$$_EdgeConfigFromJson(Map<String, dynamic> json) =>
    _$_EdgeConfig(
      vercel_edge: json['vercel_edge'] == null
          ? null
          : VercelEdgeConfig.fromJson(
              json['vercel_edge'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_EdgeConfigToJson(_$_EdgeConfig instance) =>
    <String, dynamic>{
      'vercel_edge': instance.vercel_edge,
    };
