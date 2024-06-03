part of '../pages/cart_screen.dart';

class QuantityAndTotal extends StatefulWidget {
  const QuantityAndTotal({super.key, required this.cart});

  final Cart cart;

  @override
  State<QuantityAndTotal> createState() => _QuantityAndTotalState();
}

class _QuantityAndTotalState extends State<QuantityAndTotal> {
  @override
  void initState() {
    super.initState();

    quantity = widget.cart.quantity;
    total = widget.cart.total;
  }

  int quantity = 0;
  double total = 0;

  void _incrementQuantity() {
    if (quantity < 10) {
      setState(() {
        quantity++;
        total = widget.cart.cartItem.price! * quantity;
      });
    }
  }

  void _decrementQuantity() {
    if (quantity > 1) {
      setState(() {
        quantity--;
        total = widget.cart.cartItem.price! * quantity;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          formatCurrency(total),
          style: themeData.textTheme.bodyMedium!.copyWith(
            color: AppColors.primaryNeutral600,
            fontWeight: FontWeight.w600,
          ),
        ),
        Row(
          children: [
            GestureDetector(
              onTap: _decrementQuantity,
              child: Icon(
                Icons.remove_circle_outline_outlined,
                size: 22,
                color: quantity > 1
                    ? AppColors.primaryNeutral500
                    : AppColors.primaryNeutral200,
              ),
            ),
            const SizedBox(width: 4),
            Text(
              '$quantity',
              style: themeData.textTheme.bodyLarge!.copyWith(
                color: AppColors.primaryNeutral500,
              ),
            ),
            const SizedBox(width: 4),
            GestureDetector(
              onTap: _incrementQuantity,
              child: Icon(
                Icons.add_circle_outline_outlined,
                size: 22,
                color: quantity < 10
                    ? AppColors.primaryNeutral500
                    : AppColors.primaryNeutral200,
              ),
            ),
          ],
        )
      ],
    );
  }
}
