// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Config _$$_ConfigFromJson(Map<String, dynamic> json) => _$_Config(
      supabase: json['supabase'] == null
          ? const SupabaseConfig()
          : SupabaseConfig.fromJson(json['supabase'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_ConfigToJson(_$_Config instance) => <String, dynamic>{
      'supabase': instance.supabase,
    };

_$_SupabaseConfig _$$_SupabaseConfigFromJson(Map<String, dynamic> json) =>
    _$_SupabaseConfig(
      projectPath: json['project_path'] as String? ?? '.',
      functions: (json['functions'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, e as String),
          ) ??
          const <String, String>{'dart_edge': 'lib/main.dart'},
    );

Map<String, dynamic> _$$_SupabaseConfigToJson(_$_SupabaseConfig instance) =>
    <String, dynamic>{
      'project_path': instance.projectPath,
      'functions': instance.functions,
    };
