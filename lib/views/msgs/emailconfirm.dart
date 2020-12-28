import 'package:flutter/material.dart';

class EmailConfirmation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text('An email confirmation has been sent to your address'),
          )
        ],
      ),
    );
  }
}
