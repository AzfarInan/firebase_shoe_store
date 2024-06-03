import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_shoe_store/core/base/base_state.dart';
import 'package:firebase_shoe_store/core/globals/route_names.dart';
import 'package:firebase_shoe_store/core/theme/app_colors.dart';
import 'package:firebase_shoe_store/core/theme/theme_data.dart';
import 'package:firebase_shoe_store/features/cart/presentation/manager/manage_cart_cubit.dart';
import 'package:firebase_shoe_store/features/dashboard/presentation/manager/get_brands_cubit.dart';
import 'package:firebase_shoe_store/features/dashboard/presentation/widgets/primary_app_bar.dart';
import 'package:firebase_shoe_store/features/product_details/presentation/manager/get_products_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';

part '../widgets/brand_section.dart';

part '../widgets/product_section.dart';

part '../widgets/loading_products_section.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    super.initState();

    BlocProvider.of<ManageCartCubit>(context).getItemsFromCache();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ManageCartCubit, BaseState>(
      listener: (context, state) {
        if (state is SuccessState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.data.toString(),
                style: themeData.textTheme.bodyMedium!.copyWith(
                  color: AppColors.primaryNeutral0,
                  fontWeight: FontWeight.w300,
                ),
              ),
              backgroundColor: AppColors.success900,
            ),
          );
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.primaryNeutral100,
        appBar: const PrimaryAppBar(title: 'Discover'),
        body: const Column(
          children: [
            BrandSection(),
            ProductSection(),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: BlocBuilder<GetProductsCubit, BaseState>(
          builder: (context, state) {
            if (state is LoadingAgainState) {
              return Container(
                decoration: BoxDecoration(
                  color: AppColors.primaryNeutral900,
                  borderRadius: BorderRadius.circular(20),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(
                            AppColors.primaryNeutral0),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Text(
                      'LOADING',
                      style: themeData.textTheme.bodySmall!.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.primaryNeutral0,
                      ),
                    ),
                  ],
                ),
              );
            }

            return GestureDetector(
              onTap: () {
                context.pushNamed(RouteNames.filter);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.primaryNeutral900,
                  borderRadius: BorderRadius.circular(20),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: 22,
                      width: 22,
                      child: Image.asset(
                        'assets/images/filter.png',
                        color: AppColors.primaryNeutral0,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Text(
                      'FILTER',
                      style: themeData.textTheme.bodySmall!.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.primaryNeutral0,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
