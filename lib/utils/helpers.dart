import 'package:flutter/material.dart';

class Helpers {
  Center loadingWidget(BuildContext context) {
    return Center(
        heightFactor: 1,
        widthFactor: 1,
        child: Transform.scale(
            scale: 0.5,
            child: const CircularProgressIndicator(
                strokeWidth: 3.0, color: Colors.white)));
  }
}
