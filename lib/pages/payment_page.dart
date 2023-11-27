import 'package:flutter/material.dart';
import 'package:pet_boarding_space/models/boarding_space.dart';
import 'package:pet_boarding_space/models/pet.dart';
import 'package:pet_boarding_space/models/user.dart';
import 'package:pet_boarding_space/data/data.dart';
import 'package:pet_boarding_space/models/discount.dart';

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
  late double discount;
  late double totalPayment;

  void applyDiscount() {
    setState(() {
      String inputCode = discountController.text;
      bool isValid = AssignedValues.discounts.containsKey(inputCode);
      if (isValid) {
        discountAvailable = true;
        discount = AssignedValues.discounts[inputCode]!.getDiscount(totalRate);
        totalPayment = totalRate - discount;
        print(totalPayment);
      } else {
        discountAvailable = false;
        discount = 0;
        totalPayment = totalRate;
      }
    });
  }

  double calculateRate(User user, BoardingSpace bs) {
    double total = 0.0;

    Duration duration = user.departureDateTime.difference(user.checkInDateTime);
    int day = duration.inDays;
    int hour = duration.inHours - (day * 24);
    int minute = duration.inMinutes - (duration.inHours * 60);

    total += day * bs.dailyRates;
    total += hour * (bs.hourlyRates);
    total += minute >= 30 ? bs.hourlyRates : 0;

    return total;
  }

  @override
  void initState() {
    super.initState();
    discountController = TextEditingController();

    totalRate = 0.0;
    discountAvailable = false;
    discount = 0.0;
    totalPayment = 0.0;
  }

  @override
  Widget build(BuildContext context) {
    Map<String, Object> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, Object>;

    user = args["User"] as User;
    bs = args["BoardingSpace"] as BoardingSpace;

    totalRate = calculateRate(user, bs);
    totalPayment = totalRate - discount;

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                    child: Icon(Icons.person),
                  ),
                  Text(
                    "User detail",
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontWeight: FontWeight.w900),
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
                        child: Text(user.name),
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
                        child: Text(user.address),
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
                        child: Text(user.countryCode + user.phoneNo),
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
                        child: Text(user.email),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 25),
              Row(
                children: [
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
                    child: Image.asset(
                      "lib/images/${user.pet.petType.value.toLowerCase()}_small_white.png",
                      height: 18,
                    ),
                  ),
                  Text(
                    "${user.pet.petType.value} detail",
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontWeight: FontWeight.w900),
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
                        child: Text("${user.pet.petType.value} name"),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(user.pet.name),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(
                          "${user.pet.petType.value} age",
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(
                            "${user.pet.age} year${user.pet.age != '1' ? 's' : ''} old"),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 25),
              Row(
                children: [
                  const Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                    child: Icon(Icons.date_range),
                  ),
                  Text(
                    "Boarding Detail",
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontWeight: FontWeight.w900),
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
                        child: Text("Check in"),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(user.checkInDateTime.toString()),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text("Check out"),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(user.departureDateTime.toString()),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 25),
              Row(
                children: [
                  const Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                    child: Icon(Icons.house),
                  ),
                  Text(
                    "Boarding space information",
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontWeight: FontWeight.w900),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 100,
                    width: 150,
                    child: Image.asset(
                      bs.imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Table(
                      columnWidths: const {
                        0: IntrinsicColumnWidth(),
                        1: IntrinsicColumnWidth(),
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
                              padding: const EdgeInsets.only(
                                left: 5.0,
                                bottom: 5.0,
                              ),
                              child: Text("Name"),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 5.0,
                                bottom: 5.0,
                              ),
                              child: Text(bs.name),
                            ),
                          ],
                        ),
                        TableRow(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Text("Hourly"),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Text(bs.hourlyRates.toString()),
                            ),
                          ],
                        ),
                        TableRow(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Text("Daily"),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Text(bs.dailyRates.toString()),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 35),
              Row(
                children: [
                  const Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                    child: Icon(Icons.payment),
                  ),
                  Text(
                    "Payment Detail",
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontWeight: FontWeight.w900),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(
                    height: 60,
                    width: 210,
                    child: TextField(
                      controller: discountController,
                      scrollPadding: EdgeInsets.only(
                        bottom:
                            MediaQuery.of(context).viewInsets.bottom + 16 * 4,
                      ),
                      maxLines: null,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        labelText: 'Discount',
                        hintText: 'Enter discount code ...',
                      ),
                    ),
                  ),
                  SizedBox(width: 30),
                  SizedBox(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        fixedSize: const Size(
                          110,
                          50,
                        ),
                        side: BorderSide(
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      child: Text('Apply'),
                      onPressed: applyDiscount,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20, top: 45),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Total Rate:'),
                        Text('RM ${totalRate.toStringAsFixed(2)}'),
                      ],
                    ),
                    SizedBox(height: 10),
                    SizedBox(
                      height: discountAvailable ? null : 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Discount:'),
                          Text('- RM ${discount.toStringAsFixed(2)}'),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total Payment:',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(fontWeight: FontWeight.w900),
                        ),
                        Text(
                          'RM ${totalPayment.toStringAsFixed(2)}',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(fontWeight: FontWeight.w900),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        fixedSize: const Size(
                          200,
                          50,
                        ),
                        primary: Theme.of(context).primaryColor,
                      ),
                      child: Text(
                        'Rate',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return RatingDialog();
                          },
                        );
                      }),
                ],
              ),
              SizedBox(height: 100)
            ],
          ),
        ),
      ),
    );
  }
}

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
      title: Center(
        child: Text('Rate your experience'),
      ),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _buildStar(1),
          _buildStar(2),
          _buildStar(3),
          _buildStar(4),
          _buildStar(5),
        ],
      ),
      actions: <Widget>[
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            fixedSize: const Size(
              110,
              50,
            ),
            side: BorderSide(
              color: Theme.of(context).primaryColor,
            ),
          ),
          child: Text('CANCEL'),
          onPressed: Navigator.of(context).pop,
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            fixedSize: const Size(
              110,
              50,
            ),
            primary: Theme.of(context).primaryColor,
          ),
          child: Text(
            'NEXT',
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () {
            Navigator.of(context).pop(_stars);
            Navigator.pushNamed(
              context,
              "/intropage",
            );
          },
        )
      ],
    );
  }
}
