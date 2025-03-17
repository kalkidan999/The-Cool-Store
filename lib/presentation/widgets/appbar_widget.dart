import 'package:coolstore/presentation/auth/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../config/constants/app_assets.dart';

class AppbarWidget extends StatelessWidget {
  const AppbarWidget({super.key, required this.widget});
  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        widget,
        InkWell(
          onTap: () {
            context.read<AuthBloc>().add(LogouRequested());
          },
          child: Column(
            children: [
              SvgPicture.asset(
                AppAssets.logout,
                width: 32,
                height: 28,
              ),
              Text("Log out",
                  style: Theme.of(context)
                      .textTheme
                      .labelSmall
                      ?.copyWith(fontWeight: FontWeight.w700))
            ],
          ),
        ),
      ],
    );
  }
}
