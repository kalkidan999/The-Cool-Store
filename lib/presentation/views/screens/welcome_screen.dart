import 'package:auto_route/auto_route.dart';
import 'package:coolstore/config/constants/asset_images.dart';
import 'package:flutter/material.dart';

@RoutePage()
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return SafeArea(
        child: Stack(
      children: [
        Container(
          decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage(AssetImages.plant))),
        ),
        Positioned(
          top: deviceSize.height * 0.4,
          child: Column(
            children: [
              Image(image: AssetImage(AssetImages.branding)),
              SizedBox(height: deviceSize.height * 0.02),
              Text("Fake Store",
                  style: Theme.of(context).textTheme.labelMedium),
              SizedBox(height: deviceSize.height * 0.04),
              ElevatedButton(onPressed: () {}, child: Text("Login"))
            ],
          ),
        ),
      ],
    ));
  }
}
