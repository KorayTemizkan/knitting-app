import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:knitting_app/controllers/api_services.dart';
import 'package:knitting_app/controllers/providers/shared_preferences_provider.dart';
import 'package:knitting_app/models/pattern_model.dart';

class PatternProvider extends ChangeNotifier {
  // changenotifier sayesinde notify listeners çağırabiliyoruz
  List<PatternModel> _products = []; // private yaptık ki dışarıdan erişilmesin
  bool _isLoading = false;

  // dış dünyaya kontrollü bir şekilde sadece okuma izni veriyoruz, güzel bir alışkanlık
  List<PatternModel> get products => _products;
  bool get isLoading => _isLoading;

  Future<void> loadProducts(SharedPreferencesProvider spProvider) async {
    _isLoading = true;
    notifyListeners(); // provideri dinleyen tüm widgetler, kendinizi yeniden yükleyin demek

    await fetchAndSyncPatterns(spProvider);
    final patternBox = Hive.box<PatternModel>('patternBox');
    _products = patternBox.values.toList();

    _isLoading = false;
    notifyListeners();
  }

  Future<List<PatternModel>> loadWantedProducts(List<String> idList) async {
    return _products.where((element) => idList.contains(element.id)).toList();
  }
}

/*

provider : durum yönetimi için kullanılan bir yapıdır
veriyi tek bir yerde tutar, birden fazla widgetin aynı veriye erişmesini sağlar ve veri değişince widgetleri otomatik yeniden çizdirir

böylece kod şişmez, veri başka yerde lazım olursa kullanabilirsin, sayfalar arası veri paylaşımı kolaylaşır, test etmesi kolaylaşır

*/
