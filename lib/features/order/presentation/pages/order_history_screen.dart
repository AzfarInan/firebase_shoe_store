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
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.primaryNeutral0,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total: ${order.carts.length}',
                      style: themeData.textTheme.bodyMedium!.copyWith(
                        color: AppColors.primaryNeutral900,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'Date: ${order.createdAt}',
                      style: themeData.textTheme.bodyMedium!.copyWith(
                        color: AppColors.primaryNeutral900,
                        fontWeight: FontWeight.w600,
                      ),
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
