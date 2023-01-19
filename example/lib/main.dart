import 'cloudflare_workers_shelf.dart';

void main() {
  final app = Router();

  app.get('/hello', (Request request) {
    return Response.ok('hello-world');
  });

  app.get('/user/<user>', (Request request, String user) {
    final cfProperties = request.context['cf'] as IncomingRequestCfProperties?;
    print(cfProperties?.city);
    return Response.ok('hello!!!!!!! $user from ${cfProperties?.city}');
  });

  serve(app);
}
