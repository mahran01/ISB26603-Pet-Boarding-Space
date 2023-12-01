import 'package:flutter/material.dart';
import 'package:pet_boarding_space/components/boarding_space_card.dart';
import 'package:pet_boarding_space/components/my_fill_button.dart';
import 'package:pet_boarding_space/components/my_outline_button.dart';
import 'package:pet_boarding_space/models/boarding_space.dart';
import 'package:pet_boarding_space/models/pet.dart';
import 'package:pet_boarding_space/models/user.dart';
import 'package:pet_boarding_space/data/data.dart';
import 'package:pet_boarding_space/theme/texts.dart';

class SpaceListPage extends StatefulWidget {
  const SpaceListPage({super.key});

  @override
  State<SpaceListPage> createState() => _SpaceListPageState();
}

class _SpaceListPageState extends State<SpaceListPage> {
  void spaceModalBottomSheet(
    BuildContext context,
    User user,
    BoardingSpace bs,
  ) {
    showModalBottomSheet<dynamic>(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) => Wrap(
        children: [
          // image container
          Stack(
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
              // custom drawer drag icon
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  height: 4,
                  width: 40,
                  margin: const EdgeInsets.only(top: 16),
                  decoration: BoxDecoration(
                      color: Colors.black.withOpacity(1),
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
              // bottom drawer
              Column(
                children: [
                  const SizedBox(height: 280),
                  Container(
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
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 30),
                          Text(
                            bs.name,
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                          const SizedBox(height: 15),
                          Container(
                            width: double.infinity,
                            height: 2,
                            color: Colors.white.withOpacity(0.3),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Hourly rates:",
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelLarge!
                                          .copyWith(
                                              color: Colors.white
                                                  .withOpacity(0.5)),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                        'RM ${bs.hourlyRates.toStringAsFixed(2)}/hour',
                                        style: numberSmallText),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Daily rates:",
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelLarge!
                                          .copyWith(
                                              color: Colors.white
                                                  .withOpacity(0.5)),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                        'RM ${bs.dailyRates.toStringAsFixed(2)}/day',
                                        style: numberSmallText),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 15),
                          Container(
                            width: double.infinity,
                            height: 2,
                            color: Colors.white.withOpacity(0.3),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Features:',
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                          const SizedBox(height: 5),
                          Wrap(
                            spacing: 8.0,
                            runSpacing: 4.0,
                            children: [
                              for (int i = 0; i < bs.features.length; i++)
                                Card(
                                  elevation: 1,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(2)),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 13),
                                    child: Text(bs.features[i]),
                                  ),
                                ),
                            ],
                          ),
                          const SizedBox(height: 30),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              MyOutlineButton(
                                text: 'Cancel',
                                onTap: () => Navigator.pop(context),
                              ),
                              const SizedBox(width: 30),
                              MyFillButton(
                                text: 'Book',
                                onTap: () {
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
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: reset change test
    // User user = User.testData();

    User user = ModalRoute.of(context)!.settings.arguments as User;
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
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 35),
              Text(
                'Explore Your Pet Space',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
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
    );
  }
}
