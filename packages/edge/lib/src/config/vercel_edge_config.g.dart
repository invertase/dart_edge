// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vercel_edge_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_VercelEdgeConfig _$$_VercelEdgeConfigFromJson(Map<String, dynamic> json) =>
    _$_VercelEdgeConfig(
      entrypoints: (json['entrypoints'] as List<dynamic>)
          .map((e) => EntryPoint.fromJson(e as Map<String, dynamic>)),
    );

Map<String, dynamic> _$$_VercelEdgeConfigToJson(_$_VercelEdgeConfig instance) =>
    <String, dynamic>{
      'entrypoints': instance.entrypoints.toList(),
    };

_$_EntryPoint _$$_EntryPointFromJson(Map<String, dynamic> json) =>
    _$_EntryPoint(
      name: json['name'] as String?,
      schedule: json['schedule'] as String?,
    );

Map<String, dynamic> _$$_EntryPointToJson(_$_EntryPoint instance) =>
    <String, dynamic>{
      'name': instance.name,
      'schedule': instance.schedule,
    };
