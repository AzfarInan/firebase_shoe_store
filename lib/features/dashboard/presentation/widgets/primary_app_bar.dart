import 'package:firebase_shoe_store/core/theme/app_colors.dart';
import 'package:firebase_shoe_store/core/theme/theme_data.dart';
import 'package:flutter/material.dart';

class PrimaryAppBar extends StatelessWidget implements PreferredSizeWidget {
  const PrimaryAppBar({
    super.key,
    required this.title,
    this.titleStyle,
    this.showLeading = false,
    this.showCart = true,
  });

  final String title;
  final TextStyle? titleStyle;
  final bool showLeading;
  final bool showCart;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.primaryNeutral100,
      elevation: 0,
      surfaceTintColor: AppColors.primaryNeutral100,
      automaticallyImplyLeading: false,
      leading: showLeading
          ? GestureDetector(
              child: const Icon(Icons.arrow_back),
              onTap: () {
                Navigator.of(context).pop();
              },
            )
          : null,
      title: Text(
        title,
        style: titleStyle ?? themeData.textTheme.displayMedium,
      ),
      centerTitle: false,
      actions: [
        showCart
            ? GestureDetector(
                child: Image.asset(
                  'assets/images/cart.png',
                  width: 24,
                  height: 24,
                ),
                onTap: () {
                  // TODO: Navigate to cart screen
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
