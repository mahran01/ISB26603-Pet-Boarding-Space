import 'package:flutter/material.dart';
import 'package:pet_boarding_space/models/boarding_space.dart';
import 'package:pet_boarding_space/models/pet.dart';
import 'package:pet_boarding_space/models/user.dart';
import 'package:pet_boarding_space/data/data.dart';

class SpaceListPage extends StatefulWidget {
  const SpaceListPage({super.key});

  @override
  State<SpaceListPage> createState() => _SpaceListPageState();
}

class _SpaceListPageState extends State<SpaceListPage> {
  PetType userPet = PetType.cat; //TODO: replace with user input
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(150.0),
        child: AppBar(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(120),
            ),
          ),
          backgroundColor: Theme.of(context).primaryColor,
        ),
      ),
      body: SafeArea(
        child: Container(
          // child: Column(
          //   children: [
          //     const SizedBox(height: 30),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 25),
                Text(
                  'Explore Your Pet Space',
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                const SizedBox(height: 5),
                Text(
                  'Pick your pet favorite space',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 50),
                Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: AssignedValues.boardingSpaces.length,
                    itemBuilder: (BuildContext context, int index) {
                      BoardingSpace bs = AssignedValues.boardingSpaces[index];
                      if (userPet == bs.petType) {
                        return GestureDetector(
                          onTap: () {},
                          child: buildBoardingSpaceCard(
                              AssignedValues.boardingSpaces[index]),
                        );
                      }
                    },
                  ),
                ),
                const SizedBox(height: 100),
              ],
            ),
          ),
          //   ],
          // // ),
        ),
      ),
    );
  }
}

Widget buildBoardingSpaceCard(BoardingSpace boardingSpaces) {
  return Card(
    margin: EdgeInsets.only(right: 20),
    elevation: 0,
    child: Column(
      children: [
        Container(
          width: 300,
          height: 310,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            image: DecorationImage(
                image: AssetImage(boardingSpaces.imageUrl), fit: BoxFit.cover),
          ),
        ),
        Text(boardingSpaces.name),
      ],
    ),
  );
}
