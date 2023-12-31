import 'package:flutter/material.dart';
import 'package:pet_boarding_space/models/boarding_space.dart';
import 'package:pet_boarding_space/theme/texts.dart';

class BoardingSpaceCard extends StatelessWidget {
  final BoardingSpace boardingSpace;
  const BoardingSpaceCard({super.key, required this.boardingSpace});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Card(
          margin: const EdgeInsets.only(right: 20),
          elevation: 1,
          child: SizedBox(
            width: 300,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 300,
                  height: MediaQuery.of(context).size.height / 6 * 2,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                    image: DecorationImage(
                        image: AssetImage(boardingSpace.imageUrl),
                        fit: BoxFit.cover),
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 18.0, vertical: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        boardingSpace.name,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 20),
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
                                          color: Colors.white.withOpacity(0.5)),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                    '${boardingSpace.hourlyRates.toStringAsFixed(2)}/hour',
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
                                          color: Colors.white.withOpacity(0.5)),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                    '${boardingSpace.dailyRates.toStringAsFixed(2)}/day',
                                    style: numberSmallText),
                              ],
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
