import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_shoe_store/core/base/base_state.dart';
import 'package:firebase_shoe_store/core/theme/app_colors.dart';
import 'package:firebase_shoe_store/core/theme/theme_data.dart';
import 'package:firebase_shoe_store/core/widgets/button.dart';
import 'package:firebase_shoe_store/features/dashboard/domain/entities/brand_entity.dart';
import 'package:firebase_shoe_store/features/dashboard/presentation/manager/get_brands_cubit.dart';
import 'package:firebase_shoe_store/features/dashboard/presentation/widgets/primary_app_bar.dart';
import 'package:firebase_shoe_store/features/filter/presentation/manager/manage_filter_cubit.dart';
import 'package:firebase_shoe_store/features/product_details/presentation/manager/get_products_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

part '../widgets/brand_section.dart';
part '../widgets/price_range_section.dart';
part '../widgets/sort_by_section.dart';
part '../widgets/gender_section.dart';
part '../widgets/color_section.dart';

class FilterScreen extends StatelessWidget {
  const FilterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryNeutral100,
      appBar: PrimaryAppBar(
        centerTitle: true,
        onBackButtonPressed: () {
          BlocProvider.of<ManageFilterCubit>(context).reset();
          Navigator.of(context).pop();
        },
        title: 'Filter',
        titleStyle: themeData.textTheme.headlineLarge,
        showLeading: true,
        showCart: false,
      ),
      body: const SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BrandSection(),
            PriceRangeSection(),
            SortBySection(),
            GenderSection(),
            ColorSection(),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 90,
        color: AppColors.primaryNeutral0,
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            BlocBuilder<ManageFilterCubit, BaseState>(
              builder: (context, state) {
                var cubit = context.read<ManageFilterCubit>();

                if (cubit.filters.isEmpty) {
                  return Expanded(
                    child: Button.outlined(
                      label: 'RESET',
                      onPressed: () {
                        cubit.reset();
                        context.pop();
                      },
                    ),
                  );
                }

                return Expanded(
                  child: Button.outlined(
                    label: 'RESET (${cubit.filters.length})',
                    onPressed: () {
                      cubit.reset();
                      context.pop();
                    },
                  ),
                );
              },
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Button.filled(
                label: 'APPLY',
                onPressed: () {
                  BlocProvider.of<GetProductsCubit>(context).getProducts(
                    firstTime: true,
                    brandId: BlocProvider.of<GetBrandsCubit>(context)
                        .selectedBrand!
                        .id,
                    gender: BlocProvider.of<ManageFilterCubit>(context)
                        .selectedGenderValue,
                    color: BlocProvider.of<ManageFilterCubit>(context)
                        .selectedColorValue,
                    minPrice: BlocProvider.of<ManageFilterCubit>(context)
                        .minPriceValue,
                    maxPrice: BlocProvider.of<ManageFilterCubit>(context)
                        .maxPriceValue,
                    sortBy: BlocProvider.of<ManageFilterCubit>(context)
                        .selectedSortByeValue(),
                  );

                  context.pop();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
