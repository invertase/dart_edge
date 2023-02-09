# `edge_io` Package Proposal

Similar to HttpOverrides, Dart also has a IOOverrides that can be implemented.

This mainly allows to override implementation of things like file system access or socket/socket server creation in Dart and delegate to your own implementation.

In the case of `dart_edge` these could delegate to adapters to suite each platforms APIs.

For example the `edge_io` API could look something like this;

```dart
import 'dart:io';

// Abstract class EdgeIOFileSystemAdapter
import 'adapters/base/file_system_adapter.dart';
// Abstract class EdgeIOSocketAdapter
import 'adapters/base/socket_adapter.dart';
// Abstract class EdgeIOStdAdapter
import 'adapters/base/standard_adapter.dart';

void enableIOOverrides({
  // FS, e.g. bind to CF R2 or KV, or Deno FS interop.
  EdgeIOFileSystemAdapter? fsAdapter,

  // Socket/ServerSocket (e.g. Server Socket bind to WebSocket)
  EdgeIOSocketAdapter? socketAdapter,

  // Standard in/out/err adapter (e.g. bind to CF log stream or a Websocket Adapter)
  EdgeIOStdAdapter? stdAdapter,
}) {
  IOOverrides.global = EdgeIOOverrides(
    fsAdapter: fsAdapter, // ??= Or some default like builtin memory adapter.
    socketAdapter: socketAdapter, // ??= Or some default like a closed loop adapter.
    stdAdapter: stdAdapter // ??= Or some default like a closed loop adapter.
  );
}
```

This API could then be used by each platform specific edge package to implement and install their own adapters as part of initialization. For example CloudFlare could do;

```dart


import 'package:cloudflare_workers/cloudflare_workers.dart';

void main() {
  CloudflareWorkers(
    fsAdapter: CloudflareR2FsAdapter(/* options */),
    fetch: (request, env, ctx) {
      // ...
    },
  );
}

// Internally `CloudflareWorkers` would call `edge_io.enableIOOverrides`
// and set and enable any provided adapters.
```

## Builtin Adapters

`edge_io` should probably ship with some builtin adapters, some examples of useful adapters are;

- `MemoryFsAdapter` - an all in memory file system adapter.
- `ZipFsAdapter` - a readonly FS that mounts an Archive
- `ReadOnlyFsAdapter` - not a full implementation, provides an abstract class that only exposes file read methods, any methods that 'write' are pre-stubbed to throw an error. Other adapters such as `ZipFsAdapter` could implement this.
