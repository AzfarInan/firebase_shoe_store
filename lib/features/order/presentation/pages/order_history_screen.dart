import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_shoe_store/core/base/base_state.dart';
import 'package:firebase_shoe_store/core/theme/app_colors.dart';
import 'package:firebase_shoe_store/core/theme/theme_data.dart';
import 'package:firebase_shoe_store/features/dashboard/presentation/widgets/primary_app_bar.dart';
import 'package:firebase_shoe_store/features/order/presentation/manager/get_order_history_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderHistoryScreen extends StatefulWidget {
  const OrderHistoryScreen({super.key});

  @override
  State<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
  @override
  void initState() {
    super.initState();

    BlocProvider.of<GetOrderHistoryCubit>(context).getOrderHistory(
      firstTime: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryNeutral100,
      appBar: PrimaryAppBar(
        title: 'Order History',
        centerTitle: true,
        titleStyle: themeData.textTheme.headlineLarge,
        showLeading: true,
        showCart: false,
      ),
      body: BlocConsumer<GetOrderHistoryCubit, BaseState>(
        listener: (context, state) {
          if (state is ErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.data.toString()),
                backgroundColor: AppColors.error800,
              ),
            );
          }
        },
        builder: (context, state) {
          var cubit = context.read<GetOrderHistoryCubit>();

          if (state is LoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: cubit.list.length,
            itemBuilder: (context, index) {
              var order = cubit.list[index];

              return Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.primaryNeutral0,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: AppColors.primaryNeutral200,
                    width: 1,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Order: ${order.id.split('-').first}...',
                          style: themeData.textTheme.bodyMedium!.copyWith(
                            color: AppColors.primaryNeutral900,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              '(${order.carts.length} Items) ',
                              style: themeData.textTheme.bodyMedium!.copyWith(
                                color: AppColors.primaryNeutral400,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            Text(
                              order.getTotal(),
                              style: themeData.textTheme.bodyMedium!.copyWith(
                                color: AppColors.primaryNeutral900,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
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
                                imageUrl: cubit.list[index].getFirstImage(),
                                fit: BoxFit.contain,
                              ),
                              Positioned(
                                left: 0,
                                top: 0,
                                child: CachedNetworkImage(
                                  imageUrl: cubit.list[index].getFirstLogo(),
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
                                cubit.list[index].getFirstTitle(),
                                style: themeData.textTheme.headlineMedium!
                                    .copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                cubit.list[index]
                                    .getFirstBrandColorSize(context),
                                style: themeData.textTheme.bodySmall!.copyWith(
                                  color: AppColors.primaryNeutral400,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    cubit.list[index].getFirstTotal(),
                                    style: themeData.textTheme.bodyMedium!
                                        .copyWith(
                                      color: AppColors.primaryNeutral900,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    cubit.list[index].getFirstQuantity(),
                                    style: themeData.textTheme.bodyMedium!
                                        .copyWith(
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
                          'Order Date: ${order.getFormattedDate()}',
                          style: themeData.textTheme.bodyMedium!.copyWith(
                            color: AppColors.primaryNeutral400,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        Text(
                          'View All',
                          style: themeData.textTheme.bodyMedium!.copyWith(
                            color: AppColors.information500,
                            fontWeight: FontWeight.w600,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
