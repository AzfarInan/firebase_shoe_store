part of '../pages/filter_screen.dart';

class BrandSection extends StatelessWidget {
  const BrandSection({super.key});

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Brands',
          style: themeData.textTheme.headlineMedium!.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 10),
        BlocBuilder<GetBrandsCubit, BaseState>(
          builder: (context, state) {
            var cubit = context.read<GetBrandsCubit>();

            if (state is SuccessState) {
              return Container(
                height: 100,
                padding: const EdgeInsets.only(left: 10),
                child: ListView.builder(
                  controller: scrollController,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: cubit.brands.length,
                  itemBuilder: (BuildContext context, int index) {
                    if (cubit.brands[index].name != 'All') {
                      if (cubit.brands[index] == cubit.selectedBrand) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 22.0),
                          child: GestureDetector(
                            onTap: () {
                              cubit.selectBrand('All');
                            },
                            child: Stack(
                              children: [
                                BrandItem(brand: cubit.brands[index]),
                                const Positioned(
                                  top: 30,
                                  right: 0,
                                  child: CircleAvatar(
                                    radius: 10,
                                    backgroundColor:
                                        AppColors.primaryNeutral500,
                                    child: Icon(
                                      Icons.check_rounded,
                                      color: AppColors.primaryNeutral0,
                                      size: 14,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }

                      return Padding(
                        padding: const EdgeInsets.only(right: 22.0),
                        child: GestureDetector(
                          onTap: () {
                            cubit.selectBrand(cubit.brands[index].id);
                          },
                          child: BrandItem(brand: cubit.brands[index]),
                        ),
                      );
                    }

                    return const SizedBox();
                  },
                ),
              );
            }

            return const SizedBox();
          },
        ),
      ],
    );
  }
}

class BrandItem extends StatelessWidget {
  const BrandItem({super.key, required this.brand});

  final Brand brand;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 25,
          backgroundColor: AppColors.primaryNeutral200,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: CachedNetworkImage(
              imageUrl: brand.logo,
              errorWidget: (context, url, error) => const Icon(
                Icons.error,
                color: AppColors.primaryNeutral500,
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          brand.name,
          style: themeData.textTheme.bodyMedium!.copyWith(
            color: AppColors.primaryNeutral600,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          '${brand.products.length} Items',
          style: themeData.textTheme.bodySmall!.copyWith(
            color: AppColors.primaryNeutral300,
            fontWeight: FontWeight.w200,
          ),
        ),
      ],
    );
  }
}
