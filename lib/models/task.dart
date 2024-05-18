class Task {
  int id;
  String todo;
  bool completed;
  int userId;

  Task({
    required this.id,
    required this.completed,
    required this.todo,
    required this.userId,
});

  static Task FromJson(json) => Task(
      id: json["id"],
      completed: json["completed"],
      todo: json["todo"],
      userId: json["userId"]
  );
}