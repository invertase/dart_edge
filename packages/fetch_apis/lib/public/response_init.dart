import 'headers.dart';

class ResponseInit {
  final int? status;
  final String? statusText;
  final Headers? headers;

  ResponseInit({
    this.status,
    this.statusText,
    this.headers,
  });
}

// Extension since we only need it internally.
extension ResponseInitExtension on ResponseInit {
  Map<String, Object?> toJson() {
    return {
      if (status != null) 'status': status,
      if (statusText != null) 'statusText': statusText,
      if (headers != null) 'headers': headers,
    };
  }
}

