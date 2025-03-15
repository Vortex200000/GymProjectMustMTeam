import 'package:mgym/features/domain/entities/meal_blan_entity.dart';

class MealPlanModel extends MealBlanEntity {
  const MealPlanModel(
      {required super.name,
      required super.discription,
      required super.calories,
      required super.protein,
      required super.fats,
      required super.carbs,
      required super.photoPath,
      required super.ingrediants});

  Map<String, dynamic> toMap() => {
        MealPlanKeys.name: name,
        MealPlanKeys.discription: discription,
        MealPlanKeys.calories: calories,
        MealPlanKeys.protein: protein,
        MealPlanKeys.fats: fats,
        MealPlanKeys.carbs: carbs,
        MealPlanKeys.photoPath: photoPath,
        MealPlanKeys.ingrediants: ingrediants,
      };

  factory MealPlanModel.fromMap(Map<String, dynamic> map) => MealPlanModel(
        name: map[MealPlanKeys.name],
        discription: map[MealPlanKeys.discription],
        calories: (map[MealPlanKeys.calories] as num).toDouble(),
        protein: (map[MealPlanKeys.protein] as num).toDouble(),
        fats: (map[MealPlanKeys.fats] as num).toDouble(),
        carbs: (map[MealPlanKeys.carbs] as num).toDouble(),
        photoPath: map[MealPlanKeys.photoPath],
        ingrediants: (map[MealPlanKeys.ingrediants] as List?)
                ?.map((e) => e.toString())
                .toList() ??
            [],
      );
}

class MealPlanKeys {
  static const String name = 'name';
  static const String discription = 'discription';
  static const String calories = 'calories';
  static const String protein = 'protein';
  static const String fats = 'fats';
  static const String carbs = 'carbs';
  static const String photoPath = 'photo_path';
  static const String ingrediants = 'ingredients';
}
