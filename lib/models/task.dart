class Task {
  int id;
  String body;
  int status;

  Task({
    required this.id,
    required this.status,
    required this.body,
  });

  static Task FromJson(json) => Task(
        id: json["id"],
        status: json["status"],
        body: json["body"],
      );
}
