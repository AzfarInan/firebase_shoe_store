part of '../pages/product_details_screen.dart';

class AddToCartSuccessBottomSheet extends StatelessWidget {
  const AddToCartSuccessBottomSheet({super.key, required this.quantity});

  final int quantity;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(top: 20.0),
                padding: const EdgeInsets.all(24.0),
                height: 85,
                width: 85,
                decoration: BoxDecoration(
                  color: AppColors.primaryNeutral0,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.primaryNeutral500,
                    width: 2,
                  ),
                ),
                child: Image.asset('assets/images/check_mark.png'),
              ),
              const SizedBox(height: 30.0),
              Text(
                'Added to cart',
                style: themeData.textTheme.displaySmall!.copyWith(
                  fontWeight: FontWeight.w500,
                  color: AppColors.primaryNeutral600,
                ),
              ),
              const SizedBox(height: 8.0),
              Text(
                '$quantity Item Total',
                style: themeData.textTheme.bodyMedium!.copyWith(
                  color: AppColors.primaryNeutral400,
                ),
              ),
              const SizedBox(height: 24.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Button.outlined(
                    width: double.infinity,
                    onPressed: () {
                      Navigator.pop(context); // Close the previous bottom sheet
                    },
                    label: 'BACK EXPLORE',
                  ),
                  const SizedBox(width: 16.0),
                  Expanded(
                    child: Button(
                      onPressed: () {
                        context
                          ..pop()
                          ..pushNamed(RouteNames.cart);
                      },
                      label: 'TO CART',
                    ),
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
