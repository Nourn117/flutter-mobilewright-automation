import 'package:get_it/get_it.dart';

import 'package:mobilewright_demo_app/core/theme/theme_cubit.dart';
import 'package:mobilewright_demo_app/data/datasources/authentication/auth_data_source.dart';
import 'package:mobilewright_demo_app/data/datasources/cart/cart_local_data_source.dart';
import 'package:mobilewright_demo_app/data/datasources/checkout/order_data_source.dart';
import 'package:mobilewright_demo_app/data/datasources/products/product_data_source.dart';
import 'package:mobilewright_demo_app/data/repositories/authentication/auth_repository_impl.dart';
import 'package:mobilewright_demo_app/data/repositories/cart/cart_repository_impl.dart';
import 'package:mobilewright_demo_app/data/repositories/checkout/order_repository_impl.dart';
import 'package:mobilewright_demo_app/data/repositories/products/product_repository_impl.dart';
import 'package:mobilewright_demo_app/domain/repositories/authentication/auth_repository.dart';
import 'package:mobilewright_demo_app/domain/repositories/cart/cart_repository.dart';
import 'package:mobilewright_demo_app/domain/repositories/checkout/order_repository.dart';
import 'package:mobilewright_demo_app/domain/repositories/products/product_repository.dart';
import 'package:mobilewright_demo_app/domain/usecases/authentication/get_current_user_usecase.dart';
import 'package:mobilewright_demo_app/domain/usecases/authentication/login_usecase.dart';
import 'package:mobilewright_demo_app/domain/usecases/authentication/logout_usecase.dart';
import 'package:mobilewright_demo_app/domain/usecases/authentication/register_usecase.dart';
import 'package:mobilewright_demo_app/domain/usecases/cart/add_to_cart_usecase.dart';
import 'package:mobilewright_demo_app/domain/usecases/cart/clear_cart_usecase.dart';
import 'package:mobilewright_demo_app/domain/usecases/cart/get_cart_usecase.dart';
import 'package:mobilewright_demo_app/domain/usecases/cart/remove_from_cart_usecase.dart';
import 'package:mobilewright_demo_app/domain/usecases/cart/update_quantity_usecase.dart';
import 'package:mobilewright_demo_app/domain/usecases/checkout/place_order_usecase.dart';
import 'package:mobilewright_demo_app/domain/usecases/products/get_products_usecase.dart';
import 'package:mobilewright_demo_app/presentation/cart/cubit/cart_cubit.dart';
import 'package:mobilewright_demo_app/presentation/checkout/cubit/checkout_cubit.dart';
import 'package:mobilewright_demo_app/presentation/common/cubit/session_cubit.dart';
import 'package:mobilewright_demo_app/presentation/home/cubit/home_tab_cubit.dart';
import 'package:mobilewright_demo_app/presentation/login/cubit/login_cubit.dart';
import 'package:mobilewright_demo_app/presentation/products/cubit/products_cubit.dart';
import 'package:mobilewright_demo_app/presentation/register/cubit/register_cubit.dart';

final GetIt sl = GetIt.instance;

void configureDependencies() {
  // App-wide
  sl
    ..registerFactory(ThemeCubit.new)
    ..registerFactory(HomeTabCubit.new);

  // Authentication
  sl
    ..registerLazySingleton<AuthDataSource>(AuthMockDataSource.new)
    ..registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()))
    ..registerLazySingleton(() => LoginUseCase(sl()))
    ..registerLazySingleton(() => RegisterUseCase(sl()))
    ..registerLazySingleton(() => LogoutUseCase(sl()))
    ..registerLazySingleton(() => GetCurrentUserUseCase(sl()))
    ..registerFactory(() => LoginCubit(sl()))
    ..registerFactory(() => RegisterCubit(sl()))
    ..registerFactory(() => SessionCubit(
          getCurrentUser: sl(),
          logout: sl(),
        ));

  // Products
  sl
    ..registerLazySingleton<ProductDataSource>(ProductMockDataSource.new)
    ..registerLazySingleton<ProductRepository>(
        () => ProductRepositoryImpl(sl()))
    ..registerLazySingleton(() => GetProductsUseCase(sl()))
    ..registerFactory(() => ProductsCubit(sl()));

  // Cart
  sl
    ..registerLazySingleton(CartLocalDataSource.new)
    ..registerLazySingleton<CartRepository>(() => CartRepositoryImpl(sl()))
    ..registerLazySingleton(() => GetCartUseCase(sl()))
    ..registerLazySingleton(() => AddToCartUseCase(sl()))
    ..registerLazySingleton(() => UpdateQuantityUseCase(sl()))
    ..registerLazySingleton(() => RemoveFromCartUseCase(sl()))
    ..registerLazySingleton(() => ClearCartUseCase(sl()))
    ..registerFactory(() => CartCubit(
          getCart: sl(),
          addToCart: sl(),
          updateQuantity: sl(),
          removeFromCart: sl(),
          clearCart: sl(),
        ));

  // Checkout
  sl
    ..registerLazySingleton<OrderDataSource>(OrderMockDataSource.new)
    ..registerLazySingleton<OrderRepository>(() => OrderRepositoryImpl(sl()))
    ..registerLazySingleton(() => PlaceOrderUseCase(sl(), sl()))
    ..registerFactory(() => CheckoutCubit(sl()));
}
