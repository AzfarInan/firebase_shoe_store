part of '../pages/filter_screen.dart';

class GenderSection extends StatefulWidget {
  const GenderSection({super.key});

  @override
  State<GenderSection> createState() => _GenderSectionState();
}

class _GenderSectionState extends State<GenderSection> {
  int? selectedGender;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Gender',
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
                  itemCount: cubit.genders.length,
                  itemBuilder: (BuildContext context, int index) {
                    if (selectedGender != null && selectedGender == index) {
                      return Button(
                        label: cubit.genders[index],
                        onPressed: () {
                          setState(() {
                            selectedGender = null;
                            cubit.unSelectGender();
                          });
                        },
                      );
                    }

                    return Button.outlined(
                      label: cubit.genders[index],
                      onPressed: () {
                        setState(() {
                          selectedGender = index;
                          cubit.selectGender(selectedGender!);
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
