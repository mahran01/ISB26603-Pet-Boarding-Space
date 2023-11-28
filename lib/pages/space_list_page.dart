import 'package:flutter/material.dart';
import 'package:pet_boarding_space/components/boarding_space_card.dart';
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
  void spaceModalBottomSheet(
      BuildContext context, User user, BoardingSpace bs) {
    showModalBottomSheet<dynamic>(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) => Container(
        height: 510,
        width: double.infinity,
        decoration: const BoxDecoration(
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
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                image: DecorationImage(
                  image: AssetImage(bs.imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              height: 4,
              width: 40,
              margin: const EdgeInsets.only(top: 16),
              decoration: BoxDecoration(
                  color: Colors.black.withOpacity(1),
                  borderRadius: BorderRadius.circular(10)),
            ),
            Column(
              children: [
                const SizedBox(height: 280),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.5),
                          spreadRadius: 3,
                          blurRadius: 5,
                        )
                      ],
                      color: Theme.of(context).colorScheme.background,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    width: double.infinity,
                    child: Column(
                      children: [
                        const SizedBox(height: 5),
                        Text(
                          bs.name,
                          style: Theme.of(context).textTheme.headlineLarge,
                        ),
                        const SizedBox(height: 10),
                        Text(
                            'Price per hour: RM ${bs.hourlyRates.toStringAsFixed(2)}'),
                        const SizedBox(height: 5),
                        Text(
                            'Price per day: RM ${bs.dailyRates.toStringAsFixed(2)}'),
                        const SizedBox(height: 40),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                fixedSize: const Size(
                                  150,
                                  50,
                                ),
                                side: BorderSide(
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                              child: const Text('Cancel'),
                              onPressed: () => Navigator.pop(context),
                            ),
                            const SizedBox(width: 10),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                fixedSize: const Size(
                                  150,
                                  50,
                                ),
                                primary: Theme.of(context).primaryColor,
                              ),
                              child: const Text(
                                'Book',
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                                Navigator.pushNamed(
                                  context,
                                  "/paymentpage",
                                  arguments: {
                                    "User": user,
                                    "BoardingSpace": bs
                                  },
                                );
                              },
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: reset change
    User user = User.testData();

    // User user = ModalRoute.of(context)!.settings.arguments as User;
    PetType userPet = user.pet.petType;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(MediaQuery.of(context).size.height / 5),
        child: AppBar(
          shape: const RoundedRectangleBorder(
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
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15.0),
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
                      if (userPet == bs.petType) {
                        return GestureDetector(
                          onTap: () => spaceModalBottomSheet(context, user, bs),
                          child: BoardingSpaceCard(boardingSpace: bs),
                        );
                      } else {
                        return const SizedBox();
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
