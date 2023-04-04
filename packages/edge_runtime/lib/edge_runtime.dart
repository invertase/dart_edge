import 'dart:js';

export 'dart:async' show FutureOr;

export 'src/top.dart';

export 'src/abort.dart' show AbortController, AbortSignal;
export 'src/blob.dart' show Blob, BlobPropertyBag;
export 'src/cache/cache_query_options.dart'
    show CacheQueryOptions, MultiCacheQueryOptions;
export 'src/cache/cache_storage.dart' show CacheStorage, caches;
export 'src/cache/cache.dart' show Cache;
export 'src/fetch_event.dart' show FetchEvent;
export 'src/file.dart' show File;
export 'src/form_data.dart' show FormData, FormDataEntryValue;
export 'src/headers.dart' show Headers;
export 'src/request.dart' show Request;
export 'src/resource.dart' show Resource;
export 'src/response.dart' show Response;
export 'src/text_decoder.dart'
    show TextDecoder, TextDecodeOptions, TextDecoderOptions;
export 'src/text_encoder.dart' show TextEncoder, TextEncoderEncodeIntoResult;

export 'src/io_http_client.dart';
export 'src/http_client.dart';
export 'src/interop/readable_stream.dart' show streamFromJSReader;

export 'package:js_bindings/bindings/referrer_policy.dart' show ReferrerPolicy;
export 'package:js_bindings/bindings/fetch.dart'
    show
        ResponseType,
        RequestDuplex,
        RequestCache,
        RequestCredentials,
        RequestDestination,
        RequestMode,
        RequestRedirect;

/// This should be called before any other platform code is run.
void setupRuntime() {
  // Dart to JS looks for some context properties to determine whether some
  // features are available. Uri.base checks whether window.location.href is
  // available, so we patch it in here.
  if (context['self']['location'] == null) {
    context['self']['location'] = JsObject.jsify({
      'href': '',
    });
  }

  // Dart to JS assumes we're in a browser context, so we need to patch in.
  context['window'] ??= context['self'];
  // HttpOverrides.global = FetchHttpOverride();
}
