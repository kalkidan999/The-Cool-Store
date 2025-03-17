import 'package:coolstore/config/constants/app_assets.dart';
import 'package:coolstore/config/constants/app_constants.dart';
import 'package:coolstore/presentation/cart/cubit/cart_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../data/models/cart_item.dart';

class CartItemWidget extends StatelessWidget {
  final CartItem cartItem;

  const CartItemWidget({super.key, required this.cartItem});

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Dismissible(
        key: ValueKey(cartItem.product.id),
        background: Container(
            color: Color(0xFFCC474E),
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(right: 20),
            child: SvgPicture.asset(AppAssets.delete)),
        direction: DismissDirection.endToStart,
        onDismissed: (direction) {
          context.read<CartCubit>().removeProduct(cartItem.product);
        },
        child: ListTile(
          contentPadding: EdgeInsets.only(right: 12),
          leading: Container(
            width: 70,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                image: DecorationImage(
                    image: NetworkImage(cartItem.product.image),
                    fit: BoxFit.fitWidth)),
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: deviceSize.width * 0.45,
                child: Text(cartItem.product.title,
                    maxLines: 1,
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge
                        ?.copyWith(fontWeight: FontWeight.w600)),
              ),
              sizedHeight(deviceSize.height * 0.01),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                        color: Color(0xFF000000).withValues(alpha: 0.1))),
                child: IntrinsicHeight(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _cartButtons(
                        InkWell(
                          child: SvgPicture.asset(AppAssets.minusCircle),
                          onTap: () => cartItem.quantity > 0
                              ? context
                                  .read<CartCubit>()
                                  .decreaseQuantity(cartItem.product)
                              : null,
                        ),
                      ),
                      VerticalDivider(color: Color(0xFFD9D9D9)),
                      _cartButtons(Text('${cartItem.quantity}',
                          textAlign: TextAlign.center)),
                      VerticalDivider(color: Color(0xFFD9D9D9)),
                      _cartButtons(
                        InkWell(
                          child: SvgPicture.asset(AppAssets.plusCircle),
                          onTap: () => context
                              .read<CartCubit>()
                              .addProduct(cartItem.product),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
          trailing: Text(
            '\$${(cartItem.product.price * cartItem.quantity).toString()}',
            style: Theme.of(context)
                .textTheme
                .titleSmall
                ?.copyWith(fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }

  Container _cartButtons(Widget child) {
    return Container(
        padding: EdgeInsets.all(3), width: 20, child: Center(child: child));
  }
}
