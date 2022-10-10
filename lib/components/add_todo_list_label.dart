import 'package:flutter/material.dart';

class AddTodoListLabel extends StatelessWidget {
  String label = "";

  AddTodoListLabel({required this.label});

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: TextStyle(fontSize: 18, color: Colors.grey),
    );
  }
}
