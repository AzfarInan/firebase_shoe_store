import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_shoe_store/core/theme/app_colors.dart';
import 'package:firebase_shoe_store/core/theme/theme_data.dart';
import 'package:firebase_shoe_store/core/widgets/button.dart';
import 'package:firebase_shoe_store/features/dashboard/presentation/widgets/primary_app_bar.dart';
import 'package:firebase_shoe_store/features/product_details/domain/entities/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

part '../widgets/image_section.dart';
part '../widgets/size_section.dart';
part '../widgets/review_section.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryNeutral100,
      appBar: const PrimaryAppBar(title: '', showLeading: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 315,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.primaryNeutral0,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: AppColors.primaryNeutral300,
                    width: 1,
                  ),
                ),
                padding: const EdgeInsets.all(16),
                child: ImageSection(product: product),
              ),
              const SizedBox(height: 30),
              Text(
                product.name!,
                style: themeData.textTheme.displaySmall!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryNeutral600,
                ),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  RatingBar.builder(
                    ignoreGestures: true,
                    initialRating: product.ratings!,
                    minRating: 0,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemPadding: const EdgeInsets.only(right: 0),
                    itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: AppColors.warning500,
                    ),
                    onRatingUpdate: (rating) {},
                    unratedColor: AppColors.primaryNeutral200,
                    itemSize: 16,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '${product.ratings}',
                    style: themeData.textTheme.bodyMedium!.copyWith(
                      color: AppColors.primaryNeutral500,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '(${product.reviews!.length} Reviews)',
                    style: themeData.textTheme.bodyMedium!.copyWith(
                      color: AppColors.primaryNeutral300,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              SizeSection(product: product),
              const SizedBox(height: 30),
              Text(
                'Description',
                style: themeData.textTheme.headlineLarge!.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                product.description!,
                style: themeData.textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.w400,
                  color: AppColors.primaryNeutral400,
                ),
              ),
              const SizedBox(height: 30),
              ReviewSection(product: product),
              const SizedBox(height: 30),
              Button.outlined(
                label: 'SEE ALL REVIEW',
                onPressed: () {},
              ),
              const SizedBox(height: 30),
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Price',
                    style: themeData.textTheme.bodyMedium!.copyWith(
                      color: AppColors.primaryNeutral300,
                      fontWeight: FontWeight.w200,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    '\$${product.price!.toStringAsFixed(2)}',
                    style: themeData.textTheme.headlineLarge!.copyWith(
                      color: AppColors.primaryNeutral900,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Button.filled(
                label: 'ADD TO CART',
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
