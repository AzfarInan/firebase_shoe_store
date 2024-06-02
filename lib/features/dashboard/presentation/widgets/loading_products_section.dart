part of '../pages/dashboard_screen.dart';

class LoadingProductsSection extends StatelessWidget {
  const LoadingProductsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        color: AppColors.primaryNeutral0,
        child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 8,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 0.7,
          ),
          itemBuilder: (context, index) {
            return Container(
              color: AppColors.primaryNeutral0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Shimmer.fromColors(
                      baseColor: AppColors.primaryNeutral200,
                      highlightColor: AppColors.primaryNeutral100,
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.primaryNeutral100,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: AppColors.primaryNeutral300,
                            width: 1,
                          ),
                        ),
                        padding: const EdgeInsets.all(8),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              color: AppColors.primaryNeutral100,
                            ),
                            Positioned(
                              top: 8,
                              left: 0,
                              child: Container(
                                color: AppColors.primaryNeutral100,
                                height: 16,
                                width: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Shimmer.fromColors(
                    baseColor: AppColors.primaryNeutral200,
                    highlightColor: AppColors.primaryNeutral100,
                    child: Container(
                      color: AppColors.primaryNeutral100,
                      height: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Shimmer.fromColors(
                        baseColor: AppColors.primaryNeutral200,
                        highlightColor: AppColors.primaryNeutral100,
                        child: Image.asset(
                          'assets/images/star.png',
                          width: 14,
                          height: 14,
                          color: AppColors.primaryNeutral100,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Shimmer.fromColors(
                        baseColor: AppColors.primaryNeutral200,
                        highlightColor: AppColors.primaryNeutral100,
                        child: Container(
                          color: AppColors.primaryNeutral100,
                          height: 16,
                          width: 40,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Shimmer.fromColors(
                        baseColor: AppColors.primaryNeutral200,
                        highlightColor: AppColors.primaryNeutral100,
                        child: Container(
                          color: AppColors.primaryNeutral100,
                          height: 16,
                          width: 80,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Shimmer.fromColors(
                    baseColor: AppColors.primaryNeutral200,
                    highlightColor: AppColors.primaryNeutral100,
                    child: Container(
                      color: AppColors.primaryNeutral100,
                      height: 16,
                      width: 100,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
