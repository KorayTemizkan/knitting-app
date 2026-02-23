import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:knitting_app/controllers/widgets/cards/info_card.dart';

// Değişkenleri final tanımlamak performans ve güvenilirlik açısıdan önemlidir.
class MyGestureButton extends StatelessWidget {
  final String upperRoute;
  final String route;
  final String text;
  final IconData icon;

  const MyGestureButton({
    super.key,
    required this.upperRoute,
    required this.route,
    required this.text,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.go(
        '/$upperRoute/$route',
      ), // her seferinde ${} yapmana gerek yok, tek değişkense $ yeterli
      child: InfoCard(
        icon: Icon(icon, color: Color(0xFFFF5722)),
        text: text,
      ),
    );
    ;
  }
}
