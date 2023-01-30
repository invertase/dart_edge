import '../../interop/durable_object_interop.dart' as interop;

class DurableObjectGetOptions {
  bool? allowConcurrency;
  bool? noCache;

  DurableObjectGetOptions({
    this.allowConcurrency,
    this.noCache,
  });
}

extension DurableObjectGetOptionsExtension on DurableObjectGetOptions {
  interop.DurableObjectGetOptions get delegate =>
      interop.DurableObjectGetOptions(
        allowConcurrency: allowConcurrency,
        noCache: noCache,
      );
}

class DurableObjectGetAlarmOptions {
  bool? allowConcurrency;

  DurableObjectGetAlarmOptions({
    this.allowConcurrency,
  });
}

extension DurableObjectGetAlarmOptionsExtension
    on DurableObjectGetAlarmOptions {
  interop.DurableObjectGetAlarmOptions get delegate =>
      interop.DurableObjectGetAlarmOptions(
        allowConcurrency: allowConcurrency,
      );
}

class DurableObjectSetAlarmOptions {
  bool? allowConcurrency;
  bool? allowUnconfirmed;

  DurableObjectSetAlarmOptions({
    this.allowConcurrency,
    this.allowUnconfirmed,
  });
}

extension DurableObjectSetAlarmOptionsExtension
    on DurableObjectSetAlarmOptions {
  interop.DurableObjectSetAlarmOptions get delegate =>
      interop.DurableObjectSetAlarmOptions(
        allowConcurrency: allowConcurrency,
        allowUnconfirmed: allowUnconfirmed,
      );
}

class DurableObjectPutOptions {
  bool? allowConcurrency;
  bool? allowUnconfirmed;
  bool? noCache;

  DurableObjectPutOptions({
    this.allowConcurrency,
    this.allowUnconfirmed,
    this.noCache,
  });
}

extension DurableObjectPutOptionsExtension on DurableObjectPutOptions {
  interop.DurableObjectPutOptions get delegate =>
      interop.DurableObjectPutOptions(
        allowConcurrency: allowConcurrency,
        allowUnconfirmed: allowUnconfirmed,
        noCache: noCache,
      );
}

class DurableObjectListOptions {
  String? start;
  String? startAfter;
  String? end;
  String? prefix;
  bool? reverse;
  bool? limit;
  bool? allowConcurrency;
  bool? noCache;

  DurableObjectListOptions({
    this.start,
    this.startAfter,
    this.end,
    this.prefix,
    this.reverse,
    this.limit,
    this.allowConcurrency,
    this.noCache,
  });
}

extension DurableObjectListOptionsExtension on DurableObjectListOptions {
  interop.DurableObjectListOptions get delegate =>
      interop.DurableObjectListOptions(
        start: start,
        startAfter: startAfter,
        end: end,
        prefix: prefix,
        reverse: reverse,
        limit: limit,
        allowConcurrency: allowConcurrency,
        noCache: noCache,
      );
}
