class Note {
  final String id;
  final String title;
  final String content;
  final String colorTag;

  Note({
    required this.id,
    required this.title,
    required this.content,
    this.colorTag = "white",
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'colorTag': colorTag,
    };
  }

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['id'],
      title: map['title'],
      content: map['content'],
      colorTag: map['colorTag'] ?? "white",
    );
  }
}