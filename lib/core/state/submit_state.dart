import 'package:freezed_annotation/freezed_annotation.dart';

part 'submit_state.freezed.dart';

/// Shared state for simple submit flows (login, register, checkout).
@freezed
sealed class SubmitState with _$SubmitState {
  const factory SubmitState.initial() = SubmitInitial;
  const factory SubmitState.loading() = SubmitLoading;
  const factory SubmitState.success() = SubmitSuccess;
  const factory SubmitState.failure(String message) = SubmitFailure;
}
