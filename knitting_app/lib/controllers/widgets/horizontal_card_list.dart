import 'package:flutter/material.dart';

class HorizontalCardList extends StatelessWidget {
  final int itemCount;
  final double height;
  final double cardWidthRatio;
  final Widget Function(BuildContext, int) itemBuilder;

  const HorizontalCardList({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
    required this.height,
    this.cardWidthRatio = 0.6, // ekranın %60'ı
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return SizedBox(
      height: height,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: itemCount,
        itemBuilder: (context, index) {
          return SizedBox(
            width: screenWidth * cardWidthRatio,
            child: itemBuilder(context, index),
          );
        },
      ),
    );
  }
}
