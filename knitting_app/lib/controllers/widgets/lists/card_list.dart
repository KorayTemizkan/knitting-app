import 'package:flutter/material.dart';

class CardList extends StatelessWidget {
  final List<Widget> widgets;
  CardList({super.key, required this.widgets});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      margin: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: widgets),
    );
  }
}
