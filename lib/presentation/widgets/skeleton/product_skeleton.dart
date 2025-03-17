import 'package:coolstore/presentation/widgets/skeleton/skeleton.dart';
import 'package:flutter/material.dart';

import '../../../config/constants/app_constants.dart';

class ProductsSkelton extends StatelessWidget {
  const ProductsSkelton({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) => Card(
          margin: const EdgeInsets.all(8.0),
          child: ListTile(
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              leading: const RectangularSkeleton(height: 25),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  sizedHeight(5),
                  const Skeleton(width: double.maxFinite, height: 10),
                  sizedHeight(5),
                  const Skeleton(width: 100, height: 7),
                  sizedHeight(5),
                  const Skeleton(width: 100, height: 5)
                ],
              )),
        ),
      ),
    );
  }
}

class ProductDetailSkelton extends StatelessWidget {
  const ProductDetailSkelton({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        bottomNavigationBar: const Skeleton(width: 100, height: 15),
        body: Column(children: [
          const AspectRatio(aspectRatio: 1.15, child: Skeleton()),
          sizedHeight(10),
          const Skeleton(height: 12, width: double.maxFinite),
          sizedHeight(10),
          const AspectRatio(aspectRatio: 2.0, child: Skeleton()),
        ]));
  }
}
