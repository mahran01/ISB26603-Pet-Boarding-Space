import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math' as math;
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_boarding_space/components/drop_down_list.dart';
import 'package:pet_boarding_space/components/pet_card.dart';
import 'package:pet_boarding_space/data/country.dart';
import 'package:pet_boarding_space/models/pet.dart';
import 'package:pet_boarding_space/models/user.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class UserFormPage extends StatefulWidget {
  const UserFormPage({super.key});

  @override
  State<UserFormPage> createState() => _UserFormPageState();
}

class _UserFormPageState extends State<UserFormPage> {
  late bool catIsSelected;
  late bool dogIsSelected;

  late TextEditingController nameController;
  late TextEditingController addressController;
  late TextEditingController emailController;

  void submitForm() {
    String name;
    String address;
    String countryCode;
    String phoneNo;
    String email;

    PetType petType;
    String petName;
    int petAge; // TODO: change it to year and month later

    DateTime checkInDt;
    DateTime departureDt;

    // TODO: need to review
    name = nameController.text;
    address = addressController.text;

    // TODO: implement proper code
    countryCode = "+60";
    phoneNo = "194153459";

    // TODO: need to review
    email = emailController.text;

    petType = catIsSelected ? PetType.cat : PetType.dog;

    // TODO: implement proper code
    petName = "Neko-chaan";
    petAge = 2;

    // TODO: implement proper code
    checkInDt = DateTime.now();
    departureDt = DateTime.now();

    Pet pet = Pet(name: petName, petType: petType, age: petAge);
    User user = User(
      name: name,
      address: address,
      countryCode: countryCode,
      phoneNo: phoneNo,
      email: email,
      checkInDt: checkInDt,
      departureDt: departureDt,
      pet: pet,
    );

    Navigator.pushNamed(context, "/spacelistpage", arguments: user);
  }

  void chooseCat() {
    setState(() {
      catIsSelected = true;
      dogIsSelected = false;
      FocusManager.instance.primaryFocus?.unfocus();
    });
  }

  void chooseDog() {
    setState(() {
      catIsSelected = false;
      dogIsSelected = true;
      FocusManager.instance.primaryFocus?.unfocus();
    });
  }

  @override
  void initState() {
    super.initState();

    nameController = TextEditingController();
    addressController = TextEditingController();
    emailController = TextEditingController();
    catIsSelected = false;
    dogIsSelected = false;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      onPanDown: (_) => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'MeoWoof Land',
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),

            /* ------------------------------Depression-------------------------
            child: ScrollablePositionedList.builder(
              itemCount: 5,
              itemScrollController: itemScrollController,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return TextFormField(
                    decoration: const InputDecoration(
                      labelText: "Name",
                    ),
                    validator: (String? value) {
                      return value;
                    },
                    onTap: () => itemScrollController.scrollTo(
                        index: 0, duration: const Duration(milliseconds: 100)),
                  );
                } else if (index == 1) {
                  return TextFormField(
                    maxLines: null,
                    decoration: const InputDecoration(
                      labelText: 'Address',
                    ),
                    validator: (String? value) {
                      return value;
                    },
                    onTap: () => itemScrollController.scrollTo(
                        index: 1, duration: const Duration(milliseconds: 100)),
                  );
                } else if (index == 2) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      // phone number text field container
                      Text(
                        "Contact number",
                        style:
                            GoogleFonts.nunitoSans(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),

                      GestureDetector(
                        onTap: () => itemScrollController.scrollTo(
                            index: 2,
                            duration: const Duration(milliseconds: 100)),
                        child: MyDropDownList(),
                      ),
                    ],
                  );
                } else if (index == 3) {
                  // email text field
                  return TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Email',
                    ),
                    validator: (String? value) {
                      return value;
                    },
                  );
                } else if (index == 4) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      Text(
                        "Choose your pet",
                        style:
                            GoogleFonts.nunitoSans(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                  onTap: chooseCat,
                                  child: PetCard(
                                    text: "Cat",
                                    image: "cat.png",
                                    isSelected: catIsSelected,
                                  )),
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                              child: GestureDetector(
                                  onTap: chooseDog,
                                  child: PetCard(
                                    text: "Dog",
                                    image: "dog.png",
                                    isSelected: dogIsSelected,
                                  )),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 1000),
                    ],
                  );
                }
                return const SizedBox(height: 1000);
              },
            */

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // user detail starts here #####################################

                // name text field ---------------------------------------------
                TextFormField(
                  controller: nameController,
                  scrollPadding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom + 16 * 4,
                  ),
                  decoration: const InputDecoration(
                    labelText: "Name",
                  ),
                  validator: (String? value) {
                    return value;
                  },
                ),

                const SizedBox(height: 20),

                // address text field ------------------------------------------
                TextFormField(
                  controller: addressController,
                  scrollPadding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom + 16 * 4,
                  ),
                  maxLines: null,
                  decoration: const InputDecoration(
                    labelText: 'Address',
                  ),
                  validator: (String? value) {
                    return value;
                  },
                ),

                const SizedBox(height: 20),

                // phone number text field -------------------------------------
                Text(
                  "Contact number",
                  style: GoogleFonts.nunitoSans(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),

                const MyDropDownList(),

                // email text field --------------------------------------------
                TextFormField(
                  controller: emailController,
                  scrollPadding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom - 16 * 4,
                  ),
                  decoration: const InputDecoration(
                    labelText: 'Email',
                  ),
                  validator: (String? value) {
                    return value;
                  },
                ),

                const SizedBox(height: 20),

                // pet selector ------------------------------------------------
                Text(
                  "Choose your pet",
                  style: GoogleFonts.nunitoSans(fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 10),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                            onTap: chooseCat,
                            child: PetCard(
                              text: "Cat",
                              image: "cat.png",
                              isSelected: catIsSelected,
                            )),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: GestureDetector(
                            onTap: chooseDog,
                            child: PetCard(
                              text: "Dog",
                              image: "dog.png",
                              isSelected: dogIsSelected,
                            )),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // pet detail starts here ######################################

                // TODO: pet name text field -----------------------------------

                // TODO: pet age text field ------------------------------------

                // check in & out starts here ##################################

                // TODO: check in field ----------------------------------------

                // TODO: check out field ---------------------------------------

                // form submission #############################################
                Row(
                  children: [
                    const Expanded(child: Text("")),
                    ElevatedButton(
                      onPressed: () {},
                      child: Text("Back"),
                    ),
                    const SizedBox(width: 20),
                    ElevatedButton(
                      onPressed: submitForm,
                      child: Text("Submit"),
                    ),
                  ],
                ),

                // TODO: testing purpose #######################################
                const SizedBox(height: 1000),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
