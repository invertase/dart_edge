import 'dart:js_util' as js_util;
import 'package:js/js.dart';

@anonymous
@JS()
@staticInterop
class NetlifyContext {
  external factory NetlifyContext();
}

extension PropsNetlifyContext on NetlifyContext {
  Account get account => js_util.getProperty(this, 'account');
  Geo get geo => js_util.getProperty(this, 'geo');
}

@anonymous
@JS()
@staticInterop
class Account {
  external factory Account();
}

extension PropsAccount on Account {
  String get id => js_util.getProperty(this, 'id');
}

@anonymous
@JS()
@staticInterop
class Geo {
  external factory Geo();
}

extension PropsGeo on Geo {
  String get city => js_util.getProperty(this, 'city');
}
