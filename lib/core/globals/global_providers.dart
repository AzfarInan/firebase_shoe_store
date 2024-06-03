import 'package:firebase_shoe_store/core/service_locator/service_locator.dart';
import 'package:firebase_shoe_store/features/cart/presentation/manager/manage_cart_cubit.dart';
import 'package:firebase_shoe_store/features/dashboard/presentation/manager/get_brands_cubit.dart';
import 'package:firebase_shoe_store/features/product_details/presentation/manager/get_products_cubit.dart';
import 'package:firebase_shoe_store/features/product_details/presentation/manager/manage_product_cubit.dart';
import 'package:firebase_shoe_store/features/reviews/presentation/manager/manage_review_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GlobalBlocProviders {
  dynamic providers = [
    BlocProvider(create: (_) => getIt<GetBrandsCubit>()),
    BlocProvider(create: (_) => getIt<GetProductsCubit>()),
    BlocProvider(create: (_) => getIt<ManageReviewCubit>()),
    BlocProvider(create: (_) => getIt<ManageProductCubit>()),
    BlocProvider(create: (_) => getIt<ManageCartCubit>()),
  ];
}
