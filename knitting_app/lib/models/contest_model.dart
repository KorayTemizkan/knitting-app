import 'package:knitting_app/models/searchable_model.dart';

class ContestModel implements Searchable {
  final int id;
  final String title;
  final String content;
  final String difficulty;
  final List<String>
  examplePhotos; // Supabase'den birden fazla fotoğraf indirilecek
  final List<String> rewards; // Ödüller, örn: "+100 tigcikPoint", "abcAward"
  final String dateRange; // Tarih aralığı

  ContestModel({
    required this.id,
    required this.title,
    required this.content,
    required this.difficulty,
    required this.examplePhotos,
    required this.rewards,
    required this.dateRange,
  });

  /// JSON / Map → Model
  factory ContestModel.fromMap(Map<String, dynamic> map) {
    return ContestModel(
      id: map["id"] ?? 0,
      title: map["title"] ?? "",
      content: map["content"] ?? "",
      difficulty: map["difficulty"] ?? "",
      examplePhotos: List<String>.from(map["examplePhotos"] ?? []),
      rewards: List<String>.from(map["rewards"] ?? []),
      dateRange: map["dateRange"] ?? "",
    );
  }

  /// Model → JSON / Map
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "title": title,
      "content": content,
      "difficulty": difficulty,
      "examplePhotos": examplePhotos,
      "rewards": rewards,
      "dateRange": dateRange,
    };
  }

  @override
  String toString() {
    return 'ContestModel{id: $id, title: $title, difficulty: $difficulty, dateRange: $dateRange}';
  }

  // Searchable implementation
  @override
  String get searchableText => title;

  @override
  String? get searchableSubtitle => '$difficulty • $dateRange';
}
