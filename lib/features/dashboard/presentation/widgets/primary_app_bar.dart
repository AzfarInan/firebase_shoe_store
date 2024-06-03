import 'package:firebase_shoe_store/core/base/base_state.dart';
import 'package:firebase_shoe_store/core/theme/app_colors.dart';
import 'package:firebase_shoe_store/core/theme/theme_data.dart';
import 'package:firebase_shoe_store/features/cart/presentation/manager/manage_cart_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PrimaryAppBar extends StatelessWidget implements PreferredSizeWidget {
  const PrimaryAppBar({
    super.key,
    required this.title,
    this.titleStyle,
    this.showLeading = false,
    this.showCart = true,
    this.actions,
    this.centerTitle = false,
    this.onBackButtonPressed,
  });

  final String title;
  final TextStyle? titleStyle;
  final bool showLeading;
  final bool showCart;
  final List<Widget>? actions;
  final bool centerTitle;
  final VoidCallback? onBackButtonPressed;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.primaryNeutral100,
      elevation: 0,
      surfaceTintColor: AppColors.primaryNeutral100,
      automaticallyImplyLeading: false,
      leading: showLeading
          ? GestureDetector(
              onTap: onBackButtonPressed ??
                  () {
                    Navigator.of(context).pop();
                  },
              child: const Icon(Icons.arrow_back),
            )
          : null,
      title: Text(
        title,
        style: titleStyle ?? themeData.textTheme.displayMedium,
      ),
      centerTitle: centerTitle,
      actions: actions ??
          [
            showCart
                ? BlocBuilder<ManageCartCubit, BaseState>(
                    builder: (context, state) {
                      var cubit = BlocProvider.of<ManageCartCubit>(context);
                      if (cubit.cartItems.isNotEmpty) {
                        return Stack(
                          children: [
                            GestureDetector(
                              child: Image.asset(
                                'assets/images/cart.png',
                                width: 24,
                                height: 24,
                              ),
                              onTap: () {
                                // TODO: Navigate to cart screen
                              },
                            ),
                            Positioned(
                              right: 0,
                              top: 0,
                              child: Image.asset(
                                'assets/images/red_dot.png',
                                width: 8,
                                height: 8,
                              ),
                            ),
                          ],
                        );
                      }

                      return GestureDetector(
                        child: Image.asset(
                          'assets/images/cart.png',
                          width: 24,
                          height: 24,
                        ),
                        onTap: () {
                          // TODO: Navigate to cart screen
                        },
                      );
                    },
                  )
                : const SizedBox(),
            const SizedBox(width: 16),
          ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
