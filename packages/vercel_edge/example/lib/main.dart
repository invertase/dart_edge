import 'package:vercel_edge/vercel_edge.dart';

void main() {
  VercelEdge(fetch: (request) {
    return Response("Hello World!");
  });
}
