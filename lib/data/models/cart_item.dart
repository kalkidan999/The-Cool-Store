import 'package:coolstore/data/models/product_model.dart';
import 'package:coolstore/domain/entities/product.dart';

class CartItem {
  final Product product;
  int quantity;

  CartItem({
    required this.product,
    required this.quantity,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) => CartItem(
        product: json["product"] == null
            ? Product.empty()
            : ProductModel.fromJson(json["product"]) as Product,
        quantity: json["quantity"] ?? 1,
      );

  Map<String, dynamic> toJson() => {"product": product, "quantity": quantity};

  static CartItem empty = CartItem(quantity: 0, product: Product.empty());

  CartItem copyWith({Product? product, int? quantity}) {
    return CartItem(
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
    );
  }
}
