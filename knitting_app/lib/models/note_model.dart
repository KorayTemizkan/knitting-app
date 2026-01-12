class Note {
  final int id;
  String title;
  String note;
  final DateTime time;

  Note({
    required this.id,
    required this.title,
    required this.note,
    required this.time,
  });

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'title': title,
      'note': note,
      'time': time.millisecondsSinceEpoch,
    };
  }
  
  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['id'] as int,
      title: map['title'] as String,
      note: map['note'] as String,
      time: DateTime.fromMicrosecondsSinceEpoch(map['time'] as int),
    );
  }
  
   @override
  String toString() {
    return 'Note{id: $id, title: $title, note: $note, time: $time}';
  }
}
