import 'package:flutter/material.dart';
import 'package:pet_boarding_space/models/boarding_space.dart';
import 'package:pet_boarding_space/models/pet.dart';
import 'package:pet_boarding_space/models/user.dart';
import 'package:pet_boarding_space/data/data.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  @override
  Widget build(BuildContext context) {
    Map<String, Object> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, Object>;
    User user = args["User"] as User;
    BoardingSpace bs = args["BoardingSpace"] as BoardingSpace;

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'User Information',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              Text(
                'Name: ${user.name}',
              ),
              Text(
                'Address: ${user.address}',
              ),
              Text(
                'Contact Number: ${user.countryCode}${user.phoneNo}',
              ),
              Text(
                'Email: ${user.email}',
              ),
              SizedBox(height: 10),
              Text(
                'Pet Information',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              Text(
                'Pet Type: ${user.pet.petType}',
              ),
              Text(
                'Pet Name: ${user.pet.name}',
              ),
              Text(
                'Pet Age: ${user.pet.age}',
              ),
              SizedBox(height: 10),
              Text(
                'Staying time',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              Text(
                'Check In : ${user.checkInDateTime}',
              ),
              Text(
                'Check Out : ${user.departureDateTime}',
              ),
              SizedBox(height: 10),
              Text(
                'Boarding space information',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              Text(
                'Name : ${bs.name}',
              ),
              Text(
                'Hourly Rate : RM${bs.hourlyRates}',
              ),
              Text(
                'Daily  Rates : ${bs.dailyRates}',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
