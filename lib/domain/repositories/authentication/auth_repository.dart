import 'package:mobilewright_demo_app/core/result/result.dart';
import 'package:mobilewright_demo_app/domain/entities/authentication/app_user.dart';

abstract interface class AuthRepository {
  AppUser? get currentUser;

  Future<Result<AppUser>> login(String email, String password);

  Future<Result<AppUser>> register(String name, String email, String password);

  Future<void> logout();
}
