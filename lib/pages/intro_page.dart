import 'package:flutter/material.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //Text
              //Button
              GestureDetector(
                onTap: () => Navigator.pushNamed(context, "/userformpage"),
                child: Container(
                  decoration: BoxDecoration(color: Colors.black),
                  padding: const EdgeInsets.all(25),
                  child: Text(
                    "BOOK NOW",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
