import 'package:pet_boarding_space/models/pet.dart';
import 'package:pet_boarding_space/models/boarding_space.dart';

class AssignedValues {
  final List<BoardingSpace> boardingSpaces = [
    BoardingSpace(
        name: 'Cat Deluxe Cabin',
        petType: PetType.cat,
        hourlyRates: 10.00,
        dailyRates: 35.00),
    BoardingSpace(
        name: 'Cat Premium Suite',
        petType: PetType.cat,
        hourlyRates: 12.00,
        dailyRates: 40.00),
    BoardingSpace(
        name: 'Cat Cozy Corner',
        petType: PetType.cat,
        hourlyRates: 8.00,
        dailyRates: 30.00),
    BoardingSpace(
        name: 'Cat Spacious Room',
        petType: PetType.cat,
        hourlyRates: 10.00,
        dailyRates: 35.00),
    BoardingSpace(
        name: 'Dog Deluxe Cabin',
        petType: PetType.dog,
        hourlyRates: 15.00,
        dailyRates: 45.00),
    BoardingSpace(
        name: 'Dog Premium Suite',
        petType: PetType.dog,
        hourlyRates: 20.00,
        dailyRates: 55.00),
    BoardingSpace(
        name: 'Dog Cozy Corner',
        petType: PetType.dog,
        hourlyRates: 12.00,
        dailyRates: 38.00),
    BoardingSpace(
        name: 'Dog Spacious Room',
        petType: PetType.dog,
        hourlyRates: 18.00,
        dailyRates: 50.00),
  ];
}
