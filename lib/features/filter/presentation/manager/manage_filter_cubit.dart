import 'package:firebase_shoe_store/core/base/base_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ManageFilterCubit extends Cubit<BaseState> {
  ManageFilterCubit() : super(InitialState());

  /// Sort by
  final List<String> sortBye = [
    'Most recent',
    'Lowest price',
    'Highest price',
  ];
  int? selectedSortBye;
  String get selectedSortByeValue =>
      selectedSortBye != null ? sortBye[selectedSortBye!] : '';

  void selectSortBy(int index) {
    selectedSortBye = index;

    if (!filters.contains('sortBy')) {
      emit(const LoadingState());
      filters.add('sortBy');
      emit(const SuccessState());
    }
  }

  void unSelectSortBy() {
    selectedSortBye = null;

    if (filters.contains('sortBy')) {
      emit(const LoadingState());
      filters.remove('sortBy');
      emit(const SuccessState());
    }
  }

  /// Gender
  final List<String> genders = ['Men', 'Women', 'Unisex'];
  int? selectedGender;
  String get selectedGenderValue =>
      selectedGender != null ? genders[selectedGender!] : '';

  void selectGender(int index) {
    selectedGender = index;

    if (!filters.contains('gender')) {
      emit(const LoadingState());
      filters.add('gender');
      emit(const SuccessState());
    }
  }

  void unSelectGender() {
    selectedGender = null;

    if (filters.contains('gender')) {
      emit(const LoadingState());
      filters.remove('gender');
      emit(const SuccessState());
    }
  }

  /// Color
  final List<String> colors = [
    'White',
    'Black',
    'Blue',
    'Red',
    'Green',
    'Yellow',
    'Purple',
  ];
  int? selectedColor;
  String get selectedColorValue =>
      selectedColor != null ? colors[selectedColor!].toLowerCase() : '';

  void selectColor(int index) {
    selectedColor = index;

    if (!filters.contains('color')) {
      emit(const LoadingState());
      filters.add('color');
      emit(const SuccessState());
    }
  }

  void unSelectColor() {
    selectedColor = null;

    if (filters.contains('color')) {
      emit(const LoadingState());
      filters.remove('color');
      emit(const SuccessState());
    }
  }

  /// Range Values
  RangeValues rangeValues = const RangeValues(0, 2000);
  RangeValues? selectedRangeValue;

  void updateRangeValues(RangeValues values) {
    selectedRangeValue = values;

    if (!filters.contains('range')) {
      emit(const LoadingState());
      filters.add('range');
      emit(const SuccessState());
    }
  }

  /// Filters
  List<String> filters = [];

  void reset() {
    emit(const LoadingState());
    filters.clear();
    selectedSortBye = null;
    selectedGender = null;
    selectedColor = null;
    selectedRangeValue = null;
    emit(const SuccessState());
  }
}
