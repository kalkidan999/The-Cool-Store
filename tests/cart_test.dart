import 'package:bloc_test/bloc_test.dart';
import 'package:coolstore/data/models/product_model.dart';
import 'package:coolstore/data/models/rating_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:coolstore/presentation/cart/cubit/cart_cubit.dart';

import 'helpers/hydrated_bloc.dart';

void main() {
  initHydratedStorage();

  group('CartCubit', () {
    late CartCubit cartCubit;

    setUp(() {
      cartCubit = CartCubit();
    });

    tearDown(() {
      cartCubit.close();
    });

    test('Inital cart should be empty', () {
      expect(cartCubit.state.cart, isEmpty);
    });

    blocTest<CartCubit, CartState>(
      'emits updated state when a product is added to the cart',
      build: () => cartCubit,
      act: (cubit) => cubit.addProduct(ProductModel(
          id: 1,
          title: 'Product 1',
          price: 10.0,
          description: 'Description 1',
          category: 'Category 1',
          image: 'Image 1',
          rating: RatingModel(rate: 4.5, count: 10))),
      expect: () => [
        isA<CartState>().having((state) => state.cart.length, 'length', 1),
      ],
    );

    blocTest<CartCubit, CartState>(
      'emits updated state when a decreasing quantity',
      build: () => cartCubit,
      act: (cubit) {
        final product = ProductModel(
            id: 1,
            title: 'Product 1',
            price: 10.0,
            description: 'Description 1',
            category: 'Category 1',
            image: 'Image 1',
            rating: RatingModel(rate: 4.5, count: 10));

        cubit.addProduct(product);
        cubit.addProduct(product);
        cubit.decreaseQuantity(product);
      },
      expect: () => [
        isA<CartState>()
            .having((state) => state.cart[0].quantity, 'quantity', 1),
        isA<CartState>()
            .having((state) => state.cart[0].quantity, 'quantity', 2),
        isA<CartState>()
            .having((state) => state.cart[0].quantity, 'quantity', 1),
      ],
    );

    blocTest<CartCubit, CartState>(
      'emits updated state when cart is cleared',
      build: () => cartCubit,
      act: (cubit) {
        final product1 = ProductModel(
            id: 1,
            title: 'Product 1',
            price: 10.0,
            description: 'Description 1',
            category: 'Category 1',
            image: 'Image 1',
            rating: RatingModel(rate: 4.5, count: 10));
        final product2 = ProductModel(
            id: 2,
            title: 'Product 2',
            price: 10.0,
            description: 'Description 1',
            category: 'Category 1',
            image: 'Image 2',
            rating: RatingModel(rate: 4.5, count: 10));
        cubit.addProduct(product1);
        cubit.addProduct(product2);
        cubit.clearCart();
      },
      expect: () => [
        isA<CartState>().having((state) => state.cart.length, 'length', 1),
        isA<CartState>().having((state) => state.cart.length, 'length', 2),
        isA<CartState>().having((state) => state.cart.length, 'length', 0),
      ],
    );
  });
}
