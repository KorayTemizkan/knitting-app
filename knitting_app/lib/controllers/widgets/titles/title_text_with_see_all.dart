import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:knitting_app/controllers/router.dart';

class TitleWithSeeAll extends StatelessWidget {
  final String text;
  final String routeSource;
  const TitleWithSeeAll({super.key, required this.text, this.routeSource = ''});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: TextStyle(
              color: Color(0xFF1E1E1E),
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),

          TextButton(
            onPressed: () {
              context.go(AppRoutes.seeAll, extra: 'patterns');
            },
            style: TextButton.styleFrom(foregroundColor: Color(0xFFFF5722)),
            child: Text(
              "Tümünü Gör",
              style: TextStyle(
                color: Color(0xFFFF5722),
                fontSize: 16,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
