import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pet_boarding_space/components/date_time_picker.dart';
import 'package:pet_boarding_space/components/my_fill_button.dart';
import 'package:pet_boarding_space/components/my_outline_button.dart';
import 'package:pet_boarding_space/components/my_phone_field.dart';
import 'package:pet_boarding_space/components/my_table.dart';
import 'package:pet_boarding_space/components/pet_card.dart';
import 'package:pet_boarding_space/models/pet.dart';
import 'package:pet_boarding_space/models/user.dart';
import 'package:pet_boarding_space/extension/input_validator.dart';

class UserFormPage extends StatefulWidget {
  const UserFormPage({super.key});

  @override
  State<UserFormPage> createState() => _UserFormPageState();
}

class _UserFormPageState extends State<UserFormPage> {
  final _formKey = GlobalKey<FormState>();

  late bool phoneIsValidOrFirstTime;
  late bool catIsSelected;
  late bool dogIsSelected;
  late String phoneErrorMessage;
  late bool timeIsValid;
  late String timeErrorMessage;
  late bool formIsValid;
  final Map<String, DateTime> dateTime = {
    "checkin": DateTime.now(),
    "checkout": DateTime.now(),
  };

  late TextEditingController nameController;
  late TextEditingController addressController;
  late TextEditingController countryCodeController;
  late TextEditingController phoneNoController;
  late TextEditingController emailController;
  late TextEditingController petNameController;
  late TextEditingController petAgeController;
  late TextEditingController checkinDateController;
  late TextEditingController checkinTimeController;
  late TextEditingController checkoutDateController;
  late TextEditingController checkoutTimeController;

  Duration getDuration() {
    return dateTime['checkout']!.difference(dateTime['checkin']!);
  }

  bool durationTooShort() {
    return getDuration().inMinutes < 30;
  }

  Row buildTextHeader(icon, String text) {
    return Row(
      children: [
        Padding(padding: const EdgeInsets.all(18.0), child: icon),
        Text(text, style: Theme.of(context).textTheme.titleMedium),
      ],
    );
  }

  void chooseCat() {
    setState(() {
      catIsSelected = true;
      dogIsSelected = false;
      FocusManager.instance.primaryFocus?.unfocus();
      setFormIsValid();
    });
  }

  void chooseDog() {
    setState(() {
      catIsSelected = false;
      dogIsSelected = true;
      FocusManager.instance.primaryFocus?.unfocus();
      setFormIsValid();
    });
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
      phoneIsValidOrFirstTime = false;
      phoneErrorMessage = "Please enter your phone number";
      return "";
    } else if (!value.isValidPhone) {
      phoneIsValidOrFirstTime = false;
      phoneErrorMessage = "Please enter valid phone number";
      return "";
    }
    phoneErrorMessage = "";
    phoneIsValidOrFirstTime = true;
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

  void setFormIsValid() {
    final bool name = nameController.text.isNotEmpty;
    final bool address = addressController.text.isNotEmpty;
    final bool email = emailController.text.isNotEmpty;
    final bool phoneNo = phoneNoController.text.isNotEmpty;
    final bool petName = petNameController.text.isNotEmpty;
    final bool petAge = petAgeController.text.isNotEmpty;
    final bool checkinDate = checkinDateController.text.isNotEmpty;
    final bool checkinTime = checkinTimeController.text.isNotEmpty;
    final bool checkoutDate = checkoutDateController.text.isNotEmpty;
    final bool checkoutTime = checkoutTimeController.text.isNotEmpty;

    setState(() => formIsValid = name &&
        address &&
        email &&
        phoneNo &&
        (catIsSelected || dogIsSelected) &&
        petName &&
        petAge &&
        checkinDate &&
        checkinTime &&
        checkoutDate &&
        checkoutTime);
  }

  void clearWhitespace() {
    nameController.text = nameController.text.trim();
    addressController.text = addressController.text.trim();
    petNameController.text = petNameController.text.trim();
  }

