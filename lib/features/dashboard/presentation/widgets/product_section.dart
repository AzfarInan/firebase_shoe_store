part of '../pages/dashboard_screen.dart';

class ProductSection extends StatefulWidget {
  const ProductSection({super.key});

  @override
  State<ProductSection> createState() => _ProductSectionState();
}

class _ProductSectionState extends State<ProductSection> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        BlocProvider.of<GetProductsCubit>(context).getProducts(
          brandId: BlocProvider.of<GetBrandsCubit>(context).selectedBrand!.id,
          gender:
              BlocProvider.of<ManageFilterCubit>(context).selectedGenderValue,
          color: BlocProvider.of<ManageFilterCubit>(context).selectedColorValue,
          minPrice: BlocProvider.of<ManageFilterCubit>(context).minPriceValue,
          maxPrice: BlocProvider.of<ManageFilterCubit>(context).maxPriceValue,
          sortBy: BlocProvider.of<ManageFilterCubit>(context)
              .selectedSortByeValue(),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<GetBrandsCubit, BaseState>(
      listener: (context, state) {
        if (state is SuccessState) {
          BlocProvider.of<GetProductsCubit>(context).getProducts(
            firstTime: true,
            brandId: BlocProvider.of<GetBrandsCubit>(context).selectedBrand!.id,
            gender:
                BlocProvider.of<ManageFilterCubit>(context).selectedGenderValue,
            color:
                BlocProvider.of<ManageFilterCubit>(context).selectedColorValue,
            minPrice: BlocProvider.of<ManageFilterCubit>(context).minPriceValue,
            maxPrice: BlocProvider.of<ManageFilterCubit>(context).maxPriceValue,
            sortBy: BlocProvider.of<ManageFilterCubit>(context)
                .selectedSortByeValue(),
          );
        }
      },
      child: BlocConsumer<GetProductsCubit, BaseState>(
        listener: (context, state) {
          if (state is ErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.data.toString()),
                backgroundColor: AppColors.error500,
              ),
            );
          }
        },
        builder: (context, state) {
          var cubit = BlocProvider.of<GetProductsCubit>(context);

          if (state is LoadingState) {
            return const LoadingProductsSection();
          }

          return Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              color: AppColors.primaryNeutral100,
              child: GridView.builder(
                controller: _scrollController,
                shrinkWrap: true,
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: cubit.products.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.7,
                ),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      context.pushNamed(
                        RouteNames.productDetails,
                        extra: cubit.products[index],
                      );
                    },
                    child: Container(
                      color: AppColors.primaryNeutral100,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppColors.primaryNeutral0,
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: AppColors.primaryNeutral300,
                                  width: 1,
                                ),
                              ),
                              padding: const EdgeInsets.all(8),
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  CachedNetworkImage(
                                    imageUrl:
                                        cubit.products[index].getFirstImage(),
                                    fit: BoxFit.contain,
                                    errorWidget: (context, url, error) =>
                                        const Icon(
                                      Icons.image,
                                    ),
                                  ),
                                  Positioned(
                                    top: 8,
                                    left: 8,
                                    child: SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CachedNetworkImage(
                                        imageUrl:
                                            cubit.products[index].brandLogo!,
                                        color: AppColors.primaryNeutral500,
                                        fit: BoxFit.contain,
                                        errorWidget: (context, url, error) =>
                                            const Icon(
                                          Icons.image,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            cubit.products[index].name!,
                            style: themeData.textTheme.bodyMedium,
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Image.asset(
                                'assets/images/star.png',
                                width: 14,
                                height: 14,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                cubit.products[index].ratings.toString(),
                                style: themeData.textTheme.bodySmall,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '(${cubit.products[index].reviews!.length} Reviews)',
                                style: themeData.textTheme.bodySmall!.copyWith(
                                  color: AppColors.primaryNeutral400,
                                  fontWeight: FontWeight.w200,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            '\$${cubit.products[index].price?.toInt().toString()},00',
                            style: themeData.textTheme.bodyMedium!.copyWith(
                              color: AppColors.primaryNeutral900,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
