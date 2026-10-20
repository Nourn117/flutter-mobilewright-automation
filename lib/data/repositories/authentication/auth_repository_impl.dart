import 'package:mobilewright_demo_app/core/result/result.dart';
import 'package:mobilewright_demo_app/data/datasources/authentication/auth_data_source.dart';
import 'package:mobilewright_demo_app/domain/entities/authentication/app_user.dart';
import 'package:mobilewright_demo_app/domain/repositories/authentication/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this._dataSource);

  final AuthDataSource _dataSource;
  AppUser? _currentUser;

  @override
  AppUser? get currentUser => _currentUser;

  @override
  Future<Result<AppUser>> login(String email, String password) async {
    try {
      final user = (await _dataSource.login(email, password)).toEntity();
      _currentUser = user;
      return Success(user);
    } on AuthException catch (e) {
      return Failure(e.message);
    }
  }

  @override
  Future<Result<AppUser>> register(
    String name,
    String email,
    String password,
  ) async {
    try {
      final user =
          (await _dataSource.register(name, email, password)).toEntity();
      return Success(user);
    } on AuthException catch (e) {
      return Failure(e.message);
    }
  }

  @override
  Future<void> logout() async => _currentUser = null;
}
