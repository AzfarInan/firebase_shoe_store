part of '../pages/product_details_screen.dart';

class ReviewSection extends StatelessWidget {
  const ReviewSection({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Review (${product.reviews!.length})',
          style: themeData.textTheme.headlineLarge!.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 10),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: product.reviews!.length >= 3 ? 3 : product.reviews!.length,
          itemBuilder: (context, index) {
            final review = product.reviews![index];

            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundImage: CachedNetworkImageProvider(review.userImage),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        review.userName,
                        style: themeData.textTheme.bodyMedium!.copyWith(
                          color: AppColors.primaryNeutral600,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      RatingBar.builder(
                        ignoreGestures: true,
                        initialRating: double.parse(
                          review.rating.toStringAsFixed(2),
                        ),
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
                      const SizedBox(height: 8),
                      Text(
                        review.comment,
                        style: themeData.textTheme.bodySmall!.copyWith(
                          color: AppColors.primaryNeutral500,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  'Today',
                  style: themeData.textTheme.bodySmall!.copyWith(
                    color: AppColors.primaryNeutral300,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            );
          },
          separatorBuilder: (context, index) => const SizedBox(height: 30),
        ),
      ],
    );
  }
}
