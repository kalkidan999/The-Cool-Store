part of 'cart_cubit.dart';

final class CartState extends Equatable {
  const CartState({this.cart = const <CartItem>[]});

  final List<CartItem> cart;

  @override
  List<Object> get props => [cart];
}
