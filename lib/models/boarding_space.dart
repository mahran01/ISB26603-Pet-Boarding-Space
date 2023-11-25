import 'package:pet_boarding_space/models/pet.dart';

class BoardingSpace {
  String name;
  String imageUrl;
  PetType petType;
  double hourlyRates, dailyRates;

  BoardingSpace({
    required this.name,
    required this.imageUrl,
    required this.petType,
    required this.hourlyRates,
    required this.dailyRates,
  });
}
