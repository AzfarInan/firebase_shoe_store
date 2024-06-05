part of '../pages/order_details_screen.dart';

class AddReviewBottomSheet extends StatefulWidget {
  const AddReviewBottomSheet({super.key, required this.productId});

  final String productId;

  @override
  State<AddReviewBottomSheet> createState() => _AddReviewBottomSheetState();
}

class _AddReviewBottomSheetState extends State<AddReviewBottomSheet> {
  final TextEditingController _reviewController = TextEditingController();
  double myRating = 0;

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Container(
      padding: EdgeInsets.only(bottom: bottomInset),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Center(
                child: Container(
                  height: 4,
                  width: 40,
                  decoration: BoxDecoration(
                    color: AppColors.primaryNeutral200,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Leave a Review',
                    style: themeData.textTheme.headlineLarge!.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
              const SizedBox(height: 30.0),
              Text(
                'What do you think about this product?',
                style: themeData.textTheme.headlineMedium!.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 10.0),
              Center(
                child: RatingBar.builder(
                  initialRating: 0,
                  minRating: 0,
                  direction: Axis.horizontal,
                  allowHalfRating: false,
                  itemCount: 5,
                  itemPadding: const EdgeInsets.only(right: 0),
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: AppColors.warning500,
                  ),
                  onRatingUpdate: (rating) {
                    myRating = rating;
                  },
                  unratedColor: AppColors.primaryNeutral200,
                  itemSize: 40,
                ),
              ),
              const SizedBox(height: 10.0),
              TextField(
                controller: _reviewController,
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: 'Write your review here...',
                  hintStyle: themeData.textTheme.bodyMedium!.copyWith(
                    color: AppColors.primaryNeutral300,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      color: AppColors.primaryNeutral200,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      color: AppColors.primaryNeutral200,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Button(
                    label: 'SUBMIT',
                    width: 160,
                    onPressed: () {
                      BlocProvider.of<CreateReviewCubit>(context).createReview(
                        request: CreateReviewRequest(
                          productId: widget.productId,
                          comment: _reviewController.text,
                          rating: myRating.toInt(),
                          userImage:
                              "https://firebasestorage.googleapis.com/v0/b/fir-shoe-store-ad351.appspot.com/o/324887.jpg?alt=media&token=44741a3d-6d34-4e97-a972-a5c0500edd23",
                          userName: "The Joker",
                          createdAt: Timestamp.now(),
                        ),
                      );
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
