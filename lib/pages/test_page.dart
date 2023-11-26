import 'package:flutter/material.dart';

class TestPage extends StatelessWidget {
  const TestPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _inputController = TextEditingController();
    return Scaffold(
        body: SafeArea(
      child: Center(
        child: Column(children: [
          TextField(controller: _inputController),
          ValueListenableBuilder<TextEditingValue>(
            valueListenable: _inputController,
            builder: (context, value, child) {
              return ElevatedButton(
                onPressed: value.text.isNotEmpty ? () {} : null,
                child: Text('I am disabled when text is empty'),
              );
            },
          ),
        ]),
      ),
    ));
  }
}
