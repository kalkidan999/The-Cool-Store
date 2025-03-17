part of 'product_bloc.dart';

enum ProductStatus { inital, loading, refreshing, loaded, error }

final class ProductState {
  const ProductState(
      {this.products = const [],
      this.status = ProductStatus.inital,
      this.errorMessage = ""});

  final List<Product> products;
  final String errorMessage;
  final ProductStatus status;

  ProductState copyWith(
      {ProductStatus? status, List<Product>? products, String? errorMessage}) {
    return ProductState(
        products: products ?? this.products,
        status: status ?? this.status,
        errorMessage: errorMessage ?? this.errorMessage);
  }

  List<Object> get props => [status, products, errorMessage];

  @override
  String toString() {
    return '''ProductsState { status: $status, errorMessage: $errorMessage, products: $products }''';
  }
}
