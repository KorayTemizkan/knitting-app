import 'package:flutter/material.dart';
import 'package:knitting_app/controllers/app_bar.dart';

class SssView extends StatelessWidget {
  const SssView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: 'Sık Sorulan Sorular'),

      body: Column(children: [Text('SSS!')]),
    );
  }
}
