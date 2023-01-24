import 'dart:typed_data';

import 'package:v8_runtime/v8_runtime.dart';
import 'package:workers_dart_example/element_handler.dart';

const shouldUseCache = true;
const apiBaseUrl = 'https://api.zapp.run';
const projectsBaseUrl = 'https://projects.zapp.run';
const sdkBaseUrl = 'https://sdk.zapp.run';

// Future<ByteBuffer> fetchProjectArchive(
//     FetchEvent event, Resource resource) async {
//   final cache = await caches.open('archives-cache');
//   final fromCache = await cache.match(resource);
//   if (fromCache != null) {
//     return fromCache.arrayBuffer();
//   }
//   final archiveBuffer =
//       await fetch(resource).then((response) => response.arrayBuffer());

//   event.waitUntil(
//     cache.put(
//       resource,
//       Response(
//         archiveBuffer,
//         ResponseInit(
//           headers: Headers({
//             "content-encoding": "gzip",
//             "content-type": "application/zip",
//             "content-disposition": 'attachment; filename=project.zip',
//             "cache-control": "public, max-age=604800",
//             // TODO 7 days right? new Date(Date.now() + 1000 * 60 * 60 * 24 * 7).toUTCString(),
//             "expires": DateTime.now().add(Duration(days: 7)).toUtc().toString(),
//           }),
//         ),
//       ),
//     ),
//   );

//   return archiveBuffer;
// }

class Foo extends ElementHandler {
  @override
  FutureOr<void> element(Element element) async {
    print('replacing element');
    await Future.delayed(Duration(seconds: 2));
    element.replace('<h1>World</h1>', ContentOptions(html: true));
    print('replaced element');
  }
}

void main() {
  addFetchEventListener((FetchEvent event) {
    event.respondWith(Future(() async {
      if (event.request.url.toString().contains('favicon.ico')) {
        return Response('', ResponseInit(status: 404));
      }

      return HTMLRewriter().on('h1', Foo()).transform(
            Response(
                '''<!DOCTYPE html>
<head></head>
<body>
  <h1>hello</h1>
</html>
''',
                ResponseInit(
                  headers: Headers({'content-type': 'text/html'}),
                )),
          );

      // final url = event.request.url;
      // final params = url.queryParameters;
      // final cache = await caches.open('preview-zip-cache');
      // final path = event.request.url.path;
      // final theme = params['theme'] == 'dark' ? 'dark' : 'light';

      // String id = url.host.split('.').first;
      // id = id.split('-').last;

      // if (url.path == '/_qr.png') {
      //   throw UnimplementedError('TODO QR Code');
      // }

      // final project = await fetch(Resource('$apiBaseUrl/project/$id'));

      // if (!project.ok) {
      //   return Response(
      //     'TODO HTML',
      //     ResponseInit(
      //       status: 404,
      //       headers: Headers({
      //         'content-encoding': 'gzip',
      //         'content-type': 'text/html;charset=UTF-8',
      //       }),
      //     ),
      //   );
      // }

      // // TODO: type it?
      // final payload = (await project.json() as dynamic)!['payload'];
      // final sdk = payload['project']['meta']?['sdk'] ?? 'flutter';
      // final archiveUrl = '$projectsBaseUrl/${payload['project']['archive']}';

      // String archiveUrlCache = '$archiveUrl?file=$path';
      // if (path == '/') {
      //   // For the index.html cache by title and description so that these show latest values when the project is updated.
      //   archiveUrlCache =
      //       '$archiveUrlCache&title=${payload['project']['title']}&description=${payload['project']['description']}';
      // }

      // final cachedHtmlResponse = await cache.match(Resource(archiveUrlCache));
      // if (cachedHtmlResponse != null) {
      //   return cachedHtmlResponse;
      // }

      // final archiveBuffer =
      //     await fetchProjectArchive(event, Resource(archiveUrl));
      // final zip = {};

      // // ...

      // final handler = PreviewElementHandler(
      //   flutterVersion: '', // TODO
      //   flutterVersionRevision: '', // TODO
      //   projectBuildId: '', // TODO
      //   theme: theme,
      //   sdk: sdk,
      // );

      // var response = HTMLRewriter()
      //     .on('head', handler)
      //     .on('script', handler)
      //     .on('body', handler)
      //     .transform(
      //       Response(
      //         'TODO new HTML',
      //         ResponseInit(
      //           headers: Headers({
      //             'content-encoding': 'gzip',
      //             'content-type': 'text/html;charset=UTF-8',
      //             // We only want brief cache to prevent spam refreshing the page,
      //             // but low enough to allow updates to project name and description as well as user changes to the
      //             // project index.html.
      //             "cache-control": "public, max-age=5",
      //           }),
      //         ),
      //       ),
      //     );

      // throw UnimplementedError();
//       if (event.request.url.toString().contains('favicon.ico')) {
//         return Response(
//           'Not found',
//           ResponseInit(status: 404),
//         );
//       }

//       return HTMLRewriter().on('h1', ElemetHandler(
//         element: (element) {
//           print('GOT H1 ELEMENT!');
//           print(element.tagName);
//           element.replace(
//               '<h1>Heh, not bad. <b>:D</b></h1>', ContentOptions(html: true));
//         },
//       )).onDocument(DocumentHandler(
//         comments: (comment) {
//           print('GOT COMMENT!');
//           print(comment.text);
//           comment.text = 'This is a modified comment';
//         },
//       )).transform(
//         Response(
//           '''<!DOCTYPE html>
// <html>
//   <head>
//     <title>My First Cloudflare Workers Site</title>
//   </head>
//   <body>
//     <h1>Hello, World!</h1>
//     <!-- This is a comment -->
//     <p>I'm hosted with Cloudflare Workers</p>
//   </body>
// </html>
// ''',
//           ResponseInit(
//             headers: Headers({'content-type': 'text/html'}),
//           ),
//         ),
//       );

      // if (event.request.url.toString().contains('favicon.ico')) {
      //   return Response(
      //     'Not found',
      //     ResponseInit(status: 404),
      //   );
      // }

      // final url = Uri.https(
      //   'dummyjson.com',
      //   '/quotes/random',
      // );

      // try {
      //   final cachedResponse =
      //       await caches.defaultCache.match(Resource.uri(url));
      //   if (shouldUseCache && cachedResponse != null) {
      //     print('Using cached response');
      //     return cachedResponse;
      //   }

      //   final fetchResponse = await fetch(Resource.uri(url));
      //   final buffer = await fetchResponse.arrayBuffer();
      //   final headers = Headers({
      //     'content-type': 'application/json',
      //     'x-foo': 'bar',
      //   });
      //   final response = Response(
      //     buffer,
      //     ResponseInit(headers: headers),
      //   );

      //   // Make sure we can decode the response ourselves.
      //   print(Utf8Decoder().convert(buffer.asUint8List()));

      //   if (shouldUseCache) {
      //     await caches.defaultCache.put(Resource.uri(url), response.clone());
      //   }
      //   return response;
      // } catch (e, s) {
      //   print(s);
      //   print(e);
      //   return Response('ERROR $e $s');
      // }
    }));
  });
}
