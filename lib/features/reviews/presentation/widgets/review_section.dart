part of '../pages/review_screen.dart';

class ReviewSection extends StatefulWidget {
  const ReviewSection({super.key, required this.product});

  final Product product;

  @override
  State<ReviewSection> createState() => _ReviewSectionState();
}

class _ReviewSectionState extends State<ReviewSection> {
  @override
  void initState() {
    super.initState();

    BlocProvider.of<ManageReviewCubit>(context)
        .getInitialReviews(widget.product.reviews!);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ManageReviewCubit, BaseState>(
      builder: (context, state) {
        var cubit = context.read<ManageReviewCubit>();

        if (cubit.reviewList.isEmpty) {
          return Expanded(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 60.0),
                child: Text(
                  'No reviews yet',
                  style: themeData.textTheme.bodyLarge!.copyWith(
                    color: AppColors.primaryNeutral300,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          );
        }

        return Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ListView.separated(
              shrinkWrap: true,
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: cubit.reviewList.length,
              itemBuilder: (context, index) {
                final review = cubit.reviewList[index];

                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 24,
                      backgroundImage:
                          CachedNetworkImageProvider(review.userImage),
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
          ),
        );
      },
    );
  }
}
