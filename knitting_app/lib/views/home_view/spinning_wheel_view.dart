import 'package:flutter/material.dart';
import 'package:knitting_app/controllers/app_bar.dart';

class SpinningWheelView extends StatefulWidget {
  const SpinningWheelView({super.key});

  @override
  State<SpinningWheelView> createState() => _SpinningWheelViewState();
}

class _SpinningWheelViewState extends State<SpinningWheelView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: 'Çark Çevir'),

      body: Placeholder(),

      // https://pub.dev/packages/flutter_fortune_wheel
    );
  }
}