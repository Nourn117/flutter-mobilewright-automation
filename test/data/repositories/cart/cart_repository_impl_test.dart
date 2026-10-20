import 'package:flutter_test/flutter_test.dart';

import 'package:mobilewright_demo_app/data/datasources/cart/cart_local_data_source.dart';
import 'package:mobilewright_demo_app/data/repositories/cart/cart_repository_impl.dart';
import 'package:mobilewright_demo_app/domain/entities/products/product.dart';

void main() {
  const headphones = Product(
    id: 'p1',
    name: 'Wireless Headphones',
    description: '',
    category: 'Audio',
    price: 2499,
  );

  late CartRepositoryImpl repository;

  setUp(() => repository = CartRepositoryImpl(CartLocalDataSource()));

  test('adding the same product merges quantities', () {
    repository
      ..add(headphones, 1)
      ..add(headphones, 2);
    final items = repository.getItems();
    expect(items, hasLength(1));
    expect(items.first.quantity, 3);
    expect(items.first.total, 7497);
  });

  test('setQuantity updates the quantity', () {
    repository
      ..add(headphones, 1)
      ..setQuantity('p1', 4);
    expect(repository.getItems().first.quantity, 4);
  });

  test('setQuantity to zero removes the item', () {
    repository
      ..add(headphones, 2)
      ..setQuantity('p1', 0);
    expect(repository.getItems(), isEmpty);
  });

  test('remove deletes the item', () {
    repository
      ..add(headphones, 1)
      ..remove('p1');
    expect(repository.getItems(), isEmpty);
  });
}
