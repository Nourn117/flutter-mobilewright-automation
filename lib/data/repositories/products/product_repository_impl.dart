import 'package:mobilewright_demo_app/core/result/result.dart';
import 'package:mobilewright_demo_app/data/datasources/products/product_data_source.dart';
import 'package:mobilewright_demo_app/domain/entities/products/product.dart';
import 'package:mobilewright_demo_app/domain/repositories/products/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  ProductRepositoryImpl(this._dataSource);

  final ProductDataSource _dataSource;

  @override
  Future<Result<List<Product>>> getProducts() async {
    try {
      final models = await _dataSource.getProducts();
      return Success(models.map((m) => m.toEntity()).toList());
    } on Exception {
      return const Failure('Failed to load products');
    }
  }
}
