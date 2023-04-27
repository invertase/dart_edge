import 'dart:convert';

import 'package:edge_http_client/edge_http_client.dart';
import 'package:supabase/supabase.dart';
import 'package:supabase_functions/supabase_functions.dart';
import 'package:yet_another_json_isolate/yet_another_json_isolate.dart';

void main() {
  final client = SupabaseClient(
    'https://oqikpqftjankbsrejdhv.supabase.co',
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im9xaWtwcWZ0amFua2JzcmVqZGh2Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2NzU5NDY5MTAsImV4cCI6MTk5MTUyMjkxMH0.jK4_Kqi4ZYxg7KbOJKsyHXrwkX_u3Ugp_XQyQW9m_lw',
    httpClient: EdgeHttpClient(),
    isolate: CurrentIsolate(),
  );

  SupabaseFunctions(fetch: (request) async {
    List messages = await client.from('example').select();
    return Response.json(messages);
  });
}

// This will eventually live inside of edge_io
class CurrentIsolate implements YAJsonIsolate {
  @override
  Future decode(String json) {
    return Future.value(jsonDecode(json));
  }

  @override
  Future<void> dispose() async {}

  @override
  Future<String> encode(Object? json) {
    return Future.value(jsonEncode(json));
  }

  @override
  Future<void> initialize() async {}
}
