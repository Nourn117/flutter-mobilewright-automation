import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mobilewright_demo_app/core/result/result.dart';
import 'package:mobilewright_demo_app/domain/usecases/products/get_products_usecase.dart';
import 'package:mobilewright_demo_app/presentation/products/cubit/products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  ProductsCubit(this._getProducts) : super(const ProductsState.loading());

  final GetProductsUseCase _getProducts;
  String _query = '';

  Future<void> load() async {
    emit(const ProductsState.loading());
    final result = await _getProducts();
    if (isClosed) return;
    emit(switch (result) {
      Success(:final data) =>
        ProductsState.loaded(products: data, query: _query),
      Failure(:final message) => ProductsState.failure(message),
    });
  }

  void search(String query) {
    _query = query.trim();
    final current = state;
    if (current is ProductsLoaded) emit(current.copyWith(query: _query));
  }
}
