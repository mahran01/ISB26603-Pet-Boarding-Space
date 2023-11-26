import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_boarding_space/components/date_time_picker.dart';
import 'package:pet_boarding_space/components/drop_down_list.dart';
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
  late bool inBeforeOutOrFirstTime;
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

  bool durationTooShort(Duration duration) {
    return !(duration.inDays > 0 ||
        duration.inHours > 0 ||
        duration.inMinutes >= 30);
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

  void confirmModalBottomSheet(BuildContext context) {
    showModalBottomSheet<dynamic>(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext bc) {
        return Container(
          height: 476,
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
          child: Column(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Container(
                      height: 4,
                      width: 40,
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 12.0, vertical: 8.0),
                          child: Icon(Icons.person),
                        ),
                        Text(
                          "User detail",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ],
                    ),
                    Table(
                      columnWidths: const {
                        0: IntrinsicColumnWidth(),
                        1: FlexColumnWidth(),
                      },
                      defaultVerticalAlignment: TableCellVerticalAlignment.top,
                      children: [
                        TableRow(
                          children: [
                            // Padding(
                            //   padding: const EdgeInsets.all(8.0),
                            //   child: Text("Name"),
                            // ),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Text("Name"),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Text(nameController.text),
                            ),
                          ],
                        ),
                        TableRow(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Text("Address"),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Text(addressController.text),
                            ),
                          ],
                        ),
                        TableRow(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Text("Phone no."),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Text(countryCodeController.text +
                                  phoneNoController.text),
                            ),
                          ],
                        ),
                        TableRow(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Text("Email"),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Text(emailController.text),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 12.0, vertical: 10.0),
                          child: Image.asset(
                            "lib/images/${catIsSelected ? 'cat' : 'dog'}_small_white.png",
                            height: 18,
                          ),
                        ),
                        Text(
                          "${catIsSelected ? 'Cat' : 'Dog'} detail",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ],
                    ),
                    Table(
                      columnWidths: const {
                        0: IntrinsicColumnWidth(),
                        1: FlexColumnWidth(),
                      },
                      defaultVerticalAlignment: TableCellVerticalAlignment.top,
                      children: [
                        TableRow(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child:
                                  Text("${catIsSelected ? 'Cat' : 'Dog'} name"),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Text(petNameController.text),
                            ),
                          ],
                        ),
                        TableRow(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Text(
                                "${catIsSelected ? 'Cat' : 'Dog'} age",
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Text(
                                  "${petAgeController.text} year${petAgeController.text != '1' ? 's' : ''} old"),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // button row ----------------------------------------------------
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(
                      150,
                      50,
                    ),
                    side: BorderSide(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  child: const Text('Cancel'),
                  onPressed: () => Navigator.pop(context),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(
                      150,
                      50,
                    ),
                    primary: Theme.of(context).primaryColor,
                  ),
                  child: Text(
                    'Confirm',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: validateForm,
                ),
              ])
            ],
          ),
        );
      },
    );
  }

  void validateForm() {
    Navigator.pop(context);
    bool petIsSelected = catIsSelected || dogIsSelected;
    DateTime checkin = dateTime['checkin']!;
    DateTime checkout = dateTime['checkout']!;
    inBeforeOutOrFirstTime = checkin.isBefore(checkout);
    if (inBeforeOutOrFirstTime) {
      Duration duration = checkout.difference(checkin);
      inBeforeOutOrFirstTime =
          inBeforeOutOrFirstTime && !durationTooShort(duration);
    }
    setState(() {});

    if (_formKey.currentState!.validate() &&
        petIsSelected &&
        inBeforeOutOrFirstTime) {
      submitForm();
    } else {}
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

    if (departureDateTime.isBefore(checkInDateTime)) return;

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
    inBeforeOutOrFirstTime = true;
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
    String catOrDog = catIsSelected
        ? "Cat"
        : dogIsSelected
            ? "Dog"
            : "Pet";
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
                  style: TextStyle(
                    color: phoneIsValidOrFirstTime
                        ? Theme.of(context).indicatorColor
                        : Theme.of(context).colorScheme.error,
                  ),
                ),
                const SizedBox(height: 10),

                MyDropDownList(
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

                // pet detail starts here ######################################
                Text(
                  "$catOrDog details",
                  style: GoogleFonts.nunitoSans(fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 10),
                // pet name text field -----------------------------------------
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

                // pet age text field ------------------------------------------
                TextFormField(
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
                const Text("Check-in date & time"),

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
                const Text("Check-out date & time"),

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
                  durationTooShort(dateTime['checkout']!
                          .difference(dateTime['checkin']!))
                      ? 'Duration should be longer than 30 minutes'
                      : 'Invalid check-in and check-out',
                  style: !inBeforeOutOrFirstTime
                      ? Theme.of(context)
                          .textTheme
                          .labelMedium
                          ?.copyWith(color: Theme.of(context).colorScheme.error)
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
