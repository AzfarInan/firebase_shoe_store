part of '../pages/review_screen.dart';

class StarsSection extends StatelessWidget {
  const StarsSection({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ManageReviewCubit, BaseState>(
      builder: (context, state) {
        var cubit = context.read<ManageReviewCubit>();

        return Container(
          height: 40,
          padding: const EdgeInsets.only(left: 16),
          child: Center(
            child: ListView.separated(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: cubit.stars.length,
              itemBuilder: (BuildContext context, int index) {
                if (cubit.stars[index] == cubit.selectedStar) {
                  return Text(
                    cubit.stars[index],
                    style: themeData.textTheme.headlineLarge,
                  );
                }

                return GestureDetector(
                  onTap: () {
                    cubit.selectStar(cubit.stars[index], product.reviews!);
                  },
                  child: Text(
                    cubit.stars[index],
                    style: themeData.textTheme.headlineLarge!.copyWith(
                      color: AppColors.primaryNeutral300,
                    ),
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(width: 16);
              },
            ),
          ),
        );
      },
    );
  }
}
