import 'package:flutter_test/flutter_test.dart';

import 'package:mobilewright_demo_app/core/utils/format.dart';

void main() {
  test('formats EGP with thousands separator', () {
    expect(formatPrice(2499), 'EGP 2,499');
    expect(formatPrice(123456), 'EGP 123,456');
    expect(formatPrice(899), 'EGP 899');
  });

  test('keeps piasters when present', () {
    expect(formatPrice(45.5), 'EGP 45.50');
  });

  test('formats dates', () {
    expect(formatDate(DateTime(2026, 10, 21)), 'Wed, 21 Oct 2026');
  });
}
