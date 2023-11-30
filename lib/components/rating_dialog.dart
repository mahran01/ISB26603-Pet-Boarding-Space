import 'package:flutter/material.dart';
import 'package:pet_boarding_space/components/my_fill_button.dart';
import 'package:pet_boarding_space/components/my_outline_button.dart';

class RatingDialog extends StatefulWidget {
  @override
  _RatingDialogState createState() => _RatingDialogState();
}

class _RatingDialogState extends State<RatingDialog> {
  int _stars = 0;

  Widget _buildStar(int starCount) {
    return InkWell(
      child: Icon(
        Icons.star,
        // size: 30.0,
        color: _stars >= starCount ? Colors.orange : Colors.grey,
      ),
      onTap: () {
        setState(() {
          _stars = starCount;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      titlePadding: EdgeInsets.only(top: 40, left: 30, right: 30),
      title: Center(
        child: Text(
          'How was your experience?',
          style: Theme.of(context).textTheme.titleLarge,
          textAlign: TextAlign.center,
        ),
      ),
      content: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _buildStar(1),
            _buildStar(2),
            _buildStar(3),
            _buildStar(4),
            _buildStar(5),
          ],
        ),
      ),
      actionsAlignment: MainAxisAlignment.spaceEvenly,
      actions: <Widget>[
        MyOutlineButton(
          text: 'Cancel',
          onTap: Navigator.of(context).pop,
          width: 110,
        ),
        MyFillButton(
          text: 'Confirm',
          onTap: () {
            Navigator.of(context).pop(_stars);
            Navigator.pushNamed(
              context,
              "/intropage",
            );
          },
          width: 110,
        ),
      ],
    );
  }
}
