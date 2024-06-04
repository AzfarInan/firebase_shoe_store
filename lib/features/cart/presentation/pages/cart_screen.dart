import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_shoe_store/core/base/base_state.dart';
import 'package:firebase_shoe_store/core/globals/route_names.dart';
import 'package:firebase_shoe_store/core/theme/app_colors.dart';
import 'package:firebase_shoe_store/core/theme/theme_data.dart';
import 'package:firebase_shoe_store/core/widgets/button.dart';
import 'package:firebase_shoe_store/core/widgets/number_formats.dart';
import 'package:firebase_shoe_store/features/cart/domain/entities/cart.dart';
import 'package:firebase_shoe_store/features/cart/presentation/manager/manage_cart_cubit.dart';
import 'package:firebase_shoe_store/features/dashboard/presentation/widgets/primary_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:go_router/go_router.dart';

part '../widgets/quantity_and_total.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryNeutral100,
      appBar: PrimaryAppBar(
        centerTitle: true,
        title: 'Cart',
        titleStyle: themeData.textTheme.headlineLarge,
        showLeading: true,
        showCart: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: BlocBuilder<ManageCartCubit, BaseState>(
          builder: (context, state) {
            var cubit = BlocProvider.of<ManageCartCubit>(context);

            if (cubit.cartItems.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(height: 100),
                    Image.asset(
                      'assets/images/cart.png',
                      width: 200,
                      height: 200,
                      color: AppColors.primaryNeutral400,
                    ),
                    Text(
                      'Your cart is empty',
                      style: themeData.textTheme.headlineLarge!.copyWith(
                        fontWeight: FontWeight.w400,
                        color: AppColors.primaryNeutral400,
                      ),
                    ),
                  ],
                ),
              );
            }

            return ListView.separated(
              shrinkWrap: true,
              physics: const AlwaysScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Slidable(
                  endActionPane: ActionPane(
                    motion: const ScrollMotion(),
                    extentRatio: 0.25,
                    children: [
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.only(left: 10),
                          height: double.infinity,
                          padding: const EdgeInsets.all(25),
                          decoration: const BoxDecoration(
                            color: AppColors.error600,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              bottomLeft: Radius.circular(20),
                            ),
                          ),
                          child: GestureDetector(
                            onTap: () {
                              cubit.removeFromCart(cubit.cartItems[index]);
                            },
                            child: Image.asset(
                              'assets/images/trash.png',
                              width: 24,
                              height: 24,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 100,
                        height: 100,
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
                              imageUrl:
                                  cubit.cartItems[index].cartItem.images!.first,
                              fit: BoxFit.contain,
                            ),
                            Positioned(
                              left: 0,
                              top: 0,
                              child: CachedNetworkImage(
                                imageUrl:
                                    cubit.cartItems[index].cartItem.brandLogo!,
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
                              cubit.cartItems[index].cartItem.name!,
                              style:
                                  themeData.textTheme.headlineMedium!.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              cubit.cartItems[index]
                                  .brandColorSize(context),
                              style: themeData.textTheme.bodySmall!.copyWith(
                                color: AppColors.primaryNeutral400,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            const SizedBox(height: 10),
                            QuantityAndTotal(cart: cubit.cartItems[index]),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(height: 30);
              },
              itemCount: cubit.cartItems.length,
            );
          },
        ),
      ),
      bottomNavigationBar: Container(
        height: 90,
        color: AppColors.primaryNeutral0,
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        child: Button.filled(
          label: 'CHECKOUT',
          onPressed: () {
            if (BlocProvider.of<ManageCartCubit>(context)
                .cartItems
                .isNotEmpty) {
              context.pushNamed(RouteNames.checkout);
            }
          },
        ),
      ),
    );
  }
}
