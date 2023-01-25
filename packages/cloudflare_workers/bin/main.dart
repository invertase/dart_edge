import 'dart:io';

void main(List<String> arguments) async {
  // TODO handle args (e.g. minification level etc)

  // 1. Spawn process to compile dart to js
  // 2. Parse the wranger.toml file, and get out the durable object class nammes
  // 3. Create a new file with the js code (see below)
}

// import "./main.dart.js";

// export default {
//   async fetch(request, env, ctx) {
//     if (self.__dartFetchHandler !== undefined) {
//       return self.__dartFetchHandler(request, env, ctx);
//     }
//   },
// };

// export class ElliotDurableObject {
//   constructor(state, env) {
//     const instance = self.__durableObjects["ElliotDurableObject"];
//     instance.state = state;
//     instance.env = env;

//     if (!instance) {
//       throw new Error(
//         `No Dart Durable object instance named 'ElliotDurableObject' found.`
//       );
//     }

//     this.delegate = instance;
//   }

//   async fetch(request, env) {
//     return this.delegate.fetch(request);
//   }
// }
