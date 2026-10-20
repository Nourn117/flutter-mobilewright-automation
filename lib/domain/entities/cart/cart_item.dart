import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:mobilewright_demo_app/domain/entities/products/product.dart';

part 'cart_item.freezed.dart';

@freezed
abstract class CartItem with _$CartItem {
  const CartItem._();

  const factory CartItem({
    required Product product,
    required int quantity,
  }) = _CartItem;

  double get total => product.price * quantity;
}
