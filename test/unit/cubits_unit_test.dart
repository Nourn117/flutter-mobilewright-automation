import 'package:flutter_test/flutter_test.dart';

import 'package:mobilewright_demo_app/core/state/submit_state.dart';
import 'package:mobilewright_demo_app/data/datasources/authentication/auth_data_source.dart';
import 'package:mobilewright_demo_app/data/datasources/cart/cart_local_data_source.dart';
import 'package:mobilewright_demo_app/data/datasources/products/product_data_source.dart';
import 'package:mobilewright_demo_app/data/repositories/authentication/auth_repository_impl.dart';
import 'package:mobilewright_demo_app/data/repositories/cart/cart_repository_impl.dart';
import 'package:mobilewright_demo_app/data/repositories/products/product_repository_impl.dart';
import 'package:mobilewright_demo_app/domain/entities/products/product.dart';
import 'package:mobilewright_demo_app/domain/usecases/authentication/login_usecase.dart';
import 'package:mobilewright_demo_app/domain/usecases/cart/add_to_cart_usecase.dart';
import 'package:mobilewright_demo_app/domain/usecases/cart/clear_cart_usecase.dart';
import 'package:mobilewright_demo_app/domain/usecases/cart/get_cart_usecase.dart';
import 'package:mobilewright_demo_app/domain/usecases/cart/remove_from_cart_usecase.dart';
import 'package:mobilewright_demo_app/domain/usecases/cart/update_quantity_usecase.dart';
import 'package:mobilewright_demo_app/domain/usecases/products/get_products_usecase.dart';
import 'package:mobilewright_demo_app/presentation/cart/cubit/cart_cubit.dart';
import 'package:mobilewright_demo_app/presentation/login/cubit/login_cubit.dart';
import 'package:mobilewright_demo_app/presentation/products/cubit/products_cubit.dart';
import 'package:mobilewright_demo_app/presentation/products/cubit/products_state.dart';

/// Unit tests for the presentation logic (Cubits) with the real use cases
/// and mock data sources – no UI involved.
void main() {
  const headphones = Product(
    id: 'p1',
    name: 'Wireless Headphones',
    description: '',
    category: 'Audio',
    price: 2499,
  );
  const speaker = Product(
    id: 'p3',
    name: 'Bluetooth Speaker',
    description: '',
    category: 'Audio',
    price: 1299,
  );

  test('UNIT-01 · CartCubit calculates count, subtotal, delivery fee and total', () async {
    final repository = CartRepositoryImpl(CartLocalDataSource());
    final cubit = CartCubit(
      getCart: GetCartUseCase(repository),
      addToCart: AddToCartUseCase(repository),
      updateQuantity: UpdateQuantityUseCase(repository),
      removeFromCart: RemoveFromCartUseCase(repository),
      clearCart: ClearCartUseCase(repository),
    );

    cubit
      ..add(speaker, 2)
      ..add(headphones, 1);

    expect(cubit.state.count, 3);
    expect(cubit.state.subtotal, 2 * 1299 + 2499); // 5,097
    expect(cubit.state.deliveryFee, 50);
    expect(cubit.state.total, 5147);

    await cubit.close();
  });

  test('UNIT-02 · ProductsCubit loads the catalogue and filters it by search', () async {
    final cubit = ProductsCubit(
      GetProductsUseCase(ProductRepositoryImpl(ProductMockDataSource())),
    );

    await cubit.load();
    expect((cubit.state as ProductsLoaded).filtered, hasLength(8));

    cubit.search('wireless');
    final names = (cubit.state as ProductsLoaded).filtered.map((p) => p.name);
    expect(names, ['Wireless Headphones', 'Wireless Earbuds']);

    await cubit.close();
  });

  test('UNIT-03 · LoginCubit emits loading then failure for a locked account', () async {
    final cubit = LoginCubit(
      LoginUseCase(AuthRepositoryImpl(AuthMockDataSource())),
    );

    final states = expectLater(
      cubit.stream,
      emitsInOrder(const [
        SubmitState.loading(),
        SubmitState.failure('This account is locked'),
      ]),
    );

    await cubit.login('locked@demo.com', 'Test@1234');
    await states;
    await cubit.close();
  });
}
