## 0.0.7

 - **FEAT**: add `edge.yaml` support + supabase config. ([8134137d](https://github.com/invertase/dart_edge/commit/8134137d28e66871ae03514e1e7c5284b26e600d))

## 0.0.6+1

 - **FIX**(supabase_functions): compile code when no dev flag is provided. ([c9c0fe3b](https://github.com/invertase/dart_edge/commit/c9c0fe3b3cd3496ce3fa3b7dab7f7d4a787d963e))

## 0.0.6

 - **FIX**: register supabase new command. ([66fdd085](https://github.com/invertase/dart_edge/commit/66fdd0857d2d491460fed8f906b0cb3263c93a21))
 - **FEAT**: add supabase_functions new command. ([1a0583ef](https://github.com/invertase/dart_edge/commit/1a0583efe9e45bdcf921895696694ff27c213b04))

## 0.0.5

 - **FEAT**: add working supabase example. ([c9544bb0](https://github.com/invertase/dart_edge/commit/c9544bb0a408a25cc977017ecae74ed06a92f3d4))

## 0.0.4+1

 - **REFACTOR**: prefer named arguments on DO/KV apis. ([c6e07055](https://github.com/invertase/dart_edge/commit/c6e0705553b1607637fcdd21ee7b316a29dbd2ca))
 - **REFACTOR**: update cli implementation ([#18](https://github.com/invertase/dart_edge/issues/18)). ([86802207](https://github.com/invertase/dart_edge/commit/868022075012814679e68a3a3e48003068db6bb6))
 - **REFACTOR**: extract cloudflare_workers logic to standalone class. ([4ab0c13c](https://github.com/invertase/dart_edge/commit/4ab0c13cd62d83bf52067a57ae4f06444aec1c42))

## 0.0.4

 - **FEAT**: add use-filesystem flag for prod vercel builds. ([ea9a6d12](https://github.com/invertase/dart_edge/commit/ea9a6d1216ded86439585b34a919bb3ccec6c025))

## 0.0.3

 - **REFACTOR**: move edge runtime to separate package. ([95d4fab7](https://github.com/invertase/dart_edge/commit/95d4fab74cc7c3902bd737659dfee06d7feab353))
 - **FIX**: Uint8List as valid body type. ([a4be0591](https://github.com/invertase/dart_edge/commit/a4be0591679af3d4ce22c9aa05e663b1732ca4d7))
 - **FEAT**: add `dev` command & example. ([8936f513](https://github.com/invertase/dart_edge/commit/8936f5131c0d6621264138e89370cd6ee6fdc828))

## 0.0.2

 - **REFACTOR**: restructure runtime location. ([3b4407e4](https://github.com/invertase/dart_edge/commit/3b4407e400b73a6583fb96d724871d068f4e944e))
 - **FEAT**: improve CLI flow for build commands. ([179c1c65](https://github.com/invertase/dart_edge/commit/179c1c6595d6348f0204c043f5c41fce410c5e39))
 - **FEAT**: rework edge new flow. ([0e337d73](https://github.com/invertase/dart_edge/commit/0e337d73cfd14c8e017ff6941eb0325ae29aca79))
 - **FEAT**: rework how DOs are handled. ([0b06f1ee](https://github.com/invertase/dart_edge/commit/0b06f1ee7cac1cf9a0c67355444f16b5e9633417))
 - **FEAT**: migrate init to named args. ([eaddc0ed](https://github.com/invertase/dart_edge/commit/eaddc0edfad67aef9abefb3dce9c1c69f0b19bdf))

# 0.0.1-dev.2
- Add `edge` executable to pubspec.
# 0.0.1-dev.1
- Migrate runtime to `edge` package.
- Add `edge` executable.
# 0.0.1
- Stubbed out the package