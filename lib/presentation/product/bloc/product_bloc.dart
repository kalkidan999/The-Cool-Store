import 'package:bloc/bloc.dart';
import 'package:coolstore/core/error/error_handler.dart';
import 'package:coolstore/domain/usecases/get_products.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/product.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final GetProducts getProducts;
  ProductBloc({required this.getProducts}) : super(ProductState()) {
    on<FetchProducts>(_onFetchProducts);
  }

  Future<void> _onFetchProducts(
      FetchProducts event, Emitter<ProductState> emitter) async {
    try {
      emit(state.copyWith(status: ProductStatus.loading));
      List<Product> products = await getProducts();

      emit(state.copyWith(status: ProductStatus.loaded, products: products));
    } on ErrorHandler catch (e) {
      emit(state.copyWith(
          status: ProductStatus.error, errorMessage: e.errorMessage));
    } catch (e) {
      emit(state.copyWith(
          status: ProductStatus.error, errorMessage: e.toString()));
    }
  }
}
