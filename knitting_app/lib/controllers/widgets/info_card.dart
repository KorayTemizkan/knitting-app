import 'package:flutter/material.dart';

class InfoCard extends StatelessWidget {
  final String imageUrl;
  final String text;
  final EdgeInsets margin;
  final VoidCallback? onTap;

  const InfoCard({
    super.key,
    required this.imageUrl,
    required this.text,
    this.margin = const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: margin,
      elevation: 2,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              CircleAvatar(radius: 24, backgroundImage: NetworkImage(imageUrl)),

              const SizedBox(width: 16),

              Expanded(
                child: Text(
                  text,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
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
