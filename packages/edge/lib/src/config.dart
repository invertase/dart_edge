// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:yaml/yaml.dart';

part 'config.freezed.dart';
part 'config.g.dart';

@freezed
class Config with _$Config {
  const factory Config({
    @Default(SupabaseConfig()) SupabaseConfig supabase,
  }) = _Config;

  factory Config.fromJson(Map<String, dynamic> json) => _$ConfigFromJson(json);

  factory Config.loadFromYaml(String yaml) {
    return Config.fromJson(
      loadYamlNode(yaml).toProperJson() as Map<String, dynamic>,
    );
  }
}

@freezed
class SupabaseConfig with _$SupabaseConfig {
  const factory SupabaseConfig({
    @Default('.') @JsonKey(name: 'project_path') String projectPath,
    @Default(<String, String>{'dart_edge': 'lib/main.dart'})
        Map<String, String> functions,
  }) = _SupabaseConfig;

  factory SupabaseConfig.fromJson(Map<String, dynamic> json) =>
      _$SupabaseConfigFromJson(json);
}

extension on YamlNode {
  dynamic toProperJson() {
    if (this is YamlMap) {
      return <String, dynamic>{
        for (final node in (this as YamlMap).nodes.entries)
          (node.key as YamlNode).value as String: node.value.toProperJson(),
      };
    }
    if (this is YamlList) {
      return <dynamic>[
        for (final node in (this as YamlList).nodes) node.toProperJson(),
      ];
    }
    return value;
  }
}
