import 'package:pet_boarding_space/models/discount.dart';
import 'package:pet_boarding_space/models/pet.dart';
import 'package:pet_boarding_space/models/boarding_space.dart';

class AssignedValues {
  static final List<BoardingSpace> boardingSpaces = [
    BoardingSpace(
      name: 'Cat Deluxe Cabin',
      imageUrl: 'lib/images/CatDeluxeCabin.jpeg',
      petType: PetType.cat,
      features: ['Meal', 'Private Room', 'Bathing', 'Gromming'],
      hourlyRates: 10.00,
      dailyRates: 150.00,
    ),
    BoardingSpace(
      name: 'Cat Premium Suite',
      imageUrl: 'lib/images/CatPremiumSuite.jpg',
      petType: PetType.cat,
      features: ['Meal', 'Bathing', 'Share Room', 'Playground'],
      hourlyRates: 12.00,
      dailyRates: 180.00,
    ),
    BoardingSpace(
      name: 'Cat Cozy Corner',
      imageUrl: 'lib/images/CatCozyConer.png',
      petType: PetType.cat,
      features: ['Meal', 'Share Room', 'Bathing', 'Open Area'],
      hourlyRates: 8.00,
      dailyRates: 130.00,
    ),
    BoardingSpace(
      name: 'Dog Deluxe Cabin',
      imageUrl: 'lib/images/DogDeluxeCabin.jpg',
      petType: PetType.dog,
      features: ['Meal', 'Share Room', 'Playground'],
      hourlyRates: 15.00,
      dailyRates: 220.00,
    ),
    BoardingSpace(
      name: 'Dog Premium Suite',
      imageUrl: 'lib/images/DogPremiumSuite.webp',
      petType: PetType.dog,
      features: ['Meal', 'private Room', 'Entertainment', 'Bathing'],
      hourlyRates: 20.00,
      dailyRates: 290.00,
    ),
    BoardingSpace(
      name: 'Dog Cozy Corner',
      imageUrl: 'lib/images/DogCozyConer.jpg',
      petType: PetType.dog,
      features: ['Meal', 'Share Room', 'Open Area'],
      hourlyRates: 12.00,
      dailyRates: 180.00,
    ),
  ];

  static final Map<String, Discount> discounts = {
    'SUMMER15': Discount(
      code: 'SUMMER15',
      percentage: 15.0,
      type: DiscountType.percentage,
      maximumValue: 50.0,
    ),
    'BLACKFRIDAY20': Discount(
      code: 'BLACKFRIDAY20',
      percentage: 20.0,
      type: DiscountType.percentage,
      minimumSpent: 50.0,
      maximumValue: 100.0,
    ),
    'FREESHIP': Discount(
      code: 'FREESHIP',
      amount: 15.0,
      type: DiscountType.deduction,
      minimumSpent: 100.0,
    ),
    'PETLOVER': Discount(
      code: 'PETLOVER',
      amount: 50.0,
      type: DiscountType.deduction,
      minimumSpent: 100.0,
    ),
    'WEEKEND10': Discount(
      code: 'WEEKEND10',
      percentage: 10.0,
      type: DiscountType.percentage,
      maximumValue: 25.0,
    ),
    'NEWCUSTOMER5': Discount(
      code: 'NEWCUSTOMER5',
      percentage: 5.0,
      type: DiscountType.percentage,
      minimumSpent: 20.0,
      maximumValue: 10.0,
    ),
    'LOYALTY10': Discount(
      code: 'LOYALTY10',
      percentage: 10.0,
      type: DiscountType.percentage,
      minimumSpent: 150.0,
      maximumValue: 45.0,
    ),
  };
}
