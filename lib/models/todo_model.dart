class ToDo {
  final int userId;
  final int id;
  final String title;
  final bool completed;

  ToDo({
    required this.userId,
    required this.id,
    required this.title,
    required this.completed,
  });

  factory ToDo.fromJson(Map<String, dynamic> json) {
    return ToDo(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
      completed: json['completed'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'id': id,
      'title': title,
      'completed': completed,
    };
  }
}