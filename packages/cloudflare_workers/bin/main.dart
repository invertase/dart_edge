import 'dart:io';

void main(List<String> arguments) async {
  // TODO handle args (e.g. minification level etc)

  // 1. Spawn process to compile dart to js
  // 2. Create a new file with the js code (see below)
}

// import "./main.dart.js";

// export default {
//   async fetch(request, env, ctx) {
//     if (self.__dartFetchHandler !== undefined) {
//       return self.__dartFetchHandler(request, env, ctx);
//     }
//   },
// };
