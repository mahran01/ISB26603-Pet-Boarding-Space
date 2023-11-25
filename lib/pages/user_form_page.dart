import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_boarding_space/components/drop_down_list.dart';
import 'package:pet_boarding_space/components/pet_card.dart';
import 'package:pet_boarding_space/models/pet.dart';
import 'package:pet_boarding_space/models/user.dart';
import 'package:pet_boarding_space/controllers/input_validator.dart';

class UserFormPage extends StatefulWidget {
  const UserFormPage({super.key});

  @override
  State<UserFormPage> createState() => _UserFormPageState();
}

class _UserFormPageState extends State<UserFormPage> {
  final _formKey = GlobalKey<FormState>();

  late bool phoneIsValid;
  late bool catIsSelected;
  late bool dogIsSelected;
  late String phoneErrorMessage;
  late bool formIsValid;

  late TextEditingController nameController;
  late TextEditingController addressController;
  late TextEditingController countryCodeController;
  late TextEditingController phoneNoController;
  late TextEditingController emailController;
  late TextEditingController petNameController;
  late TextEditingController petAgeController;

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

  void submitForm() {
    String name;
    String address;
    String countryCode;
    String phoneNo;
    String email;

    PetType petType;
    String petName;
    int petAge;

    DateTime checkInDt;
    DateTime departureDt;

    // TODO: need to review
    name = nameController.text;
    address = addressController.text;

    // TODO: need to review
    countryCode = countryCodeController.text;
    phoneNo = phoneNoController.text;

    // TODO: need to review
    email = emailController.text;

    // TODO: need to review
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

  String? nameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter your name";
    } else if (!value.isValidName) {
      return "Please enter valid name";
    }
    return null;
  }

  String? addressValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter your address";
    } else if (!value.isValidAddress) {
      return "Please enter valid address";
    }
    return null;
  }

  String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter your email";
    } else if (!value.isValidEmail) {
      return "Please enter valid email";
    }
    return null;
  }

  String? phoneNoValidator(String? value) {
    if (value == null || value.isEmpty) {
      phoneIsValid = false;
      phoneErrorMessage = "Please enter your phone number";
      return "";
    } else if (!value.isValidPhone) {
      phoneIsValid = false;
      phoneErrorMessage = "Please enter valid phone number";
      return "";
    }
    phoneErrorMessage = "";
    phoneIsValid = true;
    return null;
  }

  String? petAgeValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter your age";
    } else if (!value.isValidAge) {
      return "Please enter valid age";
    }
    return null;
  }

  void validateForm() {
    bool petIsSelected = catIsSelected || dogIsSelected;
    setState(() {});

    if (_formKey.currentState!.validate() && petIsSelected) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Processing Data')),
      );
    } else {}
  }

  @override
  void initState() {
    super.initState();

    nameController = TextEditingController();
    addressController = TextEditingController();
    countryCodeController = TextEditingController();
    phoneNoController = TextEditingController();
    emailController = TextEditingController();
    petNameController = TextEditingController();
    petAgeController = TextEditingController();
    phoneIsValid = true;
    catIsSelected = false;
    dogIsSelected = false;
    phoneErrorMessage = "";
    formIsValid = false;
  }

  @override
  void dispose() {
    nameController.dispose();
    addressController.dispose();
    countryCodeController.dispose();
    phoneNoController.dispose();
    emailController.dispose();
    petNameController.dispose();
    petAgeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String catOrDog = catIsSelected
        ? "Cat"
        : dogIsSelected
            ? "Dog"
            : "Pet";
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
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),

              /* ------------------------------Depression-----------------------
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
                  // user detail starts here ###################################

                  // name text field -------------------------------------------
                  TextFormField(
                    controller: nameController,
                    scrollPadding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom + 16 * 4,
                    ),
                    decoration: const InputDecoration(
                      labelText: "Name",
                    ),
                    validator: nameValidator,
                  ),

                  const SizedBox(height: 20),

                  // address text field ----------------------------------------
                  TextFormField(
                    controller: addressController,
                    scrollPadding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom + 16 * 4,
                    ),
                    maxLines: null,
                    decoration: const InputDecoration(
                      labelText: 'Address',
                    ),
                    validator: addressValidator,
                  ),

                  const SizedBox(height: 20),

                  // phone number text field -----------------------------------
                  Text(
                    "Contact number",
                    style: TextStyle(
                      color: phoneIsValid
                          ? Theme.of(context).indicatorColor
                          : Theme.of(context).colorScheme.error,
                    ),
                  ),
                  const SizedBox(height: 10),

                  MyDropDownList(
                    countryCodeController: countryCodeController,
                    phoneNoController: phoneNoController,
                    phoneNoValidator: phoneNoValidator,
                    isValid: phoneIsValid,
                  ),

                  Text(
                    phoneErrorMessage,
                    style: !phoneIsValid
                        ? Theme.of(context).textTheme.labelMedium?.copyWith(
                            color: Theme.of(context).colorScheme.error)
                        : const TextStyle(height: 0),
                  ),
                  // email text field ------------------------------------------
                  TextFormField(
                    controller: emailController,
                    scrollPadding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom - 16 * 4,
                    ),
                    decoration: const InputDecoration(
                      labelText: 'Email',
                    ),
                    validator: emailValidator,
                  ),

                  const SizedBox(height: 20),

                  // pet selector ----------------------------------------------
                  Text(
                    "Choose your pet",
                    // TODO: Change into theme font
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

                  // pet detail starts here ####################################
                  Text(
                    "$catOrDog details",
                    style: GoogleFonts.nunitoSans(fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 10),
                  // TODO: pet name text field ---------------------------------
                  TextFormField(
                    controller: petNameController,
                    scrollPadding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom + 16 * 4,
                    ),
                    decoration: InputDecoration(
                      labelText: "$catOrDog Name",
                    ),
                    validator: nameValidator,
                  ),

                  const SizedBox(height: 20),

                  // TODO: pet age text field ----------------------------------
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: petAgeController,
                    scrollPadding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom + 16 * 4,
                    ),
                    decoration: InputDecoration(
                      labelText: "$catOrDog Age (Year/s)",
                    ),
                    validator: petAgeValidator,
                  ),

                  // check in & out starts here ################################

                  // TODO: check in field --------------------------------------

                  // TODO: check out field -------------------------------------

                  const SizedBox(height: 30),

                  // form submission button ####################################
                  Row(
                    children: [
                      const Expanded(child: Text("")),
                      ElevatedButton(
                        onPressed: () =>
                            Navigator.pushNamed(context, "/intropage"),
                        child: const Text("Back"),
                      ),
                      const SizedBox(width: 20),
                      ElevatedButton(
                        onPressed: formIsValid ? validateForm : null,
                        child: const Text("Submit"),
                      ),
                    ],
                  ),

                  // TODO: testing purpose #####################################
                  const SizedBox(height: 50),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
