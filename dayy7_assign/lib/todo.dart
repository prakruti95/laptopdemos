class Todo {
  final String task;
  final bool isCompleted;

  Todo({
    required this.task,
    this.isCompleted = false,
  });

  Todo copyWith({
    String? task,
    bool? isCompleted,
  }) {
    return Todo(
      task: task ?? this.task,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}