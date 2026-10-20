import 'package:mobilewright_demo_app/domain/entities/authentication/app_user.dart';
import 'package:mobilewright_demo_app/domain/repositories/authentication/auth_repository.dart';

class GetCurrentUserUseCase {
  const GetCurrentUserUseCase(this._repository);

  final AuthRepository _repository;

  AppUser? call() => _repository.currentUser;
}
