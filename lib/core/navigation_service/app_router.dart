import 'package:firebase_shoe_store/core/globals/global_variables.dart';
import 'package:firebase_shoe_store/core/globals/route_names.dart';
import 'package:firebase_shoe_store/features/dashboard/presentation/pages/dashboard_screen.dart';
import 'package:firebase_shoe_store/features/product_details/domain/entities/product.dart';
import 'package:firebase_shoe_store/features/product_details/presentation/pages/product_details_screen.dart';
import 'package:firebase_shoe_store/features/reviews/presentation/pages/review_screen.dart';
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
        routes: [
          GoRoute(
            name: RouteNames.productDetails,
            path: RouteNames.productDetails,
            builder: (BuildContext context, GoRouterState state) {
              return ProductDetailsScreen(product: state.extra as Product);
            },
          ),
          GoRoute(
            name: RouteNames.reviews,
            path: RouteNames.reviews,
            builder: (BuildContext context, GoRouterState state) {
              return ReviewScreen(product: state.extra as Product);
            },
          ),
        ],
      ),
    ],
  );
}
