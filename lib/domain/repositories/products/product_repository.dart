import 'package:mobilewright_demo_app/core/result/result.dart';
import 'package:mobilewright_demo_app/domain/entities/products/product.dart';

abstract interface class ProductRepository {
  Future<Result<List<Product>>> getProducts();
}
