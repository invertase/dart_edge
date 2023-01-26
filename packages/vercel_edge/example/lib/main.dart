import 'package:vercel_edge/vercel_edge.dart';

void main() {
  VercelEdge(fetch: (request) {
    return Response("Hello, you're visiting from ${request.vc.city}");
  });
}
