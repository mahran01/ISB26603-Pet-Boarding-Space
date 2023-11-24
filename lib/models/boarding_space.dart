import 'package:pet_boarding_space/models/pet.dart';

class BoardingSpace {
  String name;
  PetType petType;
  double hourlyRates, dailyRates;

  BoardingSpace({
    required this.name,
    required this.petType,
    required this.hourlyRates,
    required this.dailyRates,
  });
}
