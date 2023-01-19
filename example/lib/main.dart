import 'cloudflare_workers_shelf.dart';
import 'package:archive/archive.dart';
// import 'package:foo/cloudflare_adapater.dart';

void main() {
  final app = Router();

  app.get('/hello', (Request request) {
    final a = Archive();
    a.addFile(ArchiveFile('foo', 0, [1, 2, 3]));
    return Response.ok('hello-world');
  });

  app.get('/user/<user>', (Request request, String user) {
    final cfProperties = request.context['cf'] as IncomingRequestCfProperties?;
    print(cfProperties?.city);
    return Response.ok('hello!!!!!!! $user from ${cfProperties?.city}');
  });

  serve(app);
}


// void foo() {
//   return Target<Cloudflare>(
//     routes: [
//       Route(
//         path: '/hello',
//         handler: (request) => Response.ok('hello-world'),
//       ),
//       Route(
//         path: '/user/<user>',
//         handler: (request, String user) {
//           final cfProperties = request.context['cf'] as IncomingRequestCfProperties?;
//           print(cfProperties?.city);
//           return Response.ok('hello!!!!!!! $user from ${cfProperties?.city}');
//         },
//       ),
//     ],
//   )
// }
