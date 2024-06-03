part of '../pages/product_details_screen.dart';

class AddToCartBottomSheet extends StatefulWidget {
  const AddToCartBottomSheet({super.key, required this.product});

  final Product product;

  @override
  State<AddToCartBottomSheet> createState() => _AddToCartBottomSheetState();
}

class _AddToCartBottomSheetState extends State<AddToCartBottomSheet> {
  int _currentValue = 1;

  void _increment() {
    if (_currentValue < 10) {
      setState(() {
        _currentValue++;
      });
    }
  }

  void _decrement() {
    if (_currentValue > 1) {
      setState(() {
        _currentValue--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const SizedBox(height: 30.0),
              const Text(
                'Enter Number',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30.0),
              TextField(
                textAlign: TextAlign.left,
                controller: TextEditingController(text: '$_currentValue'),
                readOnly: true,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  suffixIcon: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: _decrement,
                        icon: const Icon(Icons.remove_circle_rounded),
                        color: _currentValue > 1
                            ? AppColors.primaryNeutral500
                            : AppColors.primaryNeutral200,
                      ),
                      IconButton(
                        onPressed: _increment,
                        icon: const Icon(Icons.add_circle_rounded),
                        color: _currentValue < 10
                            ? AppColors.primaryNeutral500
                            : AppColors.primaryNeutral200,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30.0),
              ElevatedButton(
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
                      quantity: _currentValue,
                      color: BlocProvider.of<ManageProductCubit>(context)
                          .selectedColor!,
                      size: BlocProvider.of<ManageProductCubit>(context)
                          .selectedShoeSize!,
                      total: widget.product.price! * _currentValue,
                    ),
                  );
                  Navigator.pop(context);
                },
                child: const Text('Submit'),
              ),
              const SizedBox(height: 30.0),
            ],
          ),
        ),
      ),
    );
  }
}
