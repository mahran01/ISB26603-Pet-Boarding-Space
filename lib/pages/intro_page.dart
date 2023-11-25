import 'package:flutter/material.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Image.asset(
            'lib/images/petintro.jpg',
            fit: BoxFit.fill,
            height: double.infinity,
            width: double.infinity,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 400,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.black.withOpacity(1),
                    Colors.black.withOpacity(0.7),
                    Colors.black.withOpacity(0.025),
                  ],
                ),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Text("Meow Woof",
                  style: Theme.of(context).textTheme.headlineLarge),
              const SizedBox(height: 5),
              Text("We will help you give the best \n experiences for your pet",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge),
              const SizedBox(height: 30),
              Align(
                alignment: Alignment.bottomCenter,
                child: GestureDetector(
                  onTap: () => Navigator.pushNamed(context, "/userformpage"),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black,
                      border: Border.all(color: Theme.of(context).primaryColor),
                    ),
                    padding: const EdgeInsets.all(25),
                    child: Text("START BOOKING"),
                  ),
                ),
              ),
              const SizedBox(height: 70),
            ],
          ),
        ],
      ),
    );
  }
}
