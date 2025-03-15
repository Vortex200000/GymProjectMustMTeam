import 'package:equatable/equatable.dart';
import 'package:mgym/features/data/models/meal_plan_model.dart';

class MealBlanEntity extends Equatable {
  final String name;
  final String discription;
  final double calories;
  final double protein;
  final double fats;
  final double carbs;
  final String photoPath;
  final List<String> ingrediants;

  const MealBlanEntity(
      {required this.name,
      required this.ingrediants,
      required this.discription,
      required this.calories,
      required this.protein,
      required this.photoPath,
      required this.fats,
      required this.carbs});

  MealBlanEntity cobyWith(
          String? name,
          String? discription,
          double? calories,
          double? protieen,
          double? fats,
          double? carpps,
          String? photo,
          List<String>? ingrediants) =>
      MealBlanEntity(
          ingrediants: ingrediants ?? this.ingrediants,
          name: name ?? this.name,
          discription: discription ?? this.discription,
          calories: calories ?? this.calories,
          protein: protieen ?? this.protein,
          fats: fats ?? this.fats,
          carbs: carpps ?? this.carbs,
          photoPath: photo ?? this.photoPath);

  MealPlanModel get toModel => MealPlanModel(
      ingrediants: ingrediants,
      name: name,
      discription: discription,
      calories: calories,
      protein: protein,
      fats: fats,
      carbs: carbs,
      photoPath: photoPath);
  @override
  List<Object?> get props => [
        name,
        discription,
        calories,
        protein,
        fats,
        carbs,
        photoPath,
        ingrediants,
      ];
}
