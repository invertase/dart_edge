import 'package:edge/runtime/request_init.dart';

import '../interop/request_init_interop.dart' as interop;

extension CloudflareWorkersRequestInitExtension on RequestInit {
  set cf(RequestInitCfProperties properties) {
    delegate.cf = properties.delegate;
  }
}

class RequestInitCfProperties {
  bool? cacheEverything;
  bool? cacheKey;
  Iterable<String>? cacheTags;
  int? cacheTtl;
  Map<String, int>? cacheTtlByStatus;
  bool? scrapeShield;
  bool? apps;
  RequestInitCfPropertiesImageDraw? image;
  RequestInitCfPropertiesImageMinify? minify;
  bool? mirage;
  RequestInitCfPolish? polish;
  String? resolveOverride;

  RequestInitCfProperties({
    this.cacheEverything,
    this.cacheKey,
    this.cacheTags,
    this.cacheTtl,
    this.cacheTtlByStatus,
    this.scrapeShield,
    this.apps,
    this.image,
    this.minify,
    this.mirage,
    this.polish,
    this.resolveOverride,
  });
}

extension RequestInitCfPropertiesExtension on RequestInitCfProperties {
  interop.RequestInitCfProperties get delegate {
    return interop.RequestInitCfProperties()
      ..cacheEverything = cacheEverything
      ..cacheKey = cacheKey
      ..cacheTags = cacheTags
      ..cacheTtl = cacheTtl
      ..cacheTtlByStatus = cacheTtlByStatus
      ..scrapeShield = scrapeShield
      ..apps = apps
      ..image = image?.delegate
      ..minify = minify?.delegate
      ..mirage = mirage
      ..polish = polish?.name
      ..resolveOverride = resolveOverride;
  }
}

class RequestInitCfPropertiesImageMinify {
  bool? javascript;
  bool? css;
  bool? html;

  RequestInitCfPropertiesImageMinify({
    this.javascript,
    this.css,
    this.html,
  });
}

extension RequestInitCfPropertiesImageMinifyExtension
    on RequestInitCfPropertiesImageMinify {
  interop.RequestInitCfPropertiesImageMinify get delegate {
    return interop.RequestInitCfPropertiesImageMinify()
      ..javascript = javascript
      ..css = css
      ..html = html;
  }
}

class BasicImageTransformations {
  num? width;
  num? height;
  BasicImageTransformationsFit? fit;
  BasicImageTransformationsGravity? gravity;
  String? background;
  int? rotate;

  BasicImageTransformations({
    this.width,
    this.height,
    this.fit,
    this.gravity,
    this.background,
    this.rotate,
  });
}

class RequestInitCfPropertiesImageDraw extends BasicImageTransformations {
  String url;
  num? opacity;
  RequestInitCfPropertiesImageDrawRepeat? repeat;
  num? top;
  num? left;
  num? bottom;
  num? right;

  RequestInitCfPropertiesImageDraw({
    required this.url,
    this.opacity,
    this.repeat,
    this.top,
    this.left,
    this.bottom,
    this.right,
    super.width,
    super.height,
    super.fit,
    super.gravity,
    super.background,
    super.rotate,
  });
}

extension RequestInitCfPropertiesImageDrawExtension
    on RequestInitCfPropertiesImageDraw {
  interop.RequestInitCfPropertiesImageDraw get delegate {
    return interop.RequestInitCfPropertiesImageDraw(url: url)
      ..opacity = opacity
      ..repeat = repeat == RequestInitCfPropertiesImageDrawRepeat.valueTrue
          ? true
          : repeat?.name
      ..top = top
      ..left = left
      ..bottom = bottom
      ..right = right
      ..width = width
      ..height = height
      ..fit = fit?.value
      ..gravity = gravity?.name
      ..background = background
      ..rotate = rotate;
  }
}

enum BasicImageTransformationsFit {
  scaleDown('scale-down'),
  contain('contain'),
  cover('cover'),
  crop('crop'),
  pad('pad');

  final String value;
  const BasicImageTransformationsFit(this.value);
}

enum BasicImageTransformationsGravity {
  left,
  right,
  top,
  bottom,
  center,
  auto,
  // cordinates?
}

enum RequestInitCfPropertiesImageDrawRepeat {
  valueTrue,
  x,
  y,
}

enum RequestInitCfPolish {
  lossy,
  lossless,
  off,
}
