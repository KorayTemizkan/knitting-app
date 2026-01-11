/// Aranabilir modeller için abstract class
/// Herhangi bir model bu interface'i implement ederek 
/// SearchAnchorBar widget'ında kullanılabilir hale gelir
abstract class Searchable {
  /// Arama için kullanılacak metin (örn: title, name)
  String get searchableText;
  
  /// Arama sonucunda gösterilecek alt başlık (opsiyonel)
  String? get searchableSubtitle => null;
}
