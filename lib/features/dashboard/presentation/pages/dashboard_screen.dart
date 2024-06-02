import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_shoe_store/core/base/presentation/base_state.dart';
import 'package:firebase_shoe_store/core/theme/app_colors.dart';
import 'package:firebase_shoe_store/core/theme/theme_data.dart';
import 'package:firebase_shoe_store/features/dashboard/presentation/manager/get_brands_cubit.dart';
import 'package:firebase_shoe_store/features/dashboard/presentation/widgets/primary_app_bar.dart';
import 'package:firebase_shoe_store/features/product_details/presentation/manager/get_products_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryNeutral0,
      appBar: const PrimaryAppBar(),
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
            return Flexible(
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.primaryNeutral900,
                  borderRadius: BorderRadius.circular(20),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(
                      height: 22,
                      width: 22,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(
                            AppColors.primaryNeutral0),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      'Loading More Products',
                      style: themeData.textTheme.bodySmall!.copyWith(
                        fontWeight: FontWeight.w300,
                        color: AppColors.primaryNeutral0,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}
