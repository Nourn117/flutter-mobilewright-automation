import 'package:mobilewright_demo_app/core/result/result.dart';
import 'package:mobilewright_demo_app/domain/entities/authentication/app_user.dart';
import 'package:mobilewright_demo_app/domain/repositories/authentication/auth_repository.dart';

class LoginUseCase {
  const LoginUseCase(this._repository);

  final AuthRepository _repository;

  Future<Result<AppUser>> call({
    required String email,
    required String password,
  }) =>
      _repository.login(email.trim(), password);
}
