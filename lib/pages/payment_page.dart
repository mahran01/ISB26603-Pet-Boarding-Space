import 'package:flutter/material.dart';
import 'package:pet_boarding_space/models/boarding_space.dart';
import 'package:pet_boarding_space/models/pet.dart';
import 'package:pet_boarding_space/models/user.dart';
import 'package:pet_boarding_space/data/data.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  double calculateTotal({
    required DateTime inTime,
    required DateTime outTime,
    required double dailyRates,
    required double hourlyRates,
  }) {
    double total = 0.0;

    Duration duration = inTime.difference(outTime);
    total += duration.inDays * dailyRates;
    total += duration.inHours * hourlyRates;
    total += duration.inMinutes >= 30 ? hourlyRates : 0;

    return total;
  }

  @override
  Widget build(BuildContext context) {
    Map<String, Object> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, Object>;
    User user = args["User"] as User;
    BoardingSpace bs = args["BoardingSpace"] as BoardingSpace;

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
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
            SizedBox(height: 15),
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
            SizedBox(height: 15),
            Row(
              children: [
                const Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                  child: Icon(Icons.house),
                ),
                Text(
                  "Boarding space information",
                  style: Theme.of(context).textTheme.titleMedium,
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
            SizedBox(height: 30),
            Row(
              children: [
                const Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                  child: Icon(Icons.payment),
                ),
                Text(
                  "Payment Detail",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
            TextField(),
          ],
        ),
      ),
    );
  }
}
