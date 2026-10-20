import 'package:mobilewright_demo_app/core/result/result.dart';
import 'package:mobilewright_demo_app/data/datasources/checkout/order_data_source.dart';
import 'package:mobilewright_demo_app/domain/entities/cart/cart_item.dart';
import 'package:mobilewright_demo_app/domain/entities/checkout/checkout_details.dart';
import 'package:mobilewright_demo_app/domain/entities/checkout/order.dart';
import 'package:mobilewright_demo_app/domain/entities/checkout/pricing.dart';
import 'package:mobilewright_demo_app/domain/repositories/checkout/order_repository.dart';

class OrderRepositoryImpl implements OrderRepository {
  OrderRepositoryImpl(this._dataSource);

  final OrderDataSource _dataSource;

  @override
  Future<Result<Order>> placeOrder({
    required CheckoutDetails details,
    required List<CartItem> items,
  }) async {
    try {
      final id = await _dataSource.submitOrder();
      final subtotal = items.fold<double>(0, (sum, i) => sum + i.total);
      return Success(Order(
        id: id,
        details: details,
        items: items,
        subtotal: subtotal,
        deliveryFee: Pricing.deliveryFee,
      ));
    } on Exception {
      return const Failure('Could not place your order. Please try again.');
    }
  }
}
