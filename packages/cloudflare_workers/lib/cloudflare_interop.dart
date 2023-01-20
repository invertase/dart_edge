import 'package:js/js.dart' as js;

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
