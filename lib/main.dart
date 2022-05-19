import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:template_project/home_page.dart';

void main() {
  runApp(const _MyApp());
}

class _MyApp extends StatelessWidget {
  const _MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routeInformationParser: _goRoute.routeInformationParser,
      routerDelegate: _goRoute.routerDelegate,
    );
  }
}

GoRouter _goRoute = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      name: 'HomePage',
      builder: (context, state) => const HomePage(),
    )
  ],
);
