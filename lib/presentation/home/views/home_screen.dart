import 'package:auto_route/auto_route.dart';
import 'package:coolstore/app/app_router.gr.dart';
import 'package:coolstore/config/constants/app_assets.dart';
import 'package:coolstore/config/theme/theme_constants.dart';
import 'package:coolstore/presentation/auth/bloc/auth_bloc.dart';
import 'package:coolstore/presentation/cart/views/cart_screen.dart';
import 'package:coolstore/presentation/home/cubit/home_cubit.dart';
import 'package:coolstore/presentation/product/views/product_list_screen.dart';
import 'package:coolstore/presentation/wishlist/views/wish_list_screen.dart';
import 'package:coolstore/utils/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

@RoutePage()
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Dialogs().showInfoDialog(context, "Welcome back, Johnd", "successs",
          seconds: 15);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      const ProductListScreen(),
      WishListScreen(),
      CartScreen()
    ];

    void onItemTapped(int index) {
      context.read<HomeCubit>().setIndex(index);
    }

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.status == AuthStatus.unauth) {
          AutoRouter.of(context).pushAndPopUntil(WelcomeRoute(),
              predicate: (Route<dynamic> route) => false);
        }
      },
      child: BlocBuilder<HomeCubit, int>(
        builder: (context, selectedIndex) {
          return Scaffold(
            body: pages.elementAt(selectedIndex),
            bottomNavigationBar: BottomNavigationBar(
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                    icon: SvgPicture.asset(
                      AppAssets.home,
                      colorFilter: ColorFilter.mode(
                          selectedIndex == 0 ? primaryColor : Color(0xFFCBCBD4),
                          BlendMode.srcIn),
                    ),
                    label: 'Home'),
                BottomNavigationBarItem(
                    icon: SvgPicture.asset(
                      AppAssets.heartWhite,
                      colorFilter: ColorFilter.mode(
                          selectedIndex == 1 ? primaryColor : Color(0xFFCBCBD4),
                          BlendMode.srcIn),
                    ),
                    label: 'WishList'),
                BottomNavigationBarItem(
                    icon: SvgPicture.asset(AppAssets.cart,
                        colorFilter: ColorFilter.mode(
                            selectedIndex == 2
                                ? primaryColor
                                : Color(0xFFCBCBD4),
                            BlendMode.srcIn)),
                    label: 'Cart'),
              ],
              currentIndex: selectedIndex,
              onTap: onItemTapped,
            ),
          );
        },
      ),
    );
  }
}
