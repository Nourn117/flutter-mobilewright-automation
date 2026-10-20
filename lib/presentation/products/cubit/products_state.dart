import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:mobilewright_demo_app/domain/entities/products/product.dart';

part 'products_state.freezed.dart';

@freezed
sealed class ProductsState with _$ProductsState {
  const factory ProductsState.loading() = ProductsLoading;

  const factory ProductsState.loaded({
    required List<Product> products,
    @Default('') String query,
  }) = ProductsLoaded;

  const factory ProductsState.failure(String message) = ProductsFailure;
}

extension ProductsLoadedX on ProductsLoaded {
  List<Product> get filtered => products
      .where((p) => p.name.toLowerCase().contains(query.toLowerCase()))
      .toList();
}
