import 'package:hive/hive.dart';
import 'package:knitting_app/models/searchable_model.dart';

part 'pattern_model.g.dart';

@HiveType(typeId: 0)
class PatternModel implements Searchable {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String difficulty;

  @HiveField(3)
  final String estimatedHour;

  @HiveField(4)
  final List<String> colors;

  @HiveField(5)
  final String yarnType;

  @HiveField(6)
  final String hookSize;

  @HiveField(7)
  final String imageUrl;

  @HiveField(8)
  final String videoUrl; // JSON'dan boş string veya link gelecek

  PatternModel({
    required this.id,
    required this.title,
    required this.difficulty,
    required this.estimatedHour,
    required this.colors,
    required this.yarnType,
    required this.hookSize,
    required this.imageUrl,
    required this.videoUrl,
  });

  /// JSON (Map) -> Model
  factory PatternModel.fromMap(Map<String, dynamic> map) {
    return PatternModel(
      id: map["id"] ?? 0,
      title: map["title"] ?? "",
      difficulty: map["difficulty"] ?? "",
      estimatedHour: map["estimatedHour"] ?? "",
      colors: List<String>.from(map["colors"] ?? []),
      yarnType: map["yarnType"] ?? "",
      hookSize: map["hookSize"] ?? "",
      imageUrl: map["imageUrl"] ?? "",
      videoUrl:
          map["videoUrl"] ?? "", // Boş gelirse patlamasın diye default değer
    );
  }

  /// Model -> JSON (Map)
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "title": title,
      "difficulty": difficulty,
      "estimatedHour": estimatedHour,
      "colors": colors,
      "yarnType": yarnType,
      "hookSize": hookSize,
      "imageUrl": imageUrl,
      "videoUrl": videoUrl,
    };
  }

  @override
  String get searchableText => title;

  @override
  String? get searchableSubtitle => '$difficulty • $estimatedHour';
}
