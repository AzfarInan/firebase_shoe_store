import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_shoe_store/core/theme/app_colors.dart';
import 'package:firebase_shoe_store/core/theme/theme_data.dart';
import 'package:firebase_shoe_store/core/widgets/number_formats.dart';
import 'package:firebase_shoe_store/features/dashboard/presentation/widgets/primary_app_bar.dart';
import 'package:firebase_shoe_store/features/order/domain/entities/order_history.dart';
import 'package:flutter/material.dart';

class OrderDetailsScreen extends StatelessWidget {
  const OrderDetailsScreen({super.key, required this.orderHistory});

  final OrderHistory orderHistory;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryNeutral100,
      appBar: PrimaryAppBar(
        title: 'Order Details',
        centerTitle: true,
        titleStyle: themeData.textTheme.headlineLarge,
        showLeading: true,
        showCart: false,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        children: [
          buildSectionHeader(context, 'Information'),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              color: AppColors.primaryNeutral0,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: AppColors.primaryNeutral300,
                width: 1,
              ),
            ),
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                buildInfoRow(context, 'Order ID', orderHistory.id),
                buildInfoRow(
                  context,
                  'Order Date',
                  orderHistory.getFormattedDate(),
                ),
                buildInfoRow(context, 'Payment Method', 'Credit Card'),
                buildInfoRow(context, 'Location', 'Semarang, Indonesia'),
              ],
            ),
          ),
          buildOrderItems(context),
        ],
      ),
    );
  }

  Widget buildSectionHeader(BuildContext context, String title) {
    return Text(
      title,
      style: themeData.textTheme.headlineLarge!.copyWith(
        fontWeight: FontWeight.w600,
        color: AppColors.primaryNeutral500,
      ),
    );
  }

  Widget buildInfoRow(BuildContext context, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: themeData.textTheme.bodyMedium!.copyWith(
              fontWeight: FontWeight.w600,
              color: AppColors.primaryNeutral500,
            ),
          ),
          Text(
            value,
            style: themeData.textTheme.bodyMedium!.copyWith(
              color: AppColors.primaryNeutral400,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildOrderItems(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.primaryNeutral0,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.primaryNeutral300,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            itemCount: orderHistory.carts.length,
            itemBuilder: (context, index) {
              var cart = orderHistory.carts[index];

              return Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: AppColors.primaryNeutral0,
                      border: Border.all(
                        color: AppColors.primaryNeutral300,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.all(8),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        CachedNetworkImage(
                          imageUrl: cart.cartItem.getFirstImage(),
                          fit: BoxFit.contain,
                        ),
                        Positioned(
                          left: 0,
                          top: 0,
                          child: CachedNetworkImage(
                            imageUrl: cart.cartItem.brandLogo!,
                            width: 16,
                            height: 16,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          cart.cartItem.name!,
                          style: themeData.textTheme.headlineMedium!.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              cart.brandColorSize(context),
                              style: themeData.textTheme.bodySmall!.copyWith(
                                color: AppColors.primaryNeutral400,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            Image.asset(
                              'assets/images/empty_star.png',
                              width: 16,
                              height: 16,
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              formatCurrency(cart.total),
                              style: themeData.textTheme.bodyMedium!.copyWith(
                                color: AppColors.primaryNeutral900,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              'Qty: ${cart.quantity.toString()}',
                              style: themeData.textTheme.bodyMedium!.copyWith(
                                color: AppColors.primaryNeutral400,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
            separatorBuilder: (context, index) {
              return const SizedBox(height: 16);
            },
          ),
          Container(
            height: 1,
            width: double.infinity,
            color: AppColors.primaryNeutral200,
            margin: const EdgeInsets.only(bottom: 10, top: 10),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Sub Total:',
                style: themeData.textTheme.bodyMedium!.copyWith(
                  color: AppColors.primaryNeutral400,
                  fontWeight: FontWeight.w300,
                ),
              ),
              Text(
                orderHistory.getSubTotal(),
                style: themeData.textTheme.bodyMedium!.copyWith(
                  color: AppColors.primaryNeutral900,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Shipping Cost:',
                style: themeData.textTheme.bodyMedium!.copyWith(
                  color: AppColors.primaryNeutral400,
                  fontWeight: FontWeight.w300,
                ),
              ),
              Text(
                formatCurrency(20),
                style: themeData.textTheme.bodyMedium!.copyWith(
                  color: AppColors.primaryNeutral900,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          Container(
            height: 1,
            width: double.infinity,
            color: AppColors.primaryNeutral200,
            margin: const EdgeInsets.only(top: 10, bottom: 10),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Grand Total:',
                style: themeData.textTheme.bodyMedium!.copyWith(
                  color: AppColors.primaryNeutral400,
                  fontWeight: FontWeight.w300,
                ),
              ),
              Text(
                orderHistory.getTotal(),
                style: themeData.textTheme.bodyMedium!.copyWith(
                  color: AppColors.primaryNeutral900,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildDetailRow(
    BuildContext context,
    String label,
    String value, {
    TextStyle? style,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: themeData.textTheme.bodyMedium!.copyWith(
              color: AppColors.primaryNeutral400,
              fontWeight: FontWeight.w400,
            ),
          ),
          Text(
            value,
            style: style ??
                themeData.textTheme.bodyMedium!.copyWith(
                  color: AppColors.primaryNeutral500,
                  fontWeight: FontWeight.w600,
                ),
          ),
        ],
      ),
    );
  }
}
