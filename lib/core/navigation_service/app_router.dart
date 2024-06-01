import 'package:firebase_shoe_store/core/globals/global_variables.dart';
import 'package:firebase_shoe_store/core/globals/route_names.dart';
import 'package:firebase_shoe_store/features/dashboard/presentation/pages/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  late final GoRouter router = GoRouter(
    navigatorKey: GlobalVariable.rootNavigatorKey,
    initialLocation: '/',
    routes: [
      GoRoute(
        name: RouteNames.dashboard,
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return const DashboardScreen();
        },
      ),
    ],
  );
}
