import 'dart:io';

void main(List<String> arguments) async {
  // TODO handle args (e.g. minification level etc)

  // 1. Spawn process to compile dart to js
  // 2. Create a file in `.vercel/output/config.json` with:
  // {
  //   "version": 3,
  //   "routes": [{ "src": "/.*", "dest": "dart" }]
  // }
  // 3. Create a file in `.vercel/output/functions/dart.func` with:
  //    a. .vs-config.json:
  //    {
  //      "runtime": "edge",
  //      "entrypoint": "entry.js"
  //    }
  // 4. Put the compiled JS file in: `.vercel/output/functions/dart.func/main.dart.js`
  // 5: Create a file with the below contents...
}

// import './main.dart';

// export default (request) => {
//   if (self.__dartFetchHandler !== undefined) {
//     return self.__dartFetchHandler(request);
//   }
// };
