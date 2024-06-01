part of '../pages/dashboard_screen.dart';

class BrandSection extends StatefulWidget {
  const BrandSection({super.key});

  @override
  State<BrandSection> createState() => _BrandSectionState();
}

class _BrandSectionState extends State<BrandSection> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    BlocProvider.of<GetBrandsCubit>(context).getBrands(firstTime: true);

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        BlocProvider.of<GetBrandsCubit>(context).getBrands();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetBrandsCubit, BaseState>(
      builder: (context, state) {
        var cubit = context.read<GetBrandsCubit>();
        return Container(
          height: 40,
          padding: const EdgeInsets.only(left: 16),
          child: Center(
            child: ListView.separated(
              controller: _scrollController,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: cubit.brands.length,
              itemBuilder: (BuildContext context, int index) {
                if (cubit.brands[index] == cubit.selectedBrand) {
                  return Text(
                    cubit.brands[index].name,
                    style: Theme.of(context).textTheme.headlineLarge,
                  );
                }

                return GestureDetector(
                  onTap: () {
                    cubit.selectBrand(cubit.brands[index].id);
                  },
                  child: Text(
                    cubit.brands[index].name,
                    style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                          color: AppColors.primaryNeutral400,
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
