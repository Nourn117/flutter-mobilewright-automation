import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:mobilewright_demo_app/domain/entities/checkout/order.dart';

part 'checkout_state.freezed.dart';

@freezed
sealed class CheckoutState with _$CheckoutState {
  const factory CheckoutState.initial() = CheckoutInitial;
  const factory CheckoutState.submitting() = CheckoutSubmitting;
  const factory CheckoutState.success(Order order) = CheckoutSuccess;
  const factory CheckoutState.failure(String message) = CheckoutFailure;
}
