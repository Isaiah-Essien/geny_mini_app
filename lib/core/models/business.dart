import 'dart:convert';


class Business {
  final String id; // derived stable id
  final String name;
  final String location;
  final String phone;

  Business({
    required this.id,
    required this.name,
    required this.location,
    required this.phone,
  });

  /// Normalizes the intentionally messy JSON keys into our clean domain model
  /// and performs minimal validation. Throws [FormatException] when invalid.
  factory Business.fromMessyJson(Map<String, dynamic> json) {
    //I mean, fromMessyJson is a cute method name :)
    final rawName = (json['biz_name'] ?? json['name'] ?? '').toString().trim();
    final rawLocation = (json['bss_location'] ?? json['location'] ?? '')
        .toString()
        .trim();
    final rawPhone = (json['contct_no'] ?? json['phone'] ?? '')
        .toString()
        .trim();

    if (rawName.isEmpty) {
      throw const FormatException('Missing business name');
    }
    if (rawLocation.isEmpty) {
      throw const FormatException('Missing location');
    }

    // Soft-normalize phone: remove spaces and ensure leading + if present in source
    String normalizedPhone = rawPhone.replaceAll(RegExp(r"[\s-]"), '');
    if (normalizedPhone.isNotEmpty && !normalizedPhone.startsWith('+')) {
      // keep it as-is if no country code, but still strip spaces
    }

    final id = base64Url.encode(utf8.encode('$rawName|$rawLocation'));

    return Business(
      id: id,
      name: rawName,
      location: rawLocation,
      phone: normalizedPhone,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'location': location,
    'phone': phone,
  };

  static List<Business> listFromMessyJson(List<dynamic> raw) {
    return raw
        .map((e) => Business.fromMessyJson(Map<String, dynamic>.from(e)))
        .toList();
  }
}
