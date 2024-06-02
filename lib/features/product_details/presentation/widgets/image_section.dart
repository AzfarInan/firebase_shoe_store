part of '../pages/product_details_screen.dart';

class ImageSection extends StatefulWidget {
  const ImageSection({super.key, required this.product});

  final Product product;

  @override
  State<ImageSection> createState() => _ImageSectionState();
}

class _ImageSectionState extends State<ImageSection> {
  int currentIndex = 0;
  int selectedColorIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Positioned.fill(
          child: CarouselSlider.builder(
            itemCount: widget.product.images!.length,
            options: CarouselOptions(
              aspectRatio: 16 / 9,
              autoPlay: false,
              enlargeCenterPage: true,
              viewportFraction: 1,
              enableInfiniteScroll: false,
              onPageChanged: (index, reason) {
                setState(() {
                  currentIndex = index;
                });
              },
            ),
            itemBuilder: (BuildContext context, int index, int realIndex) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: CachedNetworkImage(
                  imageUrl: widget.product.images![index],
                  fit: BoxFit.cover,
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      Center(
                    child: CircularProgressIndicator(
                      value: downloadProgress.progress,
                      valueColor: const AlwaysStoppedAnimation<Color>(
                        AppColors.primaryNeutral300,
                      ),
                    ),
                  ),
                  errorWidget: (context, url, error) => const Icon(
                    Icons.image,
                    color: Colors.grey,
                  ),
                ),
              );
            },
          ),
        ),
        Positioned(
          bottom: 8,
          left: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              widget.product.images!.length,
              (index) {
                return Container(
                  width: 7.0,
                  height: 7.0,
                  margin: const EdgeInsets.symmetric(horizontal: 5.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: currentIndex == index
                        ? AppColors.primaryNeutral500
                        : AppColors.primaryNeutral300,
                  ),
                );
              },
            ),
          ),
        ),
        Positioned(
          top: 8,
          left: 0,
          child: SizedBox(
            height: 30,
            width: 30,
            child: CachedNetworkImage(
              imageUrl: widget.product.brandLogo!,
              color: AppColors.primaryNeutral500,
              fit: BoxFit.contain,
              errorWidget: (context, url, error) => const Icon(
                Icons.image,
              ),
            ),
          ),
        ),
        Positioned(
          right: 0,
          bottom: 0,
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.primaryNeutral200,
              borderRadius: BorderRadius.circular(30),
            ),
            height: 40,
            padding: const EdgeInsets.symmetric(horizontal: 11),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                widget.product.colors!.length,
                (index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedColorIndex = index;
                      });
                    },
                    child: Container(
                      width: 20.0,
                      height: 20.0,
                      margin: const EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: widget.product.getColor(index),
                        border: Border.all(
                          color: AppColors.primaryNeutral300,
                          width: 1,
                        ),
                      ),
                      child: selectedColorIndex == index
                          ? Icon(
                              Icons.check,
                              color: widget.product.getIconColor(index),
                              size: 14,
                            )
                          : null,
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
