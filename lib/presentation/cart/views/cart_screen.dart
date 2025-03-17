import 'package:coolstore/presentation/cart/cubit/cart_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../config/constants/app_constants.dart';
import '../../widgets/cart_item_widget.dart';
import '../../widgets/appbar_widget.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        double totalPrice = state.cart.fold(
            0, (sum, cart) => sum + ((cart.product.price) * cart.quantity));
        return Scaffold(
            bottomNavigationBar: state.cart.isEmpty
                ? null
                : Container(
                    height: deviceSize.height * 0.13,
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        border: Border(
                            top: BorderSide(
                                color:
                                    Color(0xFF000000).withValues(alpha: 0.1)))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Cart total",
                                style: Theme.of(context)
                                    .textTheme
                                    .labelMedium
                                    ?.copyWith(
                                        fontWeight: FontWeight.w500,
                                        fontFamily: "Inter")),
                            Text('\$${totalPrice.toStringAsFixed(2)}',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.copyWith(
                                        fontWeight: FontWeight.w600,
                                        fontFamily: "Lora")),
                          ],
                        ),
                        SizedBox(
                            width: deviceSize.width * 0.6,
                            child: ElevatedButton(
                                onPressed: () {},
                                child: Text("Checkout",
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelMedium
                                        ?.copyWith(
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white))))
                      ],
                    )),
            body: SafeArea(
              child: Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: deviceSize.width * 0.04),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    sizedHeight(deviceSize.height * 0.02),
                    AppbarWidget(
                        widget: Text("Cart",
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall
                                ?.copyWith(fontWeight: FontWeight.w600))),
                    sizedHeight(deviceSize.height * 0.02),
                    Expanded(
                      child: ListView.builder(
                        itemCount: state.cart.length,
                        itemBuilder: (ctx, i) => CartItemWidget(
                          cartItem: state.cart[i],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ));
      },
    );
  }
}
