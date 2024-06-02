import 'package:firebase_shoe_store/core/theme/app_colors.dart';
import 'package:firebase_shoe_store/core/theme/theme_data.dart';
import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  const Button({
    super.key,
    required this.label,
    required this.onPressed,
    this.background,
    this.textStyle,
    this.scale = 1,
    this.height = 50,
    this.width = double.infinity,
    this.isLoading = false,
    this.filled = true,
    this.prefix,
    this.suffix,
    this.disable = false,
    this.borderRadius = 50,
  });

  final VoidCallback onPressed;
  final String label;
  final Color? background;
  final TextStyle? textStyle;
  final double scale;
  final double height;
  final double width;
  final bool filled;
  final bool isLoading;
  final Widget? prefix;
  final Widget? suffix;
  final bool disable;
  final double borderRadius;

  factory Button.filled({
    required String label,
    required VoidCallback onPressed,
    Color? background,
    TextStyle? textStyle,
    double scale = 1,
    double height = 50,
    double width = double.infinity,
    bool isLoading = false,
    Widget? prefix,
    Widget? suffix,
    bool disable = false,
  }) {
    return Button(
      label: label,
      onPressed: onPressed,
      background: background,
      textStyle: textStyle,
      scale: scale,
      height: height,
      width: width,
      isLoading: isLoading,
      filled: true,
      prefix: prefix,
      suffix: suffix,
      disable: disable,
    );
  }

  factory Button.outlined({
    required String label,
    required VoidCallback onPressed,
    Color? background,
    TextStyle? textStyle,
    double scale = 1,
    double height = 50,
    double width = double.infinity,
    isLoading = false,
    Widget? prefix,
    Widget? suffix,
    bool disable = false,
  }) {
    return Button(
      label: label,
      onPressed: onPressed,
      background: background,
      textStyle: textStyle,
      scale: scale,
      height: height,
      width: width,
      isLoading: isLoading,
      filled: false,
      prefix: prefix,
      suffix: suffix,
      disable: disable,
    );
  }

  @override
  Widget build(BuildContext context) {
    double height = this.height;

    return DecoratedBox(
      decoration: disable || filled == false
          ? const BoxDecoration()
          : BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadius),
            ),
      child: ElevatedButton(
        onPressed: disable
            ? null
            : isLoading
                ? null
                : onPressed,
        style: filled
            ? ElevatedButton.styleFrom(
                elevation: 0,
                padding: EdgeInsets.zero,
                fixedSize: Size(width, height),
                backgroundColor: background ?? AppColors.primaryNeutral500,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(borderRadius),
                ),
              )
            : ElevatedButton.styleFrom(
                elevation: 0,
                fixedSize: Size(width, height),
                backgroundColor:
                    disable ? Colors.grey.shade300 : background ?? Colors.white,
                side: const BorderSide(
                  color: AppColors.primaryNeutral300,
                  width: 1,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(borderRadius),
                ),
              ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            isLoading
                ? Transform.scale(
                    scale: scale,
                    child: const SizedBox(
                      height: 30,
                      width: 30,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    ),
                  )
                : Row(
                    children: [
                      prefix != null ? prefix! : const SizedBox(),
                      prefix != null
                          ? const SizedBox(width: 10)
                          : const SizedBox(),
                      Text(
                        label,
                        style: filled
                            ? textStyle ??
                                themeData.textTheme.bodyMedium!.copyWith(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                )
                            : themeData.textTheme.bodyMedium!.copyWith(
                                color: AppColors.primaryNeutral500,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                      ),
                      suffix != null
                          ? const SizedBox(width: 10)
                          : const SizedBox(),
                      suffix != null ? suffix! : const SizedBox(),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
