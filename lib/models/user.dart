import 'package:pet_boarding_space/models/pet.dart';

class User {
  String name;
  String address;
  String countryCode;
  String phoneNo;
  String email;
  DateTime checkInDateTime;
  DateTime departureDateTime;
  Pet pet;

  User({
    required this.name,
    required this.address,
    required this.countryCode,
    required this.phoneNo,
    required this.email,
    required this.checkInDateTime,
    required this.departureDateTime,
    required this.pet,
  });

  static User testData() {
    return User(
      name: 'John Doe',
      address:
          '123 Main Street, Southeast Avenue, 808 Tranquil Meadow Lane, Serenity Hills, Oakwood, NY 25818',
      countryCode: '+10',
      phoneNo: '555-555-5555',
      email: 'johndoe@example.com',
      checkInDateTime: DateTime.parse('2023-11-27 10:00:00'),
      departureDateTime: DateTime.parse('2023-11-30 12:00:00'),
      pet: Pet.testData(),
    );
  }
}
