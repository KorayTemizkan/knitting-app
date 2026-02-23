class AiResponseModel {
  final int id;
  final String question;
  final String answer;
  final String? imagePath;
  final DateTime time;

  AiResponseModel({
    required this.id,
    required this.question,
    required this.answer,
    required this.imagePath,
    required this.time,
  });

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'question': question,
      'answer': answer,
      'imagePath': imagePath,
      'time': time.millisecondsSinceEpoch,
    };
  }

  factory AiResponseModel.fromMap(Map<String, dynamic> map) {
    return AiResponseModel(
      id: map['id'] as int,
      question: map['question'] as String,
      answer: map['answer'] as String,
      imagePath: map['imagePath'] as String,
      time: DateTime.fromMillisecondsSinceEpoch(map['time'] as int),
    );
  }
}
