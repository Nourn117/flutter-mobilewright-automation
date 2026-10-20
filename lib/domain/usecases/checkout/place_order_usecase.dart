import 'package:mobilewright_demo_app/core/result/result.dart';
import 'package:mobilewright_demo_app/domain/entities/checkout/checkout_details.dart';
import 'package:mobilewright_demo_app/domain/entities/checkout/order.dart';
import 'package:mobilewright_demo_app/domain/repositories/cart/cart_repository.dart';
import 'package:mobilewright_demo_app/domain/repositories/checkout/order_repository.dart';

/// Places an order with the current cart items and empties the cart on success.
class PlaceOrderUseCase {
  const PlaceOrderUseCase(this._orders, this._cart);

  final OrderRepository _orders;
  final CartRepository _cart;

  Future<Result<Order>> call(CheckoutDetails details) async {
    final items = _cart.getItems();
    if (items.isEmpty) return const Failure('Your cart is empty');
    final result = await _orders.placeOrder(details: details, items: items);
    if (result is Success<Order>) _cart.clear();
    return result;
  }
}
