import 'package:flutter/material.dart';

class TitleWithIcon extends StatelessWidget {
  final String title;
  final IconData icon;
  const TitleWithIcon({super.key, required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(icon, color: Color(0xFFFF5722), size: 24),

          SizedBox(width: 8),

          Text(
            title,
            style: TextStyle(
              color: Color(0xFF1E1E1E),
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
