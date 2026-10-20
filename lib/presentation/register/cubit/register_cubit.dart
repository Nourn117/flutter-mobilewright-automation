import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mobilewright_demo_app/core/result/result.dart';
import 'package:mobilewright_demo_app/core/state/submit_state.dart';
import 'package:mobilewright_demo_app/domain/usecases/authentication/register_usecase.dart';

class RegisterCubit extends Cubit<SubmitState> {
  RegisterCubit(this._register) : super(const SubmitState.initial());

  final RegisterUseCase _register;

  Future<void> register({
    required String name,
    required String email,
    required String password,
  }) async {
    if (state is SubmitLoading) return;
    emit(const SubmitState.loading());
    final result =
        await _register(name: name, email: email, password: password);
    if (isClosed) return;
    emit(switch (result) {
      Success() => const SubmitState.success(),
      Failure(:final message) => SubmitState.failure(message),
    });
  }
}
