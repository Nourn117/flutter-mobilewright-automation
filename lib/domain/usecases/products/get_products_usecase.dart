import 'package:mobilewright_demo_app/core/result/result.dart';
import 'package:mobilewright_demo_app/domain/entities/products/product.dart';
import 'package:mobilewright_demo_app/domain/repositories/products/product_repository.dart';

class GetProductsUseCase {
  const GetProductsUseCase(this._repository);

  final ProductRepository _repository;

  Future<Result<List<Product>>> call() => _repository.getProducts();
}
