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
      elevation: 1,
      child: Container(
        width: 300,
        decoration: BoxDecoration(),
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
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    boardingSpace.name,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Text(
                      'RM ${boardingSpace.hourlyRates.toStringAsFixed(2)} / hour',
                      style: Theme.of(context).textTheme.labelLarge!),
                  Text(
                      'RM ${boardingSpace.dailyRates.toStringAsFixed(2)} / day',
                      style: Theme.of(context).textTheme.labelLarge!),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
