import 'package:flutter_test/flutter_test.dart';

import 'package:mobilewright_demo_app/core/utils/validators.dart';

void main() {
  group('Validators.email', () {
    test('rejects empty', () => expect(Validators.email(''), 'Email is required'));
    test('rejects invalid format',
        () => expect(Validators.email('test@'), 'Enter a valid email'));
    test('accepts valid email', () => expect(Validators.email('a@b.com'), isNull));
  });

  group('Validators.newPassword', () {
    test('rejects short password', () {
      expect(Validators.newPassword('Ab1'),
          'Password must be at least 8 characters');
    });
    test('requires uppercase', () {
      expect(Validators.newPassword('abcdefg1'),
          'Password must contain an uppercase letter');
    });
    test('requires number', () {
      expect(Validators.newPassword('Abcdefgh'),
          'Password must contain a number');
    });
    test('accepts strong password',
        () => expect(Validators.newPassword('Test@1234'), isNull));
  });

  group('Validators.confirmPassword', () {
    test('rejects mismatch', () {
      expect(Validators.confirmPassword('x', 'y'), 'Passwords do not match');
    });
    test('accepts match', () {
      expect(Validators.confirmPassword('Test@1234', 'Test@1234'), isNull);
    });
  });

  group('Validators.phone', () {
    test('rejects wrong prefix', () {
      expect(Validators.phone('01312345678'),
          'Enter a valid Egyptian mobile number');
    });
    test('rejects short number', () {
      expect(Validators.phone('0101234'),
          'Enter a valid Egyptian mobile number');
    });
    test('accepts valid number',
        () => expect(Validators.phone('01012345678'), isNull));
  });
}
