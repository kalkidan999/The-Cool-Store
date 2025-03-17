import 'package:coolstore/presentation/wishlist/cubit/wishlist_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../config/constants/app_constants.dart';
import '../../widgets/appbar_widget.dart';
import '../../widgets/wish_list_widget.dart';

class WishListScreen extends StatelessWidget {
  const WishListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return BlocBuilder<WishlistCubit, WishlistState>(
      builder: (context, state) {
        return Scaffold(
            body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: deviceSize.width * 0.04),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                sizedHeight(deviceSize.height * 0.02),
                AppbarWidget(
                    widget: Text("Wishlist",
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(fontWeight: FontWeight.w600))),
                sizedHeight(deviceSize.height * 0.02),
                Expanded(
                  child: ListView.builder(
                    itemCount: state.wishlist.length,
                    itemBuilder: (ctx, i) =>
                        WishListWidget(product: state.wishlist[i]),
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
