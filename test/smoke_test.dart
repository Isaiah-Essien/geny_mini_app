// test/smoke_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:geny/core/models/business.dart';

//run a test to check if the Business model correctly normalizes messy JSON keys.
void main() {
  test('Business normalizes messy JSON keys', () {
    final b = Business.fromMessyJson({
      'biz_name': 'Glow & Go Salon',
      'bss_location': 'Atlanta',
      'contct_no': '+1 404 123 4567',
    });

    expect(b.name, 'Glow & Go Salon');
    expect(b.location, 'Atlanta');
    // phone is soft-normalized (spaces removed); leading '+' is preserved
    expect(b.phone.replaceAll(' ', ''), '+14041234567');
  });
}
