import 'package:auto_route/auto_route.dart';
import 'package:coolstore/config/constants/app_assets.dart';
import 'package:coolstore/presentation/cart/cubit/cart_cubit.dart';
import 'package:coolstore/presentation/wishlist/cubit/wishlist_cubit.dart';
import 'package:coolstore/utils/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../config/constants/app_constants.dart';
import '../../../data/models/product_model.dart';
import '../../../domain/entities/product.dart';

@RoutePage()
class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key, required this.product});
  final Product product;

  @override
  Widget build(BuildContext context) {
    List<ProductModel> wishLists =
        context.select((WishlistCubit cubit) => cubit.state.wishlist);
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
        bottomNavigationBar: Container(
            height: deviceSize.height * 0.13,
            padding: EdgeInsets.all(20),
            color: Color(0xFFFFE8B2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Price",
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium
                            ?.copyWith(
                                fontWeight: FontWeight.w500,
                                fontFamily: "Inter")),
                    // sizedHeight(5),
                    Text('\$${product.price.toString()}',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w600, fontFamily: "Lora")),
                  ],
                ),
                SizedBox(
                    width: deviceSize.width * 0.6,
                    child: ElevatedButton(
                        onPressed: () {
                          context.read<CartCubit>().addProduct(product);
                          Dialogs().showInfoDialog(
                              context, "Added To Cart", "success");
                        },
                        child: Text("Add to Cart",
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium
                                ?.copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white))))
              ],
            )),
        body: SafeArea(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          sizedHeight(deviceSize.height * 0.02),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: deviceSize.width * 0.05),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  child: SvgPicture.asset(
                    AppAssets.backArrow,
                    height: 20,
                    width: 20,
                    colorFilter:
                        ColorFilter.mode(Color(0xFF3A3A3A), BlendMode.srcIn),
                  ),
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                ),
                IconButton(
                  onPressed: () {
                    final wishedProduct = product as ProductModel;
                    if (wishLists.contains(product)) {
                      context
                          .read<WishlistCubit>()
                          .removeProductFromWishlist(wishedProduct);
                    } else {
                      context
                          .read<WishlistCubit>()
                          .addProductToWishlist(wishedProduct);
                      Dialogs().showInfoDialog(
                          context, "Added To Wishlist", "success");
                    }
                  },
                  icon: SvgPicture.asset(
                      wishLists.contains(product)
                          ? AppAssets.heartRed
                          : AppAssets.heartWhite,
                      height: 16,
                      width: 16),
                )
              ],
            ),
          ),
          Spacer(),
          Align(
            alignment: Alignment.center,
            child: SizedBox(
                height: deviceSize.height * 0.45,
                child: Image.network(product.image,
                    width: deviceSize.width * 0.8)),
          ),
          Spacer(),
          Container(
            margin: EdgeInsets.symmetric(horizontal: deviceSize.width * 0.05),
            width: deviceSize.width * 0.7,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(product.title,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(fontWeight: FontWeight.w600)),
                sizedHeight(deviceSize.height * 0.01),
                Text(product.category,
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF000000).withValues(alpha: 0.5))),
                sizedHeight(deviceSize.height * 0.01),
                Row(
                  children: [
                    SvgPicture.asset(AppAssets.star),
                    sizedWidth(3),
                    Text(
                      product.rating.rate.toStringAsFixed(2),
                      style: Theme.of(context)
                          .textTheme
                          .labelMedium
                          ?.copyWith(fontWeight: FontWeight.w600),
                    ),
                    sizedWidth(5),
                    Text(
                      "${product.rating.count.round().toString()} Reviews",
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                          color: Color(0xFFA6A6AA)),
                    ),
                  ],
                ),
                sizedHeight(deviceSize.height * 0.03),
              ],
            ),
          )
        ])));
  }
}
