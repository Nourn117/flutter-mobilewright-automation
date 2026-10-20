import 'package:mobilewright_demo_app/core/result/result.dart';
import 'package:mobilewright_demo_app/domain/entities/authentication/app_user.dart';
import 'package:mobilewright_demo_app/domain/repositories/authentication/auth_repository.dart';

class RegisterUseCase {
  const RegisterUseCase(this._repository);

  final AuthRepository _repository;

  Future<Result<AppUser>> call({
    required String name,
    required String email,
    required String password,
  }) =>
      _repository.register(name.trim(), email.trim(), password);
}
