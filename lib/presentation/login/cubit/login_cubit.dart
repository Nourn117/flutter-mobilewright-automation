import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mobilewright_demo_app/core/result/result.dart';
import 'package:mobilewright_demo_app/core/state/submit_state.dart';
import 'package:mobilewright_demo_app/domain/usecases/authentication/login_usecase.dart';

class LoginCubit extends Cubit<SubmitState> {
  LoginCubit(this._login) : super(const SubmitState.initial());

  final LoginUseCase _login;

  Future<void> login(String email, String password) async {
    if (state is SubmitLoading) return;
    emit(const SubmitState.loading());
    final result = await _login(email: email, password: password);
    if (isClosed) return;
    emit(switch (result) {
      Success() => const SubmitState.success(),
      Failure(:final message) => SubmitState.failure(message),
    });
  }
}
