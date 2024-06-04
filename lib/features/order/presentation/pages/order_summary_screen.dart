import 'package:firebase_shoe_store/core/base/base_state.dart';
import 'package:firebase_shoe_store/core/theme/app_colors.dart';
import 'package:firebase_shoe_store/core/theme/theme_data.dart';
import 'package:firebase_shoe_store/core/widgets/button.dart';
import 'package:firebase_shoe_store/core/widgets/number_formats.dart';
import 'package:firebase_shoe_store/features/cart/presentation/manager/manage_cart_cubit.dart';
import 'package:firebase_shoe_store/features/dashboard/presentation/widgets/primary_app_bar.dart';
import 'package:firebase_shoe_store/features/order/presentation/manager/create_order_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class OrderSummaryScreen extends StatelessWidget {
  const OrderSummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<CreateOrderCubit, BaseState>(
      listener: (context, state) {
        if (state is SuccessState) {
          BlocProvider.of<ManageCartCubit>(context).resetCart();
          context
            ..pop()
            ..pop();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.data),
              backgroundColor: AppColors.success800,
            ),
          );
        } else if (state is ErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.data),
              backgroundColor: AppColors.primaryNeutral900,
            ),
          );
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.primaryNeutral100,
        appBar: PrimaryAppBar(
          title: 'Order Summary',
          centerTitle: true,
          titleStyle: themeData.textTheme.headlineLarge,
          showLeading: true,
          showCart: false,
        ),
        bottomNavigationBar: Container(
          height: 90,
          color: AppColors.primaryNeutral0,
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Grand Total',
                      style: themeData.textTheme.bodyMedium!.copyWith(
                        color: AppColors.primaryNeutral300,
                        fontWeight: FontWeight.w200,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      BlocProvider.of<ManageCartCubit>(context).getGrandTotal(),
                      style: themeData.textTheme.headlineLarge!.copyWith(
                        color: AppColors.primaryNeutral900,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 5),
                  ],
                ),
              ),
              Expanded(
                child: BlocBuilder<CreateOrderCubit, BaseState>(
                  builder: (context, state) {
                    return Button.filled(
                      label: 'PAYMENT',
                      isLoading: state is LoadingState,
                      onPressed: () {
                        context.read<CreateOrderCubit>().createOrder(
                              carts: context.read<ManageCartCubit>().cartItems,
                            );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          children: [
            buildSectionHeader(context, 'Information'),
            const SizedBox(height: 8),
            buildInfoRow(context, 'Payment Method', 'Credit Card'),
            buildInfoRow(context, 'Location', 'Semarang, Indonesia'),
            const SizedBox(height: 20),
            buildSectionHeader(context, 'Order Detail'),
            const SizedBox(height: 8),
            buildOrderItems(context),
          ],
        ),
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
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: themeData.textTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.primaryNeutral500,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                value,
                style: themeData.textTheme.bodyMedium!.copyWith(
                  color: AppColors.primaryNeutral400,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Container(
                height: 1,
                width: double.infinity,
                color: AppColors.primaryNeutral200,
                margin: const EdgeInsets.only(top: 10),
              ),
            ],
          ),
          const Positioned(
            right: 0,
            top: 10,
            child: Icon(
              Icons.arrow_forward_ios_rounded,
              color: AppColors.primaryNeutral300,
              size: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildOrderItems(BuildContext context) {
    return BlocBuilder<ManageCartCubit, BaseState>(
      builder: (context, state) {
        var cubit = context.read<ManageCartCubit>();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: cubit.cartItems.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        cubit.cartItems[index].cartItem.name!,
                        style: themeData.textTheme.bodyLarge!.copyWith(
                          color: AppColors.primaryNeutral500,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Text(
                            cubit.cartItems[index].brandColorQuantity(context),
                            style: themeData.textTheme.bodyMedium!.copyWith(
                              color: AppColors.primaryNeutral400,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            formatCurrency(cubit.cartItems[index].total),
                            style: themeData.textTheme.bodyMedium!.copyWith(
                              color: AppColors.primaryNeutral500,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            buildSectionHeader(context, 'Payment Detail'),
            const SizedBox(height: 20),
            buildDetailRow(context, 'Sub Total', cubit.getSubtotal()),
            buildDetailRow(context, 'Shipping', formatCurrency(20.00)),
            Container(
              height: 1,
              width: double.infinity,
              color: AppColors.primaryNeutral200,
              margin: const EdgeInsets.only(top: 10, bottom: 10),
            ),
            buildDetailRow(
              context,
              'Total Order',
              cubit.getGrandTotal(),
              style: themeData.textTheme.headlineMedium!.copyWith(
                color: AppColors.primaryNeutral500,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        );
      },
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
