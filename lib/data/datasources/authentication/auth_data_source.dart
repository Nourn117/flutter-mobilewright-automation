import 'package:mobilewright_demo_app/data/models/authentication/user_model.dart';

class AuthException implements Exception {
  const AuthException(this.message);
  final String message;
}

abstract interface class AuthDataSource {
  Future<UserModel> login(String email, String password);

  Future<UserModel> register(String name, String email, String password);
}

/// In-memory auth used for testing.
/// Accounts:
/// - test@demo.com / Test@1234   -> valid user
/// - locked@demo.com / Test@1234 -> locked account
class AuthMockDataSource implements AuthDataSource {
  static const _latency = Duration(milliseconds: 800);

  final List<UserModel> _users = [
    const UserModel(
      name: 'Test User',
      email: 'test@demo.com',
      password: 'Test@1234',
    ),
    const UserModel(
      name: 'Locked User',
      email: 'locked@demo.com',
      password: 'Test@1234',
      isLocked: true,
    ),
  ];

  @override
  Future<UserModel> login(String email, String password) async {
    await Future<void>.delayed(_latency);
    final user = _users.where((u) => u.email == email).firstOrNull;
    if (user == null || user.password != password) {
      throw const AuthException('Invalid email or password');
    }
    if (user.isLocked) throw const AuthException('This account is locked');
    return user;
  }

  @override
  Future<UserModel> register(String name, String email, String password) async {
    await Future<void>.delayed(_latency);
    if (_users.any((u) => u.email == email)) {
      throw const AuthException('Email already registered');
    }
    final user = UserModel(name: name, email: email, password: password);
    _users.add(user);
    return user;
  }
}
