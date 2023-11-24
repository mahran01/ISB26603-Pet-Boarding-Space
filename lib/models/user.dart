import 'package:pet_boarding_space/models/pet.dart';

class User {
  String name;
  String address;
  String countryCode;
  String phoneNo;
  String email;
  DateTime checkInDt;
  DateTime departureDt;
  Pet pet;

  User({
    required this.name,
    required this.address,
    required this.countryCode,
    required this.phoneNo,
    required this.email,
    required this.checkInDt,
    required this.departureDt,
    required this.pet,
  });

  String get _name => name;
  String get _address => address;
  String get _countryCode => countryCode;
  String get _phoneNo => phoneNo;
  String get _email => email;
  DateTime get _checkInDt => checkInDt;
  DateTime get _departureDt => departureDt;
  Pet get _pet => pet;
}