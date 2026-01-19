import 'package:flutter/material.dart';
import 'package:knitting_app/controllers/app_bar.dart';

class TermsOfUseView extends StatefulWidget {
  const TermsOfUseView({super.key});

  @override
  State<TermsOfUseView> createState() => _TermsOfUseViewState();
}

class _TermsOfUseViewState extends State<TermsOfUseView> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: AppBarWidget(title: 'Terms of Use'),

      body: Column(
        children: [
          Text('Kullanım koşulları'),
          Text('Burası da Gizlilik Politikası sayfası gibi olucak'),
        ],
      ),
    );
  }
}