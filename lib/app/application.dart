import 'package:coolstore/app/app_router.dart';
import 'package:coolstore/core/di/injector.dart';
import 'package:coolstore/presentation/auth/bloc/auth_bloc.dart';
import 'package:coolstore/presentation/auth/cubit/password_visibility_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../config/theme/theme_data.dart';
import '../presentation/cart/cubit/cart_cubit.dart';
import '../presentation/home/cubit/home_cubit.dart';
import '../presentation/product/bloc/product_bloc.dart';
import '../presentation/wishlist/cubit/wishlist_cubit.dart';

class Application extends StatefulWidget {
  const Application({super.key});

  @override
  State<Application> createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  final _appRouter = AppRouter();
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => HomeCubit()),
        BlocProvider(create: (_) => PasswordVisibilityCubit()),
        BlocProvider(create: (_) => CartCubit()),
        BlocProvider(create: (_) => WishlistCubit()),
        BlocProvider(
            create: (context) => getIt<ProductBloc>()..add(FetchProducts())),
        BlocProvider(create: (context) => getIt<AuthBloc>()..add(AppStarted()))
      ],
      child: MaterialApp.router(
          title: 'Cool Store',
          debugShowCheckedModeBanner: false,
          theme: lightTheme(context),
          routerConfig: _appRouter.config()),
    );
  }
}
