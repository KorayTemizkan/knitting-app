import 'package:flutter/material.dart';
import 'package:knitting_app/controllers/api_services.dart';
import 'package:knitting_app/models/contest_model.dart';

class ContestProvider extends ChangeNotifier {
  List<ContestModel> _contests = [];
  ContestModel? _currentContest;
  bool _isLoading = false;

  List<ContestModel> get contests => _contests;
  ContestModel get currentContest => _currentContest!;
  bool get isLoading => _isLoading;

  Future<void> loadContests() async {
    _isLoading = true;
    notifyListeners();

    _contests = await fetchContests();
    _currentContest = _contests.last;

    _isLoading = false;
    notifyListeners();
  }
}
