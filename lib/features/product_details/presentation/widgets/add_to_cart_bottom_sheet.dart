part of '../pages/product_details_screen.dart';

class AddToCartBottomSheet extends StatefulWidget {
  const AddToCartBottomSheet({super.key, required this.product});

  final Product product;

  @override
  State<AddToCartBottomSheet> createState() => _AddToCartBottomSheetState();
}

class _AddToCartBottomSheetState extends State<AddToCartBottomSheet> {
  int _quantity = 1;
  double _price = 0.0;

  @override
  void initState() {
    super.initState();

    _price = widget.product.price!;
  }

  void _incrementQuantity() {
    if (_quantity < 10) {
      setState(() {
        _quantity++;
      });
    }
  }

  void _decrementQuantity() {
    if (_quantity > 1) {
      setState(() {
        _quantity--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 20),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Center(
                child: Container(
                  height: 4,
                  width: 40,
                  decoration: BoxDecoration(
                    color: AppColors.primaryNeutral200,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Add to cart',
                    style: themeData.textTheme.headlineLarge!.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
              const SizedBox(height: 30.0),
              Text(
                'Quantity',
                style: themeData.textTheme.headlineMedium!.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '$_quantity',
                    style: themeData.textTheme.bodyLarge!.copyWith(
                      color: AppColors.primaryNeutral500,
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      GestureDetector(
                        onTap: _decrementQuantity,
                        child: Icon(
                          Icons.remove_circle_outline_outlined,
                          size: 28,
                          color: _quantity > 1
                              ? AppColors.primaryNeutral400
                              : AppColors.primaryNeutral200,
                        ),
                      ),
                      const SizedBox(width: 16),
                      GestureDetector(
                        onTap: _incrementQuantity,
                        child: Icon(
                          Icons.add_circle_outline_outlined,
                          size: 28,
                          color: _quantity < 10
                              ? AppColors.primaryNeutral400
                              : AppColors.primaryNeutral200,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              const Divider(thickness: 1.0, color: AppColors.primaryNeutral500),
              const SizedBox(height: 30.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Total Price',
                        style: themeData.textTheme.headlineMedium!.copyWith(
                          fontWeight: FontWeight.w300,
                          color: AppColors.primaryNeutral300,
                        ),
                      ),
                      const SizedBox(height: 2.0),
                      Text(
                        '\$${(_price * _quantity).toStringAsFixed(2)}',
                        style: themeData.textTheme.headlineLarge!.copyWith(
                          color: AppColors.primaryNeutral900,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  Button(
                    label: 'ADD TO CART',
                    width: 160,
                    onPressed: () {
                      BlocProvider.of<ManageCartCubit>(context).addToCart(
                        Cart(
                          cartItem: CartItem(
                            productId: widget.product.productId!,
                            name: widget.product.name!,
                            price: widget.product.price!,
                            images: widget.product.images!,
                            brandId: widget.product.brandId!,
                            brandLogo: widget.product.brandLogo!,
                            gender: widget.product.gender!,
                          ),
                          quantity: _quantity,
                          color: BlocProvider.of<ManageProductCubit>(context)
                              .selectedColor!,
                          size: BlocProvider.of<ManageProductCubit>(context)
                              .selectedShoeSize!,
                          total: _price,
                        ),
                      );
                      Navigator.pop(context);
                      showModalBottomSheet(
                        isScrollControlled: true,
                        context: context,
                        builder: (BuildContext context) {
                          return AddToCartSuccessBottomSheet(
                            quantity: _quantity,
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
