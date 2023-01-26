import 'package:vercel_edge/vercel_edge.dart';

void main() {
  VercelEdge(fetch: (event) {
    return Response('Hello World');
  });
}
