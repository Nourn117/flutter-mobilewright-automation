import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mobilewright_demo_app/domain/entities/authentication/app_user.dart';
import 'package:mobilewright_demo_app/domain/usecases/authentication/get_current_user_usecase.dart';
import 'package:mobilewright_demo_app/domain/usecases/authentication/logout_usecase.dart';

/// Holds the signed-in user for the whole app (null = signed out).
class SessionCubit extends Cubit<AppUser?> {
  SessionCubit({
    required this._getCurrentUser,
    required this._logout,
  }) : super(null);

  final GetCurrentUserUseCase _getCurrentUser;
  final LogoutUseCase _logout;

  void refresh() => emit(_getCurrentUser());

  Future<void> logout() async {
    await _logout();
    emit(null);
  }
}
