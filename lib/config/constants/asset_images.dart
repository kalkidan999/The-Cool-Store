class AssetImages {
  static String plant = 'assets/images/plant.png';
  static String branding = 'assets/images/branding.png';

  // CachedNetworkImageProvider cachedNetworkImageProvider(String img) {
  //   return CachedNetworkImageProvider(img);
  // }

  // CachedNetworkImage cachedNetworkImage(String image) {
  //   return CachedNetworkImage(
  //     imageUrl: image,
  //     imageBuilder: (context, imageProvider) => Container(
  //       decoration: BoxDecoration(
  //         image: DecorationImage(
  //           image: imageProvider,
  //           fit: BoxFit.cover,
  //           colorFilter: const ColorFilter.mode(
  //             Colors.transparent,
  //             BlendMode.colorBurn,
  //           ),
  //         ),
  //       ),
  //     ),
  //     placeholder: (context, url) => Helpers().refreshingWidget(context),
  //     errorWidget: (context, url, error) => const Icon(Icons.error),
  //   );
  // }
}

class AssetIcons {
  static String backButton = 'assets/icons/back.svg';
  static String fluentEye = 'assets/icons/fluent_eye.svg';
}
