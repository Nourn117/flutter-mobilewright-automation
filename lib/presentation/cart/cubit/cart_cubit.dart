import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mobilewright_demo_app/domain/entities/products/product.dart';
import 'package:mobilewright_demo_app/domain/usecases/cart/add_to_cart_usecase.dart';
import 'package:mobilewright_demo_app/domain/usecases/cart/clear_cart_usecase.dart';
import 'package:mobilewright_demo_app/domain/usecases/cart/get_cart_usecase.dart';
import 'package:mobilewright_demo_app/domain/usecases/cart/remove_from_cart_usecase.dart';
import 'package:mobilewright_demo_app/domain/usecases/cart/update_quantity_usecase.dart';
import 'package:mobilewright_demo_app/presentation/cart/cubit/cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit({
    required GetCartUseCase getCart,
    required this._addToCart,
    required this._updateQuantity,
    required this._removeFromCart,
    required this._clearCart,
  })  : _getCart = getCart,
        super(CartState(items: getCart()));

  final GetCartUseCase _getCart;
  final AddToCartUseCase _addToCart;
  final UpdateQuantityUseCase _updateQuantity;
  final RemoveFromCartUseCase _removeFromCart;
  final ClearCartUseCase _clearCart;

  /// Re-reads the cart (e.g. after an order was placed).
  void refresh() => emit(CartState(items: _getCart()));

  void add(Product product, int quantity) {
    _addToCart(product, quantity);
    refresh();
  }

  void setQuantity(String productId, int quantity) {
    _updateQuantity(productId, quantity);
    refresh();
  }

  void remove(String productId) {
    _removeFromCart(productId);
    refresh();
  }

  void clear() {
    _clearCart();
    refresh();
  }
}
