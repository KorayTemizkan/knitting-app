import 'package:flutter/material.dart';
import 'package:knitting_app/controllers/api_services.dart';
import 'package:knitting_app/models/knitting_cafe_model.dart';

class KnittingCafeProvider extends ChangeNotifier {
  List<KnittingCafeModel> _knittingCafes = [];
  bool _isLoading = false;

  List<KnittingCafeModel> get knittingCafes => _knittingCafes;
  bool get isLoading => _isLoading;

  Future<void> loadKnittingCafes() async {
    _isLoading = true;
    notifyListeners();

    _knittingCafes = await fetchKnittingCafes();

    _isLoading = false;
    notifyListeners();
  }
}
