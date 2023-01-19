import 'dart:js_util' as js_util;
import 'package:js/js.dart' as js;
export 'package:shelf_router/shelf_router.dart' show Router;

@js.JS()
class Promise<T> {
  external Promise(
      void Function(void Function(T result) resolve, Function reject) executor);
  external Promise then(void Function(T result) onFulfilled,
      [Function onRejected]);
}

Promise<T> futureToPromise<T>(Future<T> future) {
  return Promise<T>(js.allowInterop((resolve, reject) {
    future.then(resolve, onError: reject);
  }));
}

@js.JS()
class Headers {
  // TODO
}

@js.JS()
class Fetcher {
  // TODO
}

@js.JS()
class AbortSignal {
  // TODO
}

@js.JS()
class RequestInit {
  // TODO
}

@js.JS()
class Body {
  external bool get bodyUsed;
  external Object text(); // Promise<String>
  external Object json(); // Promise<T>
  external Object formData(); // Promise<FormData>
  external Object blob(); // Promise<Blob>
  external Object arrayBuffer(); // Promise<ArrayBuffer>
  // TODO
  // readonly body: ReadableStream | null;
}

@js.JS()
class IncomingRequestCfProperties {
  /// (e.g. 395747)
  external int asn;
  /// The organization which owns the ASN of the incoming request.
  /// (e.g. Google Cloud)
  external String asOrganization;
  external IncomingRequestCfPropertiesBotManagement? botManagement;
  external String? city;
  external String? clientAcceptEncoding;
  external num clientTcpRtt;
  external num clientTrustScore;
  /// The three-letter airport code of the data center that the request
  /// hit. (e.g. "DFW")
  external String colo;
  external String? continent;
  /// The two-letter country code in the request. This is the same value
  /// as that provided in the CF-IPCountry header. (e.g. "US")
  external String country;
  external String httpProtocol;
  external String? latitude;
  external String? longitude;
  /// DMA metro code from which the request was issued, e.g. "635"
  external String? metroCode;
  external String? postalCode;
  /// e.g. "Texas"
  external String? region;
  /// e.g. "TX"
  external String? regionCode;
  /// e.g. "weight=256;exclusive=1"
  external String requestPriority;
  /// e.g. "America/Chicago"
  external String? timezone;
  external String tlsVersion;
  external String tlsCipher;
  external IncomingRequestCfPropertiesTLSClientAuth tlsClientAuth;
}

@js.JS()
class IncomingRequestCfPropertiesBotManagement {
  external int score;
  external bool staticResource;
  external bool verifiedBot;
}

@js.JS()
class IncomingRequestCfPropertiesTLSClientAuth {
  external String certIssuerDNLegacy;
  external String certIssuerDN;
  external String certPresented;
  external String certSubjectDNLegacy;
  external String certSubjectDN;
  /// In format "Dec 22 19:39:00 2018 GMT"
  external String certNotBefore;
  /// In format "Dec 22 19:39:00 2018 GMT"
  external String certNotAfter;
  external String certSerial;
  external String certFingerprintSHA1;
  /// "SUCCESS", "FAILED:reason", "NONE"
  external String certVerified;
}

@js.JS()
class Request extends Body {
  // constructor(input: Request | string, init?: RequestInit | Request);
  external factory Request(Object input, RequestInit? init);
  external String get method;
  external String get url;
  external String get string;
  external Request clone();
  external Headers get headers;
  external Fetcher? get fetcher;
  external AbortSignal get signal;
  external IncomingRequestCfProperties? get cf;
}

@js.JS()
class Response {
  // declare type BodyInit =
  // | ReadableStream
  // | string
  // | ArrayBuffer
  // | Blob
  // | URLSearchParams
  // | FormData;
  // constructor(bodyInit?: BodyInit | null, maybeInit?: ResponseInit | Response);
  external factory Response(Object body);
  external Request clone();
  external Headers get headers;
  external int get status;
  external String get statusText;
  external bool get ok;
  external bool get redirected;
  external String get url;
  // TODO
  // readonly webSocket: WebSocket | null;
  // readonly cf?: Object;
}

@js.JS()
class FetchEvent {
  external Request get request;
  // respondWith(promise: Response | Promise<Response>): void;
  external void respondWith(Object r);
}

@js.JS()
external void addEventListener(String type, void Function(FetchEvent event));
