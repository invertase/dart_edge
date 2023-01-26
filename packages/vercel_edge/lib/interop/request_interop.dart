import 'package:js_bindings/js_bindings.dart' as interop;

extension CloudflareWorkersRequestInteropExtension on interop.Request {
  String? get ipAddress => headers.mGet('x-real-ip');
  String? get city => headers.mGet('x-vercel-ip-city');
  String? get country => headers.mGet('x-vercel-ip-country');
  String? get region {
    final requestId = headers.mGet('x-vercel-id');
    if (requestId == null) {
      return 'dev1';
    }
    return requestId.split(':')[0];
  }

  String? get countryRegion => headers.mGet('x-vercel-ip-country-region');
  String? get latitude => headers.mGet('x-vercel-ip-latitude');
  String? get longitude => headers.mGet('x-vercel-ip-longitude');
}
