import 'package:flutter/material.dart';
import 'package:knitting_app/controllers/api_services.dart';

class PoliciesProvider extends ChangeNotifier {
  String _privacyPolicy = '';
  bool _isLoading = false;

  String get privacyPolicy => _privacyPolicy;
  bool get isLoading => _isLoading;

  Future<void> loadPrivacyPolicy() async {
    _isLoading = true;
    notifyListeners();

    _privacyPolicy = await fetchPrivacyPolicy();

    _isLoading = false;
    notifyListeners();
  }
}
