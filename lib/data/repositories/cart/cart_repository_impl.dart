import 'package:mobilewright_demo_app/data/datasources/cart/cart_local_data_source.dart';
import 'package:mobilewright_demo_app/domain/entities/cart/cart_item.dart';
import 'package:mobilewright_demo_app/domain/entities/products/product.dart';
import 'package:mobilewright_demo_app/domain/repositories/cart/cart_repository.dart';

class CartRepositoryImpl implements CartRepository {
  CartRepositoryImpl(this._dataSource);

  final CartLocalDataSource _dataSource;

  @override
  List<CartItem> getItems() => _dataSource.getAll();

  @override
  void add(Product product, int quantity) {
    final existing = _dataSource.find(product.id);
    _dataSource.save(CartItem(
      product: product,
      quantity: (existing?.quantity ?? 0) + quantity,
    ));
  }

  @override
  void setQuantity(String productId, int quantity) {
    final existing = _dataSource.find(productId);
    if (existing == null) return;
    if (quantity <= 0) {
      _dataSource.remove(productId);
    } else {
      _dataSource.save(existing.copyWith(quantity: quantity));
    }
  }

  @override
  void remove(String productId) => _dataSource.remove(productId);

  @override
  void clear() => _dataSource.clear();
}
