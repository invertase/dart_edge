import 'package:edge_runtime/edge_runtime.dart';
import 'package:supabase/supabase.dart';
import 'package:test/test.dart';

void main() {
  late SupabaseClient client;

  setUp(() {
    client = SupabaseClient(
      'https://uoesswkdizmnjvtsnmxa.supabase.co',
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InVvZXNzd2tkaXptbmp2dHNubXhhIiwicm9sZSI6ImFub24iLCJpYXQiOjE2NzkzMjAwMTksImV4cCI6MTk5NDg5NjAxOX0.nLQsEj9ZYzemOj6Z6E9-nt8h6VBwLYKRv-wMkOmC6Tk',
      httpClient: Client(),
    );
  });

  group('Supabase Client', () {
    group('works with edge_runtime http client', () {
      test('can make an auth request', () async {
        final res = await client.auth.getOAuthSignInUrl(
          provider: Provider.google,
        );

        expect(res.provider, Provider.google);

        expect(
          res.url,
          contains('supabase.co/auth/v1/authorize?provider=google'),
        );
      });

      test('can sign up the user', () async {
        final res = await client.auth.signUp(
          password: 'dartedgeuser',
          email: 'andrei@invertase.io',
        );

        expect(res.user, isNotNull);
        expect(res.user!.email, 'andrei@invertase.io');
      });
    });
  });
}
