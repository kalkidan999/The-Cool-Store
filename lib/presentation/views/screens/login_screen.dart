import 'package:auto_route/auto_route.dart';
import 'package:coolstore/config/constants/asset_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../config/constants/app_constants.dart';

@RoutePage()
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: deviceSize.width * 0.03),
      child: Scaffold(
        appBar: AppBar(leading: SvgPicture.asset(AssetIcons.backButton)),
        body: SingleChildScrollView(
            child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Welcome back! Glad to See you, Again!"),
              TextFormField(
                controller: _emailController,
                onSaved: (name) {
                  // User Name
                },
                validator: (_) => "Email is required",
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(hintText: "Enter your email"),
              ),
              sizedHeight(deviceSize.height * 0.03),
              TextFormField(
                controller: _passwordController,
                validator: (_) => "Email is required",
                textInputAction: TextInputAction.done,
                //  obscureText: !passwordVisible,
                obscuringCharacter: "*",
                decoration: InputDecoration(
                    filled: true,
                    hintText: "Enter your password",
                    suffixIcon: InkWell(
                        onTap: () {},
                        child: SvgPicture.asset(AssetIcons.fluentEye))),
              ),
              sizedHeight(deviceSize.height * 0.03),
              ElevatedButton(onPressed: () {}, child: Text("Login"))
            ],
          ),
        )),
      ),
    );
  }
}
