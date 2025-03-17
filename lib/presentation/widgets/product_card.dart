import 'package:auto_route/auto_route.dart';
import 'package:coolstore/app/app_router.gr.dart';
import 'package:coolstore/config/constants/app_assets.dart';
import 'package:coolstore/config/constants/app_constants.dart';
import 'package:coolstore/data/models/product_model.dart';
import 'package:coolstore/domain/entities/product.dart';
import 'package:coolstore/presentation/wishlist/cubit/wishlist_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    List<ProductModel> wishLists =
        context.select((WishlistCubit cubit) => cubit.state.wishlist);

    return Card(
      child: Stack(
        children: [
          Positioned(
              top: 12,
              right: 16,
              child: InkWell(
                onTap: () {
                  final wishedProduct = product as ProductModel;
                  if (wishLists.contains(product)) {
                    context
                        .read<WishlistCubit>()
                        .addProductToWishlist(wishedProduct);
                  } else {
                    context
                        .read<WishlistCubit>()
                        .removeProductFromWishlist(wishedProduct);
                  }
                },
                child: SvgPicture.asset(
                    wishLists.contains(product)
                        ? AppAssets.heartRed
                        : AppAssets.heartWhite,
                    height: 16,
                    width: 16),
              )),
          ListTile(
              onTap: () {
                AutoRouter.of(context)
                    .push(ProductDetailRoute(product: product));
              },
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              leading: Image.network(product.image, width: 70, height: 70),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: deviceSize.width * 0.4,
                    child: Text(product.title,
                        maxLines: 2,
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge
                            ?.copyWith(fontWeight: FontWeight.w600)),
                  ),
                  Text(product.category,
                      maxLines: 2,
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF000000).withValues(alpha: 0.5))),
                ],
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                            ?.copyWith(fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  sizedHeight(deviceSize.height * 0.015),
                  Text(
                    '\$${product.price.toString()}',
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge
                        ?.copyWith(fontWeight: FontWeight.w500),
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
