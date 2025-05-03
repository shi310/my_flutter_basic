import 'dart:convert';

extension MapExtension on Map {
  String toJsonString() {
    try {
      return jsonEncode(this);
    } catch (_) {
      return toString();
    }
  }
}
