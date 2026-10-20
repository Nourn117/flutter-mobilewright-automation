import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:mobilewright_demo_app/domain/entities/cart/cart_item.dart';
import 'package:mobilewright_demo_app/domain/entities/checkout/checkout_details.dart';

part 'order.freezed.dart';

@freezed
abstract class Order with _$Order {
  const Order._();

  const factory Order({
    required String id,
    required CheckoutDetails details,
    required List<CartItem> items,
    required double subtotal,
    required double deliveryFee,
  }) = _Order;

  double get total => subtotal + deliveryFee;

  int get itemCount => items.fold(0, (sum, i) => sum + i.quantity);
}
