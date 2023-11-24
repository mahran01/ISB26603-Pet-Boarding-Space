import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_boarding_space/theme/colors.dart';

class PetCard extends StatefulWidget {
  final String text;
  final String image;
  final bool isSelected;
  const PetCard({
    super.key,
    required this.text,
    required this.image,
    required this.isSelected,
  });

  @override
  State<PetCard> createState() => _PetCardState();
}

class _PetCardState extends State<PetCard> {
  @override
  Widget build(BuildContext context) {
    Color primaryColor = Theme.of(context).primaryColor;
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(
                color: widget.isSelected ? primaryColor : Colors.transparent,
                width: 3),
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.all(20),
          child: Image.asset(
            "lib/images/${widget.image}",
          ),
        ),
        const SizedBox(height: 5),
        Text(
          widget.text,
          style: (widget.isSelected
                  ? GoogleFonts.nunitoSans(
                      color: Theme.of(context).primaryColor,
                    )
                  : GoogleFonts.nunitoSans())
              .copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
