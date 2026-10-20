import 'package:flutter_test/flutter_test.dart';

import 'package:mobilewright_demo_app/core/result/result.dart';
import 'package:mobilewright_demo_app/data/datasources/cart/cart_local_data_source.dart';
import 'package:mobilewright_demo_app/data/datasources/checkout/order_data_source.dart';
import 'package:mobilewright_demo_app/data/repositories/cart/cart_repository_impl.dart';
import 'package:mobilewright_demo_app/data/repositories/checkout/order_repository_impl.dart';
import 'package:mobilewright_demo_app/domain/entities/checkout/checkout_details.dart';
import 'package:mobilewright_demo_app/domain/entities/checkout/order.dart';
import 'package:mobilewright_demo_app/domain/entities/products/product.dart';
import 'package:mobilewright_demo_app/domain/usecases/checkout/place_order_usecase.dart';

void main() {
  const speaker = Product(
    id: 'p3',
    name: 'Bluetooth Speaker',
    description: '',
    category: 'Audio',
    price: 1299,
  );

  final details = CheckoutDetails(
    fullName: 'Test User',
    phone: '01012345678',
    city: 'Cairo',
    address: '12 Tahrir Street, Downtown',
    deliveryDate: DateTime(2030, 1, 1),
    slot: DeliverySlot.morning,
    paymentMethod: PaymentMethod.cashOnDelivery,
  );

  late CartRepositoryImpl cart;
  late PlaceOrderUseCase placeOrder;

  setUp(() {
    cart = CartRepositoryImpl(CartLocalDataSource());
    placeOrder = PlaceOrderUseCase(
      OrderRepositoryImpl(OrderMockDataSource()),
      cart,
    );
  });

  test('fails when the cart is empty', () async {
    final result = await placeOrder(details);
    expect((result as Failure).message, 'Your cart is empty');
  });

  test('creates an order with totals and clears the cart', () async {
    cart.add(speaker, 2);
    final result = await placeOrder(details);
    final order = (result as Success<Order>).data;
    expect(order.id, 'ORD-1001');
    expect(order.subtotal, 2598);
    expect(order.total, 2648);
    expect(cart.getItems(), isEmpty);
  });
}
