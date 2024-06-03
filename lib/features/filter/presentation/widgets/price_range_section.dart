part of '../pages/filter_screen.dart';

class PriceRangeSection extends StatefulWidget {
  const PriceRangeSection({super.key});

  @override
  State<PriceRangeSection> createState() => _PriceRangeSectionState();
}

class _PriceRangeSectionState extends State<PriceRangeSection> {
  @override
  void initState() {
    super.initState();

    _currentRangeValues =
        BlocProvider.of<ManageFilterCubit>(context).selectedRangeValue ??
            const RangeValues(0, 2000);
  }

  RangeValues? _currentRangeValues;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16.0, top: 14),
          child: Text(
            'Price Range',
            style: themeData.textTheme.headlineMedium!.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const SizedBox(height: 10),
        RangeSlider(
          values: _currentRangeValues!,
          min: 0,
          max: 2000,
          divisions: 100,
          activeColor: AppColors.primaryNeutral500,
          inactiveColor: AppColors.primaryNeutral200,
          labels: RangeLabels(
            '\$${_currentRangeValues!.start.round()}',
            '\$${_currentRangeValues!.end.round()}',
          ),
          onChanged: (RangeValues values) {
            setState(() {
              _currentRangeValues = values;
            });
            BlocProvider.of<ManageFilterCubit>(context)
                .updateRangeValues(_currentRangeValues!);
          },
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '\$0',
                style: themeData.textTheme.bodyMedium!.copyWith(
                  color: AppColors.primaryNeutral400,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                '\$2000',
                style: themeData.textTheme.bodyMedium!.copyWith(
                  color: AppColors.primaryNeutral400,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
