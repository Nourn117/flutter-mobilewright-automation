import 'package:mobilewright_demo_app/domain/entities/cart/cart_item.dart';
import 'package:mobilewright_demo_app/domain/entities/products/product.dart';

abstract interface class CartRepository {
  List<CartItem> getItems();

  void add(Product product, int quantity);

  /// Sets the quantity of an item; 0 or less removes it.
  void setQuantity(String productId, int quantity);

  void remove(String productId);

  void clear();
}
