

class Note{
  final int? id;
  final String? title;
  final String? body;
  final String? color;

  const Note({required this.id,required this.title,required this.body,required this.color});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'body': body,
      'color':color
    };
  }
}