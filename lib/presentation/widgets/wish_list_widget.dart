import 'package:coolstore/config/constants/app_assets.dart';
import 'package:coolstore/config/constants/app_constants.dart';
import 'package:coolstore/domain/entities/product.dart';
import 'package:coolstore/presentation/cart/cubit/cart_cubit.dart';
import 'package:coolstore/utils/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../data/models/product_model.dart';
import '../wishlist/cubit/wishlist_cubit.dart';

class WishListWidget extends StatelessWidget {
  final Product product;

  const WishListWidget({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Card(
      child: Stack(
        children: [
          Positioned(
              top: 12,
              right: 16,
              child:
                  SvgPicture.asset(AppAssets.heartRed, height: 16, width: 16)),
          ListTile(
            onTap: () {
              final wishedProduct = product as ProductModel;
              context
                  .read<WishlistCubit>()
                  .removeProductFromWishlist(wishedProduct);
            },
            leading: Container(
              width: 70,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  image: DecorationImage(
                      image: NetworkImage(product.image),
                      fit: BoxFit.fitWidth)),
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                    width: deviceSize.width * 0.45,
                    child: Text(product.title,
                        maxLines: 1,
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge
                            ?.copyWith(fontWeight: FontWeight.w600))),
                sizedHeight(deviceSize.height * 0.005),
                Text('\$${product.price.toString()}',
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF000000).withValues(alpha: 0.5))),
                sizedHeight(deviceSize.height * 0.01),
                InkWell(
                  onTap: () {
                    context.read<CartCubit>().addProduct(product);
                    Dialogs()
                        .showInfoDialog(context, "Added To Cart", "success");
                  },
                  child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      color: Colors.white,
                      child: Center(
                        child: Text("Add To Cart",
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium
                                ?.copyWith(fontWeight: FontWeight.w600)),
                      )),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
