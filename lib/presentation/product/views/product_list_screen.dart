import 'package:coolstore/config/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../widgets/appbar_widget.dart';
import '../../widgets/product_card.dart';
import '../../widgets/skeleton/product_skeleton.dart';
import '../bloc/product_bloc.dart';

class ProductListScreen extends StatelessWidget {
  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: deviceSize.width * 0.04),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            sizedHeight(deviceSize.height * 0.02),
            AppbarWidget(
                widget: SizedBox(
              width: deviceSize.width * 0.3,
              child: Text("Welcome, johnd",
                  maxLines: 2,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(fontWeight: FontWeight.w600)),
            )),
            sizedHeight(deviceSize.height * 0.02),
            Text("Fake Store",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontWeight: FontWeight.w600)),
            sizedHeight(deviceSize.height * 0.02),
            BlocBuilder<ProductBloc, ProductState>(
              builder: (context, state) {
                if (state.status == ProductStatus.loading) {
                  return ProductsSkelton();
                } else if (state.status == ProductStatus.loaded) {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: state.products.length,
                      itemBuilder: (context, index) {
                        final product = state.products[index];
                        return ProductCard(product: product);
                      },
                    ),
                  );
                } else if (state.status == ProductStatus.error) {
                  return Center(
                      child: Column(
                    children: [
                      Text("Error fetching products"),
                      IconButton(
                          onPressed: () {
                            context.read<ProductBloc>().add(FetchProducts());
                          },
                          icon: Icon(Icons.refresh))
                    ],
                  ));
                }
                return const Center(child: Text('No products available.'));
              },
            ),
          ],
        ),
      ),
    ));
  }
}
