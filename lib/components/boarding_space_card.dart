import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:pet_boarding_space/models/boarding_space.dart';

class BoardingSpaceCard extends StatelessWidget {
  final BoardingSpace boardingSpace;
  const BoardingSpaceCard({super.key, required this.boardingSpace});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(right: 20, bottom: 40),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(35),
        //set border radius more than 50% of height and width to make circle
      ),
      elevation: 2,
      child: Container(
        width: 300,
        decoration: BoxDecoration(
          color: Colors.black38,
          borderRadius: BorderRadius.circular(35),
        ),
        child: Column(
          children: [
            Container(
              width: 300,
              height: MediaQuery.of(context).size.height / 5 * 2,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(35),
                  topRight: Radius.circular(35),
                ),
                image: DecorationImage(
                    image: AssetImage(boardingSpace.imageUrl),
                    fit: BoxFit.cover),
              ),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: FittedBox(
                  fit: BoxFit.fitHeight,
                  child: ClipRect(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        color: Colors.black.withOpacity(0.1),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'RM ${boardingSpace.hourlyRates.toStringAsFixed(2)} / hour',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                shadows: [
                                  const Shadow(
                                    offset: Offset(1.0, 2.0),
                                    blurRadius: 5.0,
                                    color: Colors.black,
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              'RM ${boardingSpace.dailyRates.toStringAsFixed(2)} / day',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                shadows: [
                                  const Shadow(
                                    offset: Offset(0.0, 2.0),
                                    blurRadius: 5.0,
                                    color: Colors.black,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
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
