import 'package:flutter/material.dart';

class CustomErrorWidget extends StatelessWidget {
final String status;
final String message;
CustomErrorWidget({this.status, this.message});


  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(20)
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(status.toUpperCase(),
                style: TextStyle(
                  fontWeight: FontWeight.bold
                ),
                ),
                // Text(code),
                Text(message,
                textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      );
  }
}