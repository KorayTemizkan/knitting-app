import 'package:flutter/material.dart';
import 'package:knitting_app/controllers/api_services.dart';
import 'package:knitting_app/models/tutorial_model.dart';

class TutorialProvider extends ChangeNotifier {
  List<TutorialModel> _howTos = [];
  bool _isLoading = false;

  List<TutorialModel> get howTos => _howTos;
  bool get isLoading => _isLoading;

  Future<void> loadHowTos() async {
    _isLoading = true;
    notifyListeners();

    _howTos = await fetchHowTos();

    _isLoading = false;
    notifyListeners();
  }

  
  Future<List<TutorialModel>> loadWantedHowTos(List<int> idList) async {
    List<TutorialModel> wantedHowTos = [];

    for (var product in _howTos) {
      if (idList.contains(product.id)) {
        wantedHowTos.add(product);
      }
    }

    return wantedHowTos;
  }
}
