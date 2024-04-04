final class Headers {
  late Map<String, String> headers = {};

  Headers();

  factory Headers.builder() {
    return Headers();
  }

  Headers addHeaders(String key, String value) {
    if (headers.containsKey(key)) {
      throw Exception('Override headers exception');
    }

    headers[key] = value;

    return this;
  }

  Map<String, String> get values {
    return headers;
  }
}
