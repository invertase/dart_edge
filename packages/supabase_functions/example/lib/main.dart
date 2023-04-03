import 'dart:async';

import 'package:supabase_functions/supabase_functions.dart';

void main() {
  SupabaseFunctions(fetch: (request) async {
    print(Deno.cwd());

    final s = Deno.readDir(Deno.cwd());
    final c = Completer();
    s.listen((event) {
      print(event.name);
    });

    await c.future;

    return Response('Hello Supabase from Dart :D');
  });
}
