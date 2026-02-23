import 'package:flutter/material.dart';

class TitleText extends StatelessWidget {
  final String text;
  const TitleText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 16),

      child: Text(
        text,
        style: TextStyle(
          color: Color(0xFF1E1E1E),
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
