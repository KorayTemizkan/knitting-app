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

  Future<List<KnittingCafeModel>> loadWantedKnittingCafes(List<int> idList) async {
    List<KnittingCafeModel> wantedKnittingCafes = [];

    for (var product in _knittingCafes) {
      if (idList.contains(product.id)) {
        wantedKnittingCafes.add(product);
      }
    }

    return wantedKnittingCafes;
  }
}
