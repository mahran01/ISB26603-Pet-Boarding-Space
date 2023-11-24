import 'package:flutter/material.dart';
import 'package:pet_boarding_space/models/pet.dart';
import 'package:pet_boarding_space/models/user.dart';

class SpaceListPage extends StatelessWidget {
  const SpaceListPage({super.key});

  @override
  Widget build(BuildContext context) {
    RouteSettings rs = ModalRoute.of(context)!.settings;
    // get the data
    User user = rs.arguments as User;
    String name = user.name;
    String address = user.address;
    String countryCode = user.countryCode;
    String phoneNo = user.phoneNo;
    String email = user.email;
    Pet pet = user.pet;

    return Scaffold(
      body: SafeArea(child: Center(child: Text("""User
Name: $name
address: $address
phoneNo: $countryCode$phoneNo
email: $email

Pet
Type: ${pet.petType}
Name: ${pet.name}
Age: ${pet.age}"""))),
    );
  }
}
