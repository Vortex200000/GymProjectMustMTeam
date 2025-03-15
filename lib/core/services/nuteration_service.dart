class NutirationService {

  
  double calculateBMR(double weight, double height, int age, String gender) {
    if (gender.toLowerCase() == 'male') {
      return 10 * weight + 6.25 * height - 5 * age + 5;
    } else {
      return 10 * weight + 6.25 * height - 5 * age - 161;
    }
  }

  double calculateTDEE(double bmr, String activityLevel) {
    Map<String, double> activityFactors = {
      'sedentary': 1.2,
      'light': 1.375,
      'moderate': 1.55,
      'active': 1.725,
      'very active': 1.9
    };
    return bmr * (activityFactors[activityLevel] ?? 1.2);
  }

  double adjustCaloriesForGoal(double tdee, String goal) {
    if (goal == 'weight_loss') return tdee - 500;
    if (goal == 'muscle_gain') return tdee + 500;
    if (goal == 'weight_gain') return tdee + 300;
    if (goal == 'muscle_mass_gain') return tdee + 700;

    return tdee;
  }

  Map<String, double> calculateMacros(
      double calories, double weight, String goal) {
    double protein = (goal == 'muscle_gain') ? weight * 2.0 : weight * 1.5;
    double proteinCalories = protein * 4;

    double fat = (calories * 0.25) / 9;
    double fatCalories = fat * 9;

    double carbCalories = calories - (proteinCalories + fatCalories);
    double carbs = carbCalories / 4;

    return {'protein': protein, 'fats': fat, 'carbs': carbs};
  }
}


