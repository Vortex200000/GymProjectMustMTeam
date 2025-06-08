import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mgym/features/domain/entities/meal_blan_entity.dart';

class NutrationController extends ChangeNotifier {
  late List<MealBlanEntity> _userMeals;
  List<MealBlanEntity> get userMeals => _userMeals;
  ValueNotifier<String> mealIdd = ValueNotifier<String>('');
  ValueNotifier<bool> selected = ValueNotifier<bool>(false);
  ValueNotifier<int?> selectedIndex = ValueNotifier<int?>(null);
  void initialize(List<MealBlanEntity> meals) {
    _userMeals = meals;
  }

  void updateMealId(String mealId) {
    mealIdd.value = mealId;
    log(mealId.toString());
    notifyListeners();
  }

  MealBlanEntity? seeMealRecipe(String mealId) {
    for (MealBlanEntity entity in _userMeals) {
      if (entity.id == mealId) {
        return entity;
      }
    }
    return null;
  }

  void toggleSelected(int index, String mealId) {
    if (selectedIndex.value == index) {
      selectedIndex.value = null; // Deselect if same index clicked
      updateMealId('');
    } else {
      updateMealId(mealId);

      selectedIndex.value = index; // Select new index
    }
  }
}
