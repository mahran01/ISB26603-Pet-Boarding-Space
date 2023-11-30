import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pet_boarding_space/components/my_fill_button.dart';
import 'package:pet_boarding_space/components/my_outline_button.dart';
import 'package:pet_boarding_space/components/my_table.dart';
import 'package:pet_boarding_space/components/rating_dialog.dart';
import 'package:pet_boarding_space/models/boarding_space.dart';
import 'package:pet_boarding_space/models/user.dart';
import 'package:pet_boarding_space/data/data.dart';
import 'package:pet_boarding_space/theme/texts.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  late TextEditingController discountController;

  late User user;
  late BoardingSpace bs;
  late double totalRate;
  late bool discountAvailable;
  late bool discountErrDisplay;
  late double discount;
  late double totalPayment;
  late bool showCheckoutChange;
  late bool dismissCheckoutChange;
  late DateTime newDapartureDateTime;

  void applyDiscount() {
    FocusManager.instance.primaryFocus?.unfocus();
    setState(() {
      String inputCode = discountController.text.toUpperCase();
      bool isValid = AssignedValues.discounts.containsKey(inputCode);
      if (isValid) {
        discountAvailable = true;
        discount = AssignedValues.discounts[inputCode]!.getDiscount(totalRate);
        totalPayment = totalRate - discount;
      } else {
        discountAvailable = false;
        discount = 0;
        totalPayment = totalRate;
      }
      discountErrDisplay = !discountAvailable;
    });
  }

  double calculateRate(User user, BoardingSpace bs) {
    double total = 0.0;

    Duration duration = user.departureDateTime.difference(user.checkInDateTime);
    int day = duration.inDays;
    int hour = duration.inHours % 24;
    int minute = duration.inMinutes % 60;

    total += hour * (bs.hourlyRates);
    total += minute >= 30 ? bs.hourlyRates : 0;

    /*
     * Set customer total hourly rate to daily rate and auto set departure date 
     * to a day. This is because if customer were to stay for 20 hours and the 
     * rate is higher than one day rate, then better to book for a day and leave
     * sooner than departure date.
     */
    if (bs.dailyRates <= total) {
      total = bs.dailyRates;
      newDapartureDateTime = user.checkInDateTime.add(
        Duration(days: duration.inDays + 1),
      );
      showCheckoutChange = true;
    } else {
      showCheckoutChange = false;
    }

    total += day * bs.dailyRates;

    return total;
  }

  @override
  void initState() {
    super.initState();
    discountController = TextEditingController();

    totalRate = 0.0;
    discountAvailable = false;
    discountErrDisplay = false;
    discount = 0.0;
    totalPayment = 0.0;
    showCheckoutChange = false;
    newDapartureDateTime = DateTime(0);
    dismissCheckoutChange = false;
  }

  @override
  Widget build(BuildContext context) {
    Map<String, Object> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, Object>;

    user = args["User"] as User;
    bs = args["BoardingSpace"] as BoardingSpace;
    newDapartureDateTime = user.departureDateTime;

    totalRate = calculateRate(user, bs);
    totalPayment = totalRate - discount;

    Row buildTextHeader(icon, String text) {
      return Row(
        children: [
          Padding(padding: const EdgeInsets.all(18.0), child: icon),
          Text(text, style: Theme.of(context).textTheme.titleMedium),
        ],
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Payment detail"),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildTextHeader(
              const Icon(Icons.person),
              "User detail",
            ),
            MyTable(data: {
              "Name": user.name,
              "Address": user.address,
              "Phone no": user.countryCode + user.phoneNo,
              "Email": user.email,
            }),
            buildTextHeader(
                ImageIcon(
                  AssetImage(
                    "lib/images/${user.pet.petType.value.toLowerCase()}_small_white.png",
                  ),
                ),
                "${user.pet.petType.value} detail"),
            MyTable(data: {
              "${user.pet.petType.value} name": user.pet.name,
              "${user.pet.petType.value} age":
                  "${user.pet.age} year${user.pet.age != 1 ? 's' : ''} old",
            }),
            buildTextHeader(
              const Icon(Icons.date_range),
              "Boarding Detail",
            ),
            MyTable(data: {
              "Check-in":
                  DateFormat.yMEd().add_jm().format(user.checkInDateTime),
              "Check-out":
                  DateFormat.yMEd().add_jm().format(newDapartureDateTime),
            }),
            Container(
              height: showCheckoutChange && !dismissCheckoutChange ? null : 0,
              margin: const EdgeInsets.all(8),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(2)),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      "Due to your check-out date & time will cost the same as above, we set it later so can have flexibility when picking up your pet.",
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    onPressed: () =>
                        setState(() => dismissCheckoutChange = true),
                    child: const Text(
                      "OK",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            buildTextHeader(
              const Icon(Icons.house),
              "Boarding space information",
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      image: DecorationImage(
                        image: AssetImage(bs.imageUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                    height: 101,
                    width: 150,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: MyTable(data: {
                        "Name": bs.name,
                        "Hourly": "RM ${bs.hourlyRates.toStringAsFixed(2)}",
                        "Daily": "RM ${bs.dailyRates.toStringAsFixed(2)}",
                      }, padding: 7.0),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            buildTextHeader(
              const Icon(Icons.payment),
              "Payment Detail",
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 50,
                          child: TextField(
                            controller: discountController,
                            scrollPadding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).viewInsets.bottom +
                                  16 * 4,
                            ),
                            maxLines: null,
                            keyboardType: TextInputType.text,
                            decoration: const InputDecoration(
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 2),
                              labelText: 'Discount',
                              hintText: 'Enter discount code ...',
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      MyOutlineButton(
                        text: 'Apply',
                        onTap: applyDiscount,
                        width: 110,
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "Invalid discount code",
                    style: discountErrDisplay
                        ? Theme.of(context).textTheme.labelMedium?.copyWith(
                            color: Theme.of(context).colorScheme.error)
                        : const TextStyle(height: 0, fontSize: 0),
                  ),
                  const SizedBox(height: 5),
                  // TODO: voucher card display
                  Container(
                    width: double.infinity,
                    height: 50,
                    color: Colors.white.withOpacity(0.1),
                    // child: Row(children: [Text]),
                  ),
                  const SizedBox(height: 25),
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Total Rate:'),
                            Text(
                              'RM ${totalRate.toStringAsFixed(2)}',
                              style: numberSmallText,
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          height: discountAvailable ? null : 0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Discount:'),
                              Text(
                                '- RM ${discount.toStringAsFixed(2)}',
                                style: numberSmallText,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total Payment:',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            Text(
                              'RM ${totalPayment.toStringAsFixed(2)}',
                              style: numberMediumText,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                  Center(
                    child: MyFillButton(
                      text: "Rate",
                      onTap: () => showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return RatingDialog();
                        },
                      ),
                      width: 200,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 50)
          ],
        ),
      ),
    );
  }
}
