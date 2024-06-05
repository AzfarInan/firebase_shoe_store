import 'package:firebase_shoe_store/core/globals/global_variables.dart';
import 'package:firebase_shoe_store/core/globals/route_names.dart';
import 'package:firebase_shoe_store/features/cart/presentation/pages/cart_screen.dart';
import 'package:firebase_shoe_store/features/dashboard/presentation/pages/dashboard_screen.dart';
import 'package:firebase_shoe_store/features/filter/presentation/pages/filter_screen.dart';
import 'package:firebase_shoe_store/features/order/domain/entities/order_history.dart';
import 'package:firebase_shoe_store/features/order/presentation/pages/order_details_screen.dart';
import 'package:firebase_shoe_store/features/order/presentation/pages/order_history_screen.dart';
import 'package:firebase_shoe_store/features/order/presentation/pages/order_summary_screen.dart';
import 'package:firebase_shoe_store/features/product/domain/entities/product.dart';
import 'package:firebase_shoe_store/features/product/presentation/pages/product_details_screen.dart';
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
          GoRoute(
            name: RouteNames.filter,
            path: RouteNames.filter,
            builder: (BuildContext context, GoRouterState state) {
              return const FilterScreen();
            },
          ),
          GoRoute(
            name: RouteNames.cart,
            path: RouteNames.cart,
            builder: (BuildContext context, GoRouterState state) {
              return const CartScreen();
            },
          ),
          GoRoute(
            name: RouteNames.checkout,
            path: RouteNames.checkout,
            builder: (BuildContext context, GoRouterState state) {
              return const OrderSummaryScreen();
            },
          ),
          GoRoute(
            name: RouteNames.orderHistory,
            path: RouteNames.orderHistory,
            builder: (BuildContext context, GoRouterState state) {
              return const OrderHistoryScreen();
            },
          ),
          GoRoute(
            name: RouteNames.orderDetails,
            path: RouteNames.orderDetails,
            builder: (BuildContext context, GoRouterState state) {
              return OrderDetailsScreen(
                orderHistory: state.extra as OrderHistory,
              );
            },
          ),
        ],
      ),
    ],
  );
}
