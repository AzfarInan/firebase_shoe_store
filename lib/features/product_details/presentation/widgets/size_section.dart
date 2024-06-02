part of '../pages/product_details_screen.dart';

class SizeSection extends StatefulWidget {
  const SizeSection({super.key, required this.product});

  final Product product;

  @override
  State<SizeSection> createState() => _SizeSectionState();
}

class _SizeSectionState extends State<SizeSection> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Size',
          style: themeData.textTheme.headlineLarge!.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 40,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final size = widget.product.sizes![index];

              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedIndex = index;
                  });
                },
                child: Container(
                  height: 40,
                  width: 40,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: selectedIndex == index
                        ? AppColors.primaryNeutral500
                        : AppColors.primaryNeutral0,
                    border: Border.all(
                      color: AppColors.primaryNeutral200,
                      width: 1,
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    size.toString(),
                    style: themeData.textTheme.bodySmall!.copyWith(
                      color: selectedIndex == index
                          ? AppColors.primaryNeutral0
                          : AppColors.primaryNeutral400,
                    ),
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) => const SizedBox(width: 15),
            itemCount: widget.product.sizes!.length,
          ),
        ),
      ],
    );
  }
}
