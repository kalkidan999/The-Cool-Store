import 'package:auto_route/auto_route.dart';
import 'package:coolstore/app/app_router.gr.dart';
import 'package:coolstore/config/constants/app_assets.dart';
import 'package:coolstore/presentation/auth/bloc/auth_bloc.dart';
import 'package:coolstore/utils/dialogs.dart';
import 'package:coolstore/utils/helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../config/constants/app_constants.dart';
import '../cubit/password_visibility_cubit.dart';

@RoutePage()
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    bool visiblePassword =
        context.select((PasswordVisibilityCubit cubit) => cubit.state);
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          title: SvgPicture.asset(AppAssets.backButton)),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state.status == AuthStatus.auth) {
            AutoRouter.of(context).pushAndPopUntil(HomeRoute(),
                predicate: (Route<dynamic> route) => false);
          } else if (state.status == AuthStatus.error) {
            Dialogs().showInfoDialog(context, state.errorMessage, "error");
          }
        },
        builder: (context, state) {
          bool loading = state.status == AuthStatus.loading;
          return SingleChildScrollView(
              child: Padding(
            padding: EdgeInsets.symmetric(horizontal: deviceSize.width * 0.05),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  sizedHeight(deviceSize.height * 0.02),
                  SizedBox(
                    width: 280,
                    child: Text("Welcome back! Glad to See you, Again!",
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w700, letterSpacing: 0.01)),
                  ),
                  sizedHeight(deviceSize.height * 0.03),
                  TextFormField(
                    controller: _nameController,
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return "User name is required";
                      }
                      return null;
                    },
                    textInputAction: TextInputAction.next,
                    decoration:
                        InputDecoration(hintText: "Enter your user name"),
                  ),
                  sizedHeight(deviceSize.height * 0.03),
                  TextFormField(
                    controller: _passwordController,
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return "Password is required";
                      }
                      return null;
                    },
                    textInputAction: TextInputAction.done,
                    obscureText: !visiblePassword,
                    obscuringCharacter: "*",
                    decoration: InputDecoration(
                        suffixIconConstraints: BoxConstraints(),
                        hintText: "Enter your password",
                        suffixIcon: IconButton(
                            onPressed: () {
                              context
                                  .read<PasswordVisibilityCubit>()
                                  .setPasswordVisibility(!visiblePassword);
                            },
                            icon: SvgPicture.asset(AppAssets.fluentEye))),
                  ),
                  sizedHeight(deviceSize.height * 0.05),
                  ElevatedButton(
                      onPressed: loading
                          ? () {}
                          : () {
                              if (_formKey.currentState!.validate()) {
                                FocusScope.of(context).unfocus();

                                context.read<AuthBloc>().add(AuthLoginRequested(
                                    userName: _nameController.text.trim(),
                                    password: _passwordController.text.trim()));
                              }
                            },
                      child: loading
                          ? Helpers().loadingWidget(context)
                          : Text("Login"))
                ],
              ),
            ),
          ));
        },
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
