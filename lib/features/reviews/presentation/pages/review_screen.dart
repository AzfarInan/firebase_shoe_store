import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_shoe_store/core/base/base_state.dart';
import 'package:firebase_shoe_store/core/theme/app_colors.dart';
import 'package:firebase_shoe_store/core/theme/theme_data.dart';
import 'package:firebase_shoe_store/features/dashboard/presentation/widgets/primary_app_bar.dart';
import 'package:firebase_shoe_store/features/product_details/domain/entities/product.dart';
import 'package:firebase_shoe_store/features/reviews/presentation/manager/manage_review_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

part '../widgets/stars_section.dart';
part '../widgets/review_section.dart';

class ReviewScreen extends StatelessWidget {
  const ReviewScreen({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryNeutral100,
      appBar: PrimaryAppBar(
        title: 'Review (${product.reviews!.length})',
        titleStyle: themeData.textTheme.headlineLarge,
        centerTitle: true,
        showLeading: true,
        actions: [
          RatingBar.builder(
            ignoreGestures: true,
            initialRating: product.ratings!,
            minRating: 0,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemCount: 1,
            itemPadding: const EdgeInsets.only(right: 0),
            itemBuilder: (context, _) => const Icon(
              Icons.star,
              color: AppColors.warning500,
            ),
            onRatingUpdate: (rating) {},
            unratedColor: AppColors.primaryNeutral200,
            itemSize: 24,
          ),
          const SizedBox(width: 4),
          Text(
            '${product.ratings}',
            style: themeData.textTheme.bodyLarge!.copyWith(
              color: AppColors.primaryNeutral500,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 16),
          StarsSection(product: product),
          const SizedBox(height: 30),
          ReviewSection(product: product),
        ],
      ),
    );
  }
}
