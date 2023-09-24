import 'package:typings/core.dart' as interop;

import '../interop/request_interop.dart';

extension VercelEdgeRequestExtension on interop.Request {
  IncomingRequestVercelProperties get vc => IncomingRequestVercelProperties._(this);
}

class IncomingRequestVercelProperties {
  final interop.Request _delegate;

  IncomingRequestVercelProperties._(this._delegate);

  String? get ipAddress => _delegate.ipAddress;
  String? get city => _delegate.city;
  String? get country => _delegate.country;
  String? get region => _delegate.region;
  String? get countryRegion => _delegate.countryRegion;
  String? get latitude => _delegate.latitude;
  String? get longitude => _delegate.longitude;
}
