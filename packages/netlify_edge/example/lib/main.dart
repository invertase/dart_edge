import 'package:netlify_edge/netlify_edge.dart';

void main() {
  NetlifyEdge(fetch: (request) {
    return Response("Hello, you're visiting from Netlify");
  });
}
