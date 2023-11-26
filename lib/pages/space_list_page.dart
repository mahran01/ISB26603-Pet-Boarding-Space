import 'dart:ui';

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
  @override
  Widget build(BuildContext context) {
    User user = ModalRoute.of(context)!.settings.arguments as User;
    PetType userPet = user.pet.petType;
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
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 35),
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
                      // TODO: replace it with user
                      if (userPet == bs.petType) {
                        return GestureDetector(
                          onTap: () {
                            showBottomSheet(
                              context: context,
                              builder: (BuildContext context) => Container(
                                height: 510,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                  ),
                                ),
                                child: Stack(
                                    alignment: Alignment.topCenter,
                                    children: [
                                      Container(
                                        height: 300,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(20),
                                            topRight: Radius.circular(20),
                                          ),
                                          image: DecorationImage(
                                            image: AssetImage(bs.imageUrl),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      Column(
                                        children: [
                                          SizedBox(height: 280),
                                          Expanded(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.black
                                                        .withOpacity(0.5),
                                                    spreadRadius: 3,
                                                    blurRadius: 5,
                                                  )
                                                ],
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .background,
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(20),
                                                  topRight: Radius.circular(20),
                                                ),
                                              ),
                                              width: double.infinity,
                                              child: Column(
                                                children: [
                                                  SizedBox(height: 5),
                                                  Text(
                                                    bs.name,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headlineLarge,
                                                  ),
                                                  SizedBox(height: 10),
                                                  Text(
                                                      'Price per hour: RM ${bs.hourlyRates}'),
                                                  SizedBox(height: 5),
                                                  Text(
                                                      'Price per day: RM ${bs.dailyRates}'),
                                                  SizedBox(height: 40),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      ElevatedButton(
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          fixedSize: const Size(
                                                            150,
                                                            50,
                                                          ),
                                                          side: BorderSide(
                                                            color: Theme.of(
                                                                    context)
                                                                .primaryColor,
                                                          ),
                                                        ),
                                                        child: Text('Cancel'),
                                                        onPressed: () =>
                                                            Navigator.pop(
                                                                context),
                                                      ),
                                                      SizedBox(width: 10),
                                                      ElevatedButton(
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          fixedSize: const Size(
                                                            150,
                                                            50,
                                                          ),
                                                          primary:
                                                              Theme.of(context)
                                                                  .primaryColor,
                                                        ),
                                                        child: Text(
                                                          'Book',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                        onPressed: () =>
                                                            Navigator.pushNamed(
                                                          context,
                                                          "/paymentpage",
                                                          arguments: {
                                                            "User": user,
                                                            "BoardingSpace": bs
                                                          },
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    ]),
                              ),
                            );
                          },
                          child: BoardingSpaceCard(boardingSpace: bs),
                        );
                      } else {
                        return SizedBox();
                      }
                    },
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BoardingSpaceCard extends StatelessWidget {
  final BoardingSpace boardingSpace;
  const BoardingSpaceCard({super.key, required this.boardingSpace});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(right: 20, bottom: 40),
      elevation: 0,
      child: Container(
        width: 300,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 94, 92, 92),
          borderRadius: BorderRadius.circular(35),
        ),
        child: Column(
          children: [
            Container(
              width: 300,
              height: 310,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(35),
                  topRight: Radius.circular(35),
                ),
                image: DecorationImage(
                    image: AssetImage(boardingSpace.imageUrl),
                    fit: BoxFit.cover),
              ),
            ),
            const SizedBox(height: 15),
            Text(
              boardingSpace.name,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ],
        ),
      ),
    );
  }
}
