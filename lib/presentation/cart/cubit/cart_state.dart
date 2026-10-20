import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:mobilewright_demo_app/domain/entities/cart/cart_item.dart';
import 'package:mobilewright_demo_app/domain/entities/checkout/pricing.dart';

part 'cart_state.freezed.dart';

@freezed
abstract class CartState with _$CartState {
  const CartState._();

  const factory CartState({
    @Default(<CartItem>[]) List<CartItem> items,
  }) = _CartState;

  bool get isEmpty => items.isEmpty;

  int get count => items.fold(0, (sum, i) => sum + i.quantity);

  double get subtotal => items.fold<double>(0, (sum, i) => sum + i.total);

  double get deliveryFee => isEmpty ? 0 : Pricing.deliveryFee;

  double get total => subtotal + deliveryFee;
}
