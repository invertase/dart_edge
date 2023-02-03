import 'package:vercel_edge/vercel_edge_shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:shelf/shelf.dart';

void main() {
  VercelEdgeShelf(
    fetch: (request) async {
      final app = Router();

      app.get('/hello', (request) {
        return Response.ok("world!");
      });

      app.get('/hello/<phrase>', (request, String phrase) {
        return Response.ok(phrase);
      });

      app.all('/<ignored|.*>', (request) {
        return Response.notFound('Not found');
      });

      // Create a Pipeline handler, add middleware etc.
      final handler =
          const Pipeline().addMiddleware(logRequests()).addHandler(app);

      return handler(request);
    },
  );
}
