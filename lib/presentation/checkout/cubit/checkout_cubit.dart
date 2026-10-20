import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mobilewright_demo_app/core/result/result.dart';
import 'package:mobilewright_demo_app/domain/entities/checkout/checkout_details.dart';
import 'package:mobilewright_demo_app/domain/usecases/checkout/place_order_usecase.dart';
import 'package:mobilewright_demo_app/presentation/checkout/cubit/checkout_state.dart';

class CheckoutCubit extends Cubit<CheckoutState> {
  CheckoutCubit(this._placeOrder) : super(const CheckoutState.initial());

  final PlaceOrderUseCase _placeOrder;

  Future<void> placeOrder(CheckoutDetails details) async {
    if (state is CheckoutSubmitting) return;
    emit(const CheckoutState.submitting());
    final result = await _placeOrder(details);
    if (isClosed) return;
    emit(switch (result) {
      Success(:final data) => CheckoutState.success(data),
      Failure(:final message) => CheckoutState.failure(message),
    });
  }
}
