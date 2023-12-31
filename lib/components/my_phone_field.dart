import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_boarding_space/data/country.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class MyPhonePicker extends StatefulWidget {
  final TextEditingController countryCodeController;
  final TextEditingController phoneNoController;
  final String? Function(String?)? phoneNoValidator;
  final bool isValid;

  const MyPhonePicker({
    super.key,
    required this.countryCodeController,
    required this.phoneNoController,
    required this.phoneNoValidator,
    this.isValid = true,
  });

  @override
  State<MyPhonePicker> createState() => _MyPhonePickerState();
}

class _MyPhonePickerState extends State<MyPhonePicker> {
  late bool countryListOpen;
  late double countryListHeight;
  late double countryListButtonArrowAngle;
  late Country currCountry;

  late List<Country> countrySearchResult;

  late ItemScrollController itemScrollController;
  late TextEditingController countrySearchController;
  late FocusNode countrySearchFocusNode;

  void expandCountryList() {
    setState(() {
      countryListOpen = !countryListOpen;
      if (countryListOpen) {
        countryListHeight = 252;
        countryListButtonArrowAngle = 180 * math.pi / 180;
        countrySearchFocusNode.requestFocus();
        itemScrollController.jumpTo(
          index: countrySearchResult.indexWhere(
            (e) => e.countryCode == currCountry.countryCode,
          ),
        );
      } else {
        countryListHeight = 0;
        countryListButtonArrowAngle = 0;
        countrySearchFocusNode.unfocus();
        countrySearchController.clear();
        countrySearchResult = [...Country.values];
      }
    });
  }

  String countryCodeToEmoji(String country) {
    int flagOffset = 0x1F1E6;
    int asciiOffset = 0x41;

    int firstChar = country.codeUnitAt(0) - asciiOffset + flagOffset;
    int secondChar = country.codeUnitAt(1) - asciiOffset + flagOffset;

    return String.fromCharCode(firstChar) + String.fromCharCode(secondChar);
  }

  String getCountryText(Country country) =>
      "${country.countryName} (${country.countryCode})";

  @override
  void initState() {
    super.initState();
    countryListOpen = false;
    countryListHeight = 0;
    countryListButtonArrowAngle = 0;
    currCountry = Country.MY;
    widget.countryCodeController.text = Country.MY.phoneNumberCode;

    countrySearchResult = [...Country.values];

    itemScrollController = ItemScrollController();
    countrySearchController = TextEditingController();
    countrySearchFocusNode = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    final Color dividerColor = Theme.of(context).dividerColor;
    final Color errorColor = Theme.of(context).colorScheme.error;
    final Color changingColor = widget.isValid ? dividerColor : errorColor;
    return Column(
      children: [
        // Phone number textfield container ####################################
        Container(
          height: 50,
          decoration: BoxDecoration(
            border: Border.all(color: changingColor),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Country code dropdown button container ************************
              GestureDetector(
                onTap: () => expandCountryList(),
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    border: Border(
                      right: BorderSide(
                        color: changingColor,
                      ),
                    ),
                  ),
                  child: Row(
                    children: [
                      const SizedBox(width: 15),
                      // flag icon ---------------------------------------------
                      Text(countryCodeToEmoji(currCountry.countryCode)),

                      const SizedBox(width: 5),

                      // arrow icon --------------------------------------------
                      Transform.rotate(
                        angle: countryListButtonArrowAngle,
                        child: const Icon(
                          Icons.arrow_drop_down_rounded,
                          size: 30,
                        ),
                      ),
                      const SizedBox(width: 5),
                    ],
                  ),
                ),
              ),

              const SizedBox(width: 10),

              Text(
                currCountry.phoneNumberCode,
                style: GoogleFonts.nunitoSans(
                  color: dividerColor,
                  fontWeight: FontWeight.w700,
                  fontSize: 15,
                ),
              ),

              const SizedBox(width: 5),

              // phone number textfield ****************************************
              Expanded(
                child: TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: widget.phoneNoController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      errorStyle: TextStyle(fontSize: 0)),
                  style: GoogleFonts.nunitoSans(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                  validator: widget.phoneNoValidator,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 10),

        // Search bar container ################################################
        AnimatedSize(
          curve: Curves.easeIn,
          duration: const Duration(milliseconds: 100),
          child: Container(
            height: countryListHeight,
            decoration: BoxDecoration(
                border: Border.all(
                  color: dividerColor,
                ),
                borderRadius: BorderRadius.circular(10)),
            child: Column(
              children: [
                // search bar container ****************************************
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  height: 50,
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: dividerColor),
                    ),
                  ),
                  child: Row(
                    children: [
                      // search icon -------------------------------------------
                      Icon(
                        Icons.search_outlined,
                        color: dividerColor,
                        size: 28,
                      ),

                      const SizedBox(width: 12),
                      // search text field -------------------------------------
                      Expanded(
                        child: TextField(
                          focusNode: countrySearchFocusNode,
                          controller: countrySearchController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: getCountryText(currCountry),
                          ),
                          style: GoogleFonts.nunitoSans(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                          ),
                          onTap: () => itemScrollController.jumpTo(
                            index: countrySearchResult.indexWhere(
                              (e) => e.countryCode == currCountry.countryCode,
                            ),
                          ),
                          onChanged: (text) {
                            setState(() {
                              countrySearchResult = Country.values
                                  .where((e) => getCountryText(e)
                                      .toLowerCase()
                                      .contains(text.toLowerCase()))
                                  .toList();
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),

                // country list container **************************************
                SizedBox(
                  height: 200,
                  child: ScrollablePositionedList.builder(
                    itemScrollController: itemScrollController,
                    itemCount: countrySearchResult.length,
                    itemBuilder: (context, index) {
                      Country country = countrySearchResult[index];

                      // single country container ------------------------------
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            widget.countryCodeController.text =
                                country.phoneNumberCode;
                            currCountry = country;
                            expandCountryList();
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          height: 50,
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: dividerColor,
                              ),
                            ),
                          ),
                          child: Row(
                            children: [
                              // flag icon--------------------------------------
                              Text(countryCodeToEmoji(country.countryCode)),

                              const SizedBox(width: 20),

                              // country text ----------------------------------
                              Text(
                                getCountryText(country),
                                style: GoogleFonts.nunitoSans(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
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
