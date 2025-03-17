import 'package:flutter/material.dart';
import 'package:fade_shimmer/fade_shimmer.dart';

class Skeleton extends StatelessWidget {
  const Skeleton(
      {super.key,
      this.height,
      this.width,
      this.layer = 1,
      this.color,
      this.radius = 12});

  final double? height, width;
  final int layer;
  final double radius;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return FadeShimmer(
      fadeTheme: FadeTheme.light,
      height: height ?? 8,
      width: width ?? 100,
      radius: 4,
    );
  }
}

class CircleSkeleton extends StatelessWidget {
  const CircleSkeleton({super.key, this.size = 24});

  final double? size;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        color: Theme.of(context).iconTheme.color!.withValues(alpha: 0.04),
        shape: BoxShape.circle,
      ),
    );
  }
}

class RectangularSkeleton extends StatelessWidget {
  const RectangularSkeleton({super.key, this.height});
  final double? height;

  @override
  Widget build(BuildContext context) {
    return FadeShimmer(
      height: height ?? double.maxFinite,
      width: 100,
      fadeTheme: FadeTheme.light,
    );
  }
}
