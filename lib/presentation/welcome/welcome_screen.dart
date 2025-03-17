import 'package:auto_route/auto_route.dart';
import 'package:coolstore/app/app_router.gr.dart';
import 'package:coolstore/config/constants/app_constants.dart';
import 'package:coolstore/config/constants/app_assets.dart';
import 'package:coolstore/presentation/auth/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.status == AuthStatus.auth) {
          AutoRouter.of(context).pushAndPopUntil(HomeRoute(),
              predicate: (Route<dynamic> route) => false);
        }
      },
      child: Scaffold(
        body: Stack(
          children: [
            Image.asset(
              AssetImages.plant,
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
              alignment: Alignment.center,
            ),
            Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Image.asset(AssetImages.branding, width: 45, height: 45),
                    sizedHeight(deviceSize.height * 0.02),
                    Text("Fake Store",
                        style: Theme.of(context).textTheme.headlineMedium),
                    sizedHeight(deviceSize.height * 0.04),
                    BlocBuilder<AuthBloc, AuthState>(
                      builder: (context, state) {
                        return state.status == AuthStatus.initial ||
                                state.status == AuthStatus.loading
                            ? Container()
                            : SizedBox(
                                width: deviceSize.width * 0.9,
                                child: ElevatedButton(
                                    onPressed: () {
                                      AutoRouter.of(context).push(LoginRoute());
                                    },
                                    child: Text("Login")));
                      },
                    ),
                    sizedHeight(deviceSize.height * 0.25),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
