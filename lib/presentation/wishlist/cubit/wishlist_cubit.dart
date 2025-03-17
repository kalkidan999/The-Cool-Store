import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:coolstore/data/models/product_model.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'wishlist_state.dart';

class WishlistCubit extends Cubit<WishlistState> {
  WishlistCubit() : super(const WishlistState()) {
    _loadWishlist();
  }

  Future<void> _loadWishlist() async {
    final prefs = await SharedPreferences.getInstance();
    final wishlistJson = prefs.getStringList('wishlist') ?? [];
    final wishlist = wishlistJson
        .map((item) => ProductModel.fromJson(json.decode(item)))
        .toList();
    emit(WishlistState(wishlist: wishlist));
  }

  Future<void> addProductToWishlist(ProductModel product) async {
    final prefs = await SharedPreferences.getInstance();
    final updatedWishlist = List<ProductModel>.from(state.wishlist)
      ..add(product);

    final wishlistJson =
        updatedWishlist.map((item) => json.encode(item.toJson())).toList();
    await prefs.setStringList('wishlist', wishlistJson);

    emit(WishlistState(wishlist: updatedWishlist));
  }

  Future<void> removeProductFromWishlist(ProductModel product) async {
    final prefs = await SharedPreferences.getInstance();
    final updatedWishlist =
        state.wishlist.where((item) => item.id != product.id).toList();

    final wishlistJson =
        updatedWishlist.map((item) => json.encode(item.toJson())).toList();
    await prefs.setStringList('wishlist', wishlistJson);

    emit(WishlistState(wishlist: updatedWishlist));
  }
}
