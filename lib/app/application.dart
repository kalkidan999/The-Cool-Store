import 'package:coolstore/app/app_router.dart';
import 'package:flutter/material.dart';

import '../config/theme/theme_data.dart';

class Application extends StatefulWidget {
  const Application({super.key});

  @override
  State<Application> createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  final _appRouter = AppRouter();
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
        title: 'Cool Store',
        debugShowCheckedModeBanner: false,
        theme: lightTheme(context),
        routerConfig: _appRouter.config());
  }
}
