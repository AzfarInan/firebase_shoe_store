part of '../pages/filter_screen.dart';

class SortBySection extends StatefulWidget {
  const SortBySection({super.key});

  @override
  State<SortBySection> createState() => _SortBySectionState();
}

class _SortBySectionState extends State<SortBySection> {
  int? selectedSortBy;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 14),
          Text(
            'Sort By',
            style: themeData.textTheme.headlineMedium!.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 10),
          BlocBuilder<ManageFilterCubit, BaseState>(
            builder: (context, state) {
              var cubit = context.read<ManageFilterCubit>();

              return SizedBox(
                height: 50,
                child: ListView.separated(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: cubit.sortBye.length,
                  itemBuilder: (BuildContext context, int index) {
                    if (selectedSortBy != null && selectedSortBy == index) {
                      return Button(
                        label: cubit.sortBye[index],
                        onPressed: () {
                          setState(() {
                            selectedSortBy = null;
                            cubit.unSelectSortBy();
                          });
                        },
                      );
                    }

                    return Button.outlined(
                      label: cubit.sortBye[index],
                      onPressed: () {
                        setState(() {
                          selectedSortBy = index;
                          cubit.selectSortBy(selectedSortBy!);
                        });
                      },
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                      const SizedBox(width: 16),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
