part of '../pages/filter_screen.dart';

class ColorSection extends StatefulWidget {
  const ColorSection({super.key});

  @override
  State<ColorSection> createState() => _ColorSectionState();
}

class _ColorSectionState extends State<ColorSection> {
  @override
  void initState() {
    super.initState();

    selectedColor = context.read<ManageFilterCubit>().selectedColor;
  }

  int? selectedColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Color',
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
                  itemCount: cubit.colors.length,
                  itemBuilder: (BuildContext context, int index) {
                    if (selectedColor != null && selectedColor == index) {
                      return Button.outlined(
                        borderColor: AppColors.primaryNeutral500,
                        label: cubit.colors[index],
                        prefix: Icon(
                          getColor(index) == Colors.white
                              ? Icons.circle_outlined
                              : Icons.circle,
                          color: getColor(index) == Colors.white
                              ? AppColors.primaryNeutral300
                              : getColor(index),
                        ),
                        onPressed: () {
                          setState(() {
                            selectedColor = null;
                            cubit.unSelectColor();
                          });
                        },
                      );
                    }

                    return Button.outlined(
                      label: cubit.colors[index],
                      prefix: Icon(
                        getColor(index) == Colors.white
                            ? Icons.circle_outlined
                            : Icons.circle,
                        color: getColor(index) == Colors.white
                            ? AppColors.primaryNeutral300
                            : getColor(index),
                      ),
                      onPressed: () {
                        setState(() {
                          selectedColor = index;
                          cubit.selectColor(selectedColor!);
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

  Color getColor(int index) {
    switch (index) {
      case 0:
        return Colors.white;
      case 1:
        return Colors.black;
      case 2:
        return Colors.blue.shade800;
      case 3:
        return Colors.red.shade800;
      case 4:
        return Colors.green.shade800;
      case 5:
        return Colors.yellow.shade800;
      case 6:
        return Colors.purple.shade800;
      default:
        return Colors.white;
    }
  }
}
