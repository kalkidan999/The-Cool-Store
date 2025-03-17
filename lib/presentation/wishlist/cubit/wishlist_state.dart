part of 'wishlist_cubit.dart';

final class WishlistState extends Equatable {
  const WishlistState({this.wishlist = const []});

  final List<ProductModel> wishlist;

  @override
  List<Object> get props => [wishlist];
}
