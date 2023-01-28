import 'package:netlify_edge/netlify_edge.dart';

void main() {
  NetlifyEdge(fetch: (request, context) {
    return Response("Hello, you're visiting from");
  });
}
