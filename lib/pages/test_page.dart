import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_boarding_space/data/country.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  double rectHeight = 50;
  List<Country> searchResult = [];
  Country currCountry = Country.MY;

  final ItemScrollController itemScrollController = ItemScrollController();
  final TextEditingController countrySearchController = TextEditingController();

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

    currCountry = Country.MY;
    searchResult.addAll(Country.values);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'MeoWoof Land',
          style: TextStyle(
            color: Colors.grey[900],
          ),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              AnimatedSize(
                curve: Curves.easeIn,
                duration: const Duration(milliseconds: 100),
                child: Container(
                  height: 252,
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Theme.of(context).dividerColor,
                      ),
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    children: [
                      // search bar container
                      Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          height: 50,
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                  color: Theme.of(context).dividerColor),
                            ),
                          ),
                          child: Row(
                            children: [
                              // search icon
                              Icon(
                                Icons.search_outlined,
                                color: Colors.grey[600],
                                size: 28,
                              ),

                              const SizedBox(width: 12),
                              // search text field
                              Expanded(
                                child: TextField(
                                  scrollPadding: EdgeInsets.only(
                                    bottom: MediaQuery.of(context)
                                            .viewInsets
                                            .bottom +
                                        10 * 4,
                                  ),
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
                                    index: searchResult.indexWhere(
                                      (e) =>
                                          e.countryCode ==
                                          currCountry.countryCode,
                                    ),
                                  ),
                                  onChanged: (text) {
                                    setState(() {
                                      searchResult = Country.values
                                          .where((e) => getCountryText(e)
                                              .toLowerCase()
                                              .contains(text.toLowerCase()))
                                          .toList();
                                    });
                                  },
                                ),
                              ),
                            ],
                          )),
                      // country list container
                      Container(
                        height: 200,
                        child: ScrollablePositionedList.builder(
                          itemScrollController: itemScrollController,
                          itemCount: searchResult.length,
                          itemBuilder: (context, index) {
                            Country country = searchResult[index];

                            // single country container
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  currCountry = country;
                                  searchResult.clear();
                                  searchResult.addAll(Country.values);
                                  countrySearchController.clear();
                                  itemScrollController.jumpTo(index: 0);
                                  FocusScope.of(context)
                                      .requestFocus(FocusNode());
                                });
                              },
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 12),
                                height: 50,
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                        color: Theme.of(context).dividerColor),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    // flag icon
                                    Text(
                                      countryCodeToEmoji(country.countryCode),
                                      style: GoogleFonts.notoColorEmoji(),
                                    ),

                                    const SizedBox(width: 20),
                                    // country text
                                    Text(
                                      getCountryText(country),
                                      style: GoogleFonts.nunitoSans(
                                          fontWeight: FontWeight.w700),
                                    )
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
              ElevatedButton(
                onPressed: () => itemScrollController.jumpTo(
                    index:
                        searchResult.indexWhere((e) => e.countryCode == "MY")),
                child: const Text("Jump to Malaysia"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
