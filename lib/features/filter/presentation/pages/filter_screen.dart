import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_shoe_store/core/base/base_state.dart';
import 'package:firebase_shoe_store/core/theme/app_colors.dart';
import 'package:firebase_shoe_store/core/theme/theme_data.dart';
import 'package:firebase_shoe_store/core/widgets/button.dart';
import 'package:firebase_shoe_store/features/dashboard/domain/entities/brand_entity.dart';
import 'package:firebase_shoe_store/features/dashboard/presentation/manager/get_brands_cubit.dart';
import 'package:firebase_shoe_store/features/dashboard/presentation/widgets/primary_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part '../widgets/brand_section.dart';

class FilterScreen extends StatelessWidget {
  const FilterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryNeutral100,
      appBar: PrimaryAppBar(
        centerTitle: true,
        title: 'Filter',
        titleStyle: themeData.textTheme.headlineLarge,
        showLeading: true,
        showCart: false,
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              BrandSection(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 90,
        color: AppColors.primaryNeutral0,
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Button.outlined(
                label: 'RESET (4)',
                onPressed: () {
                  /// TODO: RESET logic
                },
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Button.filled(
                label: 'APPLY',
                onPressed: () {
                  /// TODO: Complete APPLY Logic
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
