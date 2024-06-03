import 'package:firebase_shoe_store/core/base/base_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ManageProductCubit extends Cubit<BaseState> {
  ManageProductCubit() : super(InitialState());

  String? selectedColor;
  double? selectedShoeSize;

  void selectColor(String color) {
    selectedColor = color;
  }

  void selectShoeSize(double shoeSize) {
    selectedShoeSize = shoeSize;
  }

  void reset() {
    selectedColor = null;
    selectedShoeSize = null;
  }
}
