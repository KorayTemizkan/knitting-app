import 'package:flutter/material.dart';

class InfoCard extends StatelessWidget {
  final Icon icon;
  final String text;

  const InfoCard({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 1),
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            icon,
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                text,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),

            Icon(color: Color(0xFFFF5722), Icons.arrow_right),
          ],
        ),
      ),
    );
  }
}
