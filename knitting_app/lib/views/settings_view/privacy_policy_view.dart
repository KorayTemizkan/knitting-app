import 'package:flutter/material.dart';
import 'package:knitting_app/controllers/app_bar.dart';
import 'package:knitting_app/controllers/providers/policies_provider.dart';
import 'package:provider/provider.dart';

class PrivacyPolicyView extends StatefulWidget {
  const PrivacyPolicyView({super.key});

  @override
  State<PrivacyPolicyView> createState() => _PrivacyPolicyViewState();
}

class _PrivacyPolicyViewState extends State<PrivacyPolicyView> {

  @override
  Widget build(BuildContext context) {
  String policyProvider = context.read<PoliciesProvider>().privacyPolicy;

    return Scaffold(
      appBar: AppBarWidget(title: 'Gizlilik Koşulları'),

      body: Column(
        children: [
          Text('Gizlilik Koşulları'),
          Text(policyProvider),
        ],
      ),
    );
  }
}
