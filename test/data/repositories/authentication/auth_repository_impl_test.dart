import 'package:flutter_test/flutter_test.dart';

import 'package:mobilewright_demo_app/core/result/result.dart';
import 'package:mobilewright_demo_app/data/datasources/authentication/auth_data_source.dart';
import 'package:mobilewright_demo_app/data/repositories/authentication/auth_repository_impl.dart';

void main() {
  late AuthRepositoryImpl repository;

  setUp(() => repository = AuthRepositoryImpl(AuthMockDataSource()));

  test('valid login returns user and sets current user', () async {
    final result = await repository.login('test@demo.com', 'Test@1234');
    expect(result, isA<Success>());
    expect(repository.currentUser?.email, 'test@demo.com');
  });

  test('wrong password returns failure', () async {
    final result = await repository.login('test@demo.com', 'wrong');
    expect((result as Failure).message, 'Invalid email or password');
    expect(repository.currentUser, isNull);
  });

  test('locked account returns failure', () async {
    final result = await repository.login('locked@demo.com', 'Test@1234');
    expect((result as Failure).message, 'This account is locked');
  });

  test('duplicate register returns failure', () async {
    final result =
        await repository.register('Test', 'test@demo.com', 'Test@1234');
    expect((result as Failure).message, 'Email already registered');
  });

  test('logout clears current user', () async {
    await repository.login('test@demo.com', 'Test@1234');
    await repository.logout();
    expect(repository.currentUser, isNull);
  });
}