  void validateTime() {
    DateTime currTime = DateTime.now().add(const Duration(minutes: 5));
    timeIsValid = false;
    if (dateTime["checkin"]!.isBefore(currTime)) {
      timeErrorMessage = "Invalid check-in time";
    } else if (getDuration().inMinutes < 0) {
      timeErrorMessage = "Check-out should be after check-in";
    } else if (getDuration().inMinutes < 30) {
      timeErrorMessage = "Duration should be more than 30 minutes";
    } else {
      timeIsValid = true;
    }
  }

  void confirmModalBottomSheet(BuildContext context) {
    validateTime();
    clearWhitespace();

    String name;
    String address;
    String countryCode;
    String phoneNo;
    String email;

    PetType petType;
    String petName;
    int petAge;

    DateTime checkInDateTime;
    DateTime departureDateTime;

    name = nameController.text;
    address = addressController.text;
    countryCode = countryCodeController.text;
    phoneNo = phoneNoController.text;
    email = emailController.text;

    petType = catIsSelected ? PetType.cat : PetType.dog;

    petName = petNameController.text;
    petAge = int.parse(petAgeController.text);

    checkInDateTime = dateTime["checkin"]!;
    departureDateTime = dateTime["checkout"]!;

    Pet pet = Pet(name: petName, petType: petType, age: petAge);
    User user = User(
      name: name,
      address: address,
      countryCode: countryCode,
      phoneNo: phoneNo,
      email: email,
      checkInDateTime: checkInDateTime,
      departureDateTime: departureDateTime,
      pet: pet,
    );

    showModalBottomSheet<dynamic>(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext bc) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Wrap(
            children: [
              Center(
                child: Container(
                  height: 4,
                  width: 40,
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
              Column(
                children: [
                  const SizedBox(height: 20),
                  // user detail ###############################################
                  buildTextHeader(
                    const Icon(Icons.person),
                    "User detail",
                  ),
                  MyTable(
                    data: {
                      "Name": user.name,
                      "Address": user.address,
                      "Phone no": user.countryCode + user.phoneNo,
                      "Email": user.email,
                    },
                    padding: 10,
                  ),
                  buildTextHeader(
                      ImageIcon(
                        AssetImage(
                          "lib/images/${user.pet.petType.value.toLowerCase()}_small_white.png",
                        ),
                      ),
                      "${user.pet.petType.value} detail"),
                  MyTable(
                    data: {
                      "${user.pet.petType.value} name": user.pet.name,
                      "${user.pet.petType.value} age":
                          "${user.pet.age} year${user.pet.age != 1 ? 's' : ''} old",
                    },
                    padding: 10,
                  ),
                  buildTextHeader(
                    const Icon(Icons.date_range),
                    "Boarding Detail",
                  ),
                  MyTable(
                    data: {
                      "Check-in": DateFormat.yMEd()
                          .add_jm()
                          .format(user.checkInDateTime),
                      "Check-out": DateFormat.yMEd()
                          .add_jm()
                          .format(user.departureDateTime),
                    },
                    padding: 10,
                  ),

                  const SizedBox(height: 30),

                  // button row ----------------------------------------------------
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      MyOutlineButton(
                        text: 'Cancel',
                        onTap: () => Navigator.pop(context),
                      ),
                      const SizedBox(width: 10),
                      MyFillButton(
                        text: 'Confirm',
                        onTap: () => setState(() => validateForm(user)),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  void validateForm(User user) {
    setState(() {
      Navigator.pop(context);
      bool petIsSelected = catIsSelected || dogIsSelected;
      validateTime();
      if (_formKey.currentState!.validate() && petIsSelected && timeIsValid) {
        submitForm(user);
      }
    });
  }

  void submitForm(User user) {
    Navigator.pushNamed(context, "/spacelistpage", arguments: user);
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
    checkinDateController = TextEditingController();
    checkinTimeController = TextEditingController();
    checkoutDateController = TextEditingController();
    checkoutTimeController = TextEditingController();

    nameController.addListener(setFormIsValid);
    addressController.addListener(setFormIsValid);
    phoneNoController.addListener(setFormIsValid);
    emailController.addListener(setFormIsValid);
    petNameController.addListener(setFormIsValid);
    petAgeController.addListener(setFormIsValid);
    checkinDateController.addListener(setFormIsValid);
    checkinTimeController.addListener(setFormIsValid);
    checkoutDateController.addListener(setFormIsValid);
    checkoutTimeController.addListener(setFormIsValid);

    phoneIsValidOrFirstTime = true;
    catIsSelected = false;
    dogIsSelected = false;
    phoneErrorMessage = "";
    timeIsValid = true;
    timeErrorMessage = "";
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
    checkinDateController.dispose();
    checkinTimeController.dispose();
    checkoutDateController.dispose();
    checkoutTimeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String catOrDog = catIsSelected ? "Cat" : (dogIsSelected ? "Dog" : "Pet");
    return Scaffold(
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // user detail starts here ###################################
                const SizedBox(height: 20),
                Text(
                  "User details",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                // name text field -------------------------------------------
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
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
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: addressController,
                  scrollPadding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom + 16 * 4,
                  ),
                  maxLines: null,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    labelText: 'Address',
                  ),
                  validator: addressValidator,
                ),

                const SizedBox(height: 20),

                // phone number text field -----------------------------------
                Text(
                  "Contact number",
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: phoneIsValidOrFirstTime
                            ? Theme.of(context).indicatorColor
                            : Theme.of(context).colorScheme.error,
                      ),
                ),
                const SizedBox(height: 10),

                MyPhonePicker(
                  countryCodeController: countryCodeController,
                  phoneNoController: phoneNoController,
                  phoneNoValidator: phoneNoValidator,
                  isValid: phoneIsValidOrFirstTime,
                ),

                Text(
                  phoneErrorMessage,
                  style: !phoneIsValidOrFirstTime
                      ? Theme.of(context)
                          .textTheme
                          .labelMedium
                          ?.copyWith(color: Theme.of(context).colorScheme.error)
                      : const TextStyle(height: 0, fontSize: 0),
                ),

                // email text field ------------------------------------------
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
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
                  style: Theme.of(context).textTheme.bodyLarge,
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
                Text(
                  "$catOrDog details",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),

                const SizedBox(height: 10),
                // pet name text field -----------------------------------------
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
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

                // pet age text field ------------------------------------------
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  keyboardType: TextInputType.number,
                  controller: petAgeController,
                  scrollPadding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom + 16 * 4,
                  ),
                  decoration: InputDecoration(
                    labelText: "$catOrDog Age",
                  ),
                  validator: petAgeValidator,
                ),

                const SizedBox(height: 20),
                // check in & out starts here ##################################

                // check in field ----------------------------------------------
                Text(
                  "Check-in date & time",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),

                const SizedBox(height: 5),

                MyDateTimePicker(
                  dateController: checkinDateController,
                  firstDate: DateTime.now(),
                  timeController: checkinTimeController,
                  map: dateTime,
                  mapKey: "checkin",
                ),

                const SizedBox(height: 20),

                // check out field ---------------------------------------------
                Text(
                  "Check-out date & time",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),

                const SizedBox(height: 5),

                MyDateTimePicker(
                  dateController: checkoutDateController,
                  firstDate: dateTime['checkin']!,
                  timeController: checkoutTimeController,
                  map: dateTime,
                  mapKey: "checkout",
                ),

                const SizedBox(height: 10),

                // time error message ------------------------------------------
                Text(
                  timeErrorMessage,
                  style: !timeIsValid
                      ? Theme.of(context)
                          .textTheme
                          .labelMedium!
                          .copyWith(color: Theme.of(context).colorScheme.error)
                      : const TextStyle(height: 0, fontSize: 0),
                ),

                const SizedBox(height: 30),

                // form submission button ######################################
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
                      onPressed: formIsValid
                          ? () => confirmModalBottomSheet(context)
                          : null,
                      child: const Text("Submit"),
                    ),
                  ],
                ),

                const SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
