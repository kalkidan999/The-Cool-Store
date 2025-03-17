import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import '../../../data/models/cart_item.dart';
import '../../../domain/entities/product.dart';

part 'cart_state.dart';

class CartCubit extends HydratedCubit<CartState> {
  CartCubit() : super(CartState(cart: []));

  static const key = 'carts';

  void addProduct(Product product) {
    final existingItem = state.cart.firstWhere(
      (item) => item.product.id == product.id,
      orElse: () => CartItem.empty,
    );

    if (existingItem.quantity == 0) {
      final updatedcart = List<CartItem>.from(state.cart)
        ..add(CartItem(product: product, quantity: 1));
      emit(CartState(cart: updatedcart));
    } else {
      final updatedcart = state.cart.map((item) {
        if (item.product.id == product.id) {
          return item.copyWith(quantity: item.quantity + 1);
        }
        return item;
      }).toList();
      emit(CartState(cart: updatedcart));
    }
  }

  void removeProduct(Product product) {
    final updatedItems =
        state.cart.where((item) => item.product.id != product.id).toList();
    emit(CartState(cart: updatedItems));
  }

  void decreaseQuantity(Product product) {
    final updatedItems = state.cart
        .map((item) {
          if (item.product.id == product.id) {
            if (item.quantity > 1) {
              return item.copyWith(quantity: item.quantity - 1);
            }
          }
          return item;
        })
        .where((item) => item.quantity > 0)
        .toList();
    emit(CartState(cart: updatedItems));
  }

  void clearCart() {
    emit(const CartState());
  }

  @override
  CartState fromJson(Map<String, dynamic> json) {
    try {
      final carts =
          json[key].map<CartItem>((e) => CartItem.fromJson(e)).toList();
      return CartState(cart: carts);
    } catch (err) {
      return CartState(cart: []);
    }
  }

  @override
  Map<String, dynamic> toJson(CartState state) {
    return {key: state.cart.map((e) => e.toJson()).toList()};
  }
}
