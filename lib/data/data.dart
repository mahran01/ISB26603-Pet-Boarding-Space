import 'package:pet_boarding_space/models/pet.dart';
import 'package:pet_boarding_space/models/boarding_space.dart';

class AssignedValues {
  static final List<BoardingSpace> boardingSpaces = [
    BoardingSpace(
        name: 'Cat Deluxe Cabin',
        imageUrl: 'lib/images/CatDeluxeCabin.jpeg',
        petType: PetType.cat,
        hourlyRates: 10.00,
        dailyRates: 35.00),
    BoardingSpace(
        name: 'Cat Premium Suite',
        imageUrl: 'lib/images/CatPremiumSuite.jpg',
        petType: PetType.cat,
        hourlyRates: 12.00,
        dailyRates: 40.00),
    BoardingSpace(
        name: 'Cat Cozy Corner',
        imageUrl: 'lib/images/CatCozyConer.png',
        petType: PetType.cat,
        hourlyRates: 8.00,
        dailyRates: 30.00),
    // BoardingSpace(
    //     name: 'Cat Spacious Room',
    //     petType: PetType.cat,
    //     hourlyRates: 10.00,
    //     dailyRates: 35.00),
    BoardingSpace(
        name: 'Dog Deluxe Cabin',
        imageUrl: 'lib/images/DogDeluxeCabin.jpg',
        petType: PetType.dog,
        hourlyRates: 15.00,
        dailyRates: 45.00),
    BoardingSpace(
        name: 'Dog Premium Suite',
        imageUrl: 'lib/images/DogPremiumSuite.webp',
        petType: PetType.dog,
        hourlyRates: 20.00,
        dailyRates: 55.00),
    BoardingSpace(
        name: 'Dog Cozy Corner',
        imageUrl: 'lib/images/DogCozyConer.jpg',
        petType: PetType.dog,
        hourlyRates: 12.00,
        dailyRates: 38.00),
    // BoardingSpace(
    //     name: 'Dog Spacious Room',
    //     petType: PetType.dog,
    //     hourlyRates: 18.00,
    //     dailyRates: 50.00),
  ];
}

class InputValidition {
  static bool leadingWhitespace(String s) => RegExp(r"/^[\s]+/g").hasMatch(s);
  static bool trailingWhitespace(String s) => RegExp(r"/[\s]+$/g").hasMatch(s);

  static bool name(String s) =>
      RegExp(r"/^(?=.*[A-Z])[A-Z0-9\@\s]*$/gis").hasMatch(s);
  static bool address(String s) =>
      RegExp(r"/^(?=.*[A-Z])[A-Z0-9\@\-\.\,\/\s]*$/gis").hasMatch(s);
  static bool phoneNo(String s) => RegExp(r"/^[0-9]{4,14}$/gs").hasMatch(s);
  static bool email(String s) =>
      RegExp(r"^[A-Z0-9\_\.]+\@[A-Z]+\.[A-Z\.]+$\gis").hasMatch(s);
}
