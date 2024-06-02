import 'package:firebase_shoe_store/core/theme/theme_data.dart';
import 'package:flutter/material.dart';

class PrimaryAppBar extends StatelessWidget implements PreferredSizeWidget {
  const PrimaryAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: themeData.scaffoldBackgroundColor,
      automaticallyImplyLeading: false,
      title: Text(
        'Discover',
        style: themeData.textTheme.displayMedium,
      ),
      centerTitle: false,
      actions: [
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
        const SizedBox(width: 16),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
