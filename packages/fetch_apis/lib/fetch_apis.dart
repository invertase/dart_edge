library fetch_apis;

import 'dart:js' as js;
import 'dart:js_util' show promiseToFuture, jsify;

import 'package:js_bindings/js_bindings.dart' as interop;
import 'interop/fetch_interop.dart' as interop;
import 'interop/utils_interop.dart' as interop;

import 'public/fetch_event.dart';
import 'public/request_init.dart';
import 'public/response.dart';
import 'public/resource.dart';

export 'public/abort_signal.dart' show AbortSignal;
export 'public/blob.dart' show Blob;
export 'public/body.dart' show Body;
export 'public/cache_storage.dart' show CacheStorage, caches;
export 'public/cache.dart' show Cache;
export 'public/fetch_event.dart' show FetchEvent;
export 'public/form_data.dart' show FormData; // TODO FormDataEntryValue
export 'public/headers.dart' show Headers;
export 'public/readable_stream.dart' show ReadableStream;
export 'public/request_init.dart' show RequestInit;
export 'public/request.dart' show Request;
export 'public/resource.dart' show Resource;
export 'public/response_init.dart' show ResponseInit;
export 'public/response.dart' show Response;

export 'package:js_bindings/bindings/referrer_policy.dart' show ReferrerPolicy;
export 'package:js_bindings/bindings/fetch.dart'
    show
        ResponseType,
        RequestDuplex,
        RequestCache,
        RequestCredentials,
        RequestDestination,
        RequestMode,
        RequestPriority;

void addFetchEventListener(Null Function(FetchEvent event) listener) {
  // The js_bindings package assumes that the global object is `window`,
  // but in a worker enbironment, it is `self`.
  if (js.context['window'] == null) js.context['window'] = js.context['self'];
  
  interop.addEventListener(
    'fetch',
    js.allowInterop((interop.ExtendableEvent delegate) {
      // This needs casting, because the type of the event is not known at compile time.
      listener(fetchEventFromJsObject(delegate as interop.FetchEvent));
    }),
  );
}

Future<Response> fetch(Resource resource, [RequestInit? init]) async {
  return responseFromJsObject(
    await promiseToFuture(
      interop.fetch(
        interop.requestFromResource(resource),
        jsify(init?.toJson() ?? {}),
      ),
    ),
  );
}
