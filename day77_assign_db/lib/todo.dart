class Todo {
  final int? id;
  final String task;
  final bool isCompleted;

  Todo({
    this.id,
    required this.task,
    this.isCompleted = false,
  });

  // Convert a Todo into a Map (SQLite expects a Map)
  Map<String, dynamic> toJson() {
    return {
      'task': task,
      'isCompleted': isCompleted ? 1 : 0,  // SQLite stores booleans as integers
    };
  }

  // Convert a Map into a Todo object (SQLite data)
  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      id: json['id'],
      task: json['task'],
      isCompleted: json['isCompleted'] == 1,  // Convert integer back to boolean
    );
  }

  Todo copyWith({
    String? task,
    bool? isCompleted,
  }) {
    return Todo(
      id: id,
      task: task ?? this.task,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}
