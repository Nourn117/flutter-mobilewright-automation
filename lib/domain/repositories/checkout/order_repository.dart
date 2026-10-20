import 'package:mobilewright_demo_app/core/result/result.dart';
import 'package:mobilewright_demo_app/domain/entities/cart/cart_item.dart';
import 'package:mobilewright_demo_app/domain/entities/checkout/checkout_details.dart';
import 'package:mobilewright_demo_app/domain/entities/checkout/order.dart';

abstract interface class OrderRepository {
  Future<Result<Order>> placeOrder({
    required CheckoutDetails details,
    required List<CartItem> items,
  });
}
