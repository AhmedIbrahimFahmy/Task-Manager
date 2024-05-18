import 'package:flutter_test/flutter_test.dart';
import 'package:task_manager/services/network/database.dart';

void main() {
  test("Create Task", () async {
    String todo = "Adding New Task";
    int uid = 1;
    dynamic result = await Database().AddNewTask(todo: todo, userId: uid);
    if(result is! String){
      expect(result["todo"], todo);
    }
  });

  test("Read Tasks", () async {
    int uid = 1;
    dynamic result = await Database().GetUserTasks(id: uid, skip: 0, limit: 5);
    if(result is! String){
      List<dynamic> todosJson = result["todos"];
      for (var element in todosJson) {
        expect(element["userId"], uid);
      }
    }
  });

  test("Update Task", () async {
    int taskId = 1;
    bool completed = true;
    dynamic result = await Database().UpdateTask(taskId: taskId, completed: completed);
    if(result is! String){
      expect(result["completed"], completed);
    }
  });

  test("Delete Task", () async {
    int taskId = 1;
    dynamic result = await Database().DeleteTask(taskId: taskId);
    if(result is! String){
      expect(result["isDeleted"], true);
    }
  });
}
