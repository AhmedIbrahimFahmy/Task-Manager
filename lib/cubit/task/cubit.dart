import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/cubit/task/states.dart';
import 'package:task_manager/cubit/user/cubit.dart';
import 'package:task_manager/models/task.dart';
import 'package:task_manager/services/local/cache_helper.dart';
import 'package:task_manager/services/network/database.dart';
import 'package:task_manager/shared/components/components.dart';

class TaskCubit extends Cubit<TaskStates> {
  TaskCubit() : super(TaskInitialState());

  static TaskCubit get(context) => BlocProvider.of(context);

  List<Task> myTasks = [];
  int total = 0;
  int skip = 0;
  int limit = 5;
  List<String> tasksId = [];
  List<String> tasksTodo = [];
  List<String> tasksUserId = [];
  List<String> tasksCompleted = [];

  void ClearMyTasks(){
    myTasks.clear();
    total = 0;
    skip = 0;
    limit = 5;
    emit(ClearMyTasksState());
  }

  Future GetUserOnlineTasks(context) async {
    dynamic result = await Database().GetUserTasks(
        id: UserCubit.get(context).myUser!.id!, skip: skip, limit: limit);

    List<dynamic> todosJson = result["todos"];
    for (var element in todosJson) {
      myTasks.add(Task.FromJson(element));
    }

    total = result["total"];
    skip = myTasks.length;
    limit = min(5, total - skip);


    // Store the online Tasks in local database
     tasksId = [];
     tasksTodo = [];
     tasksUserId = [];
     tasksCompleted = [];

    for(var element in myTasks){
      tasksId.add(element.id.toString());
      tasksCompleted.add(element.completed.toString());
      tasksUserId.add(element.userId.toString());
      tasksTodo.add(element.todo);
    }
    await CacheHelper.SetTasksId(tasksId: tasksId);
    await CacheHelper.SetTasksCompleted(tasksCompleted: tasksCompleted);
    await CacheHelper.SetTasksTodo(tasksTodo: tasksTodo);
    await CacheHelper.SetTasksUserId(tasksUserId: tasksUserId);

    // print(total);
    // print(skip);
    // print(limit);

    emit(GetUserOnlineTasksState());
  }

  void GetUserLocalTasks(context){
    tasksId = CacheHelper.GetKeyListValue(key: "tasksId");
    tasksTodo = CacheHelper.GetKeyListValue(key: "tasksTodo");
    tasksUserId = CacheHelper.GetKeyListValue(key: "tasksUserId");
    tasksCompleted = CacheHelper.GetKeyListValue(key: "tasksCompleted");
    myTasks.clear();

    for(int i=0; i < tasksId.length; i++){
      myTasks.add(
          Task(
              id: int.parse(tasksId[i]),
              completed: bool.parse(tasksCompleted[i]),
              todo: tasksTodo[i],
              userId: int.parse(tasksUserId[i]),
          )
      );
    }
    limit = 0;
    total = myTasks.length;
    skip = myTasks.length;
    emit(GetUserLocalTasksState());
  }


  Future AddTask({
    required String todo,
    required int userId,
  }) async {
    emit(AddTaskOnProgressState());
    dynamic result = await Database().AddNewTask(userId: userId, todo: todo);
    if (result is String) {
      myToast(message: result, backgroundColor: Colors.red);
      emit(AddTaskFailedState());
      return;
    }
    myTasks.add(Task.FromJson(result));

    // add the new task to local database
    tasksId.add(result["id"].toString());
    tasksTodo.add(result["todo"]);
    tasksUserId.add(result["userId"].toString());
    tasksCompleted.add(result["completed"].toString());

    await CacheHelper.SetTasksId(tasksId: tasksId);
    await CacheHelper.SetTasksCompleted(tasksCompleted: tasksCompleted);
    await CacheHelper.SetTasksTodo(tasksTodo: tasksTodo);
    await CacheHelper.SetTasksUserId(tasksUserId: tasksUserId);

    myToast(message: "New Task has been Added", backgroundColor: Colors.green);
    emit(AddTaskFinishedState());
  }

  Future UpdateTask({
    required int index,
    required int taskId,
    required bool completed,
  }) async {
    emit(UpdateTaskOnProgressState());
    dynamic result = await Database().UpdateTask(taskId: taskId, completed: completed);

    if(result is String){
      myToast(message: result, backgroundColor: Colors.red);
      emit(UpdateTaskFailedState());
      return;
    }
    myTasks[index].completed = completed;

    // update the task to local database
    tasksCompleted[index] = completed.toString();
    await CacheHelper.SetTasksCompleted(tasksCompleted: tasksCompleted);

    myToast(message: "The Task has been Updated", backgroundColor: Colors.green);
    emit(UpdateTaskFinishedState());
  }

  Future DeleteTask({
    required int index,
    required int taskId,
}) async {
    emit(DeleteTaskOnProgressState());
    dynamic result = await Database().DeleteTask(taskId: taskId);
    if(result is String){
      myToast(message: result, backgroundColor: Colors.red);
      emit(DeleteTaskFailedState());
      return;
    }
    myTasks.removeAt(index);

    // Delete the task form local database
    tasksCompleted.removeAt(index);
    tasksUserId.removeAt(index);
    tasksTodo.removeAt(index);
    tasksId.removeAt(index);

    await CacheHelper.SetTasksId(tasksId: tasksId);
    await CacheHelper.SetTasksCompleted(tasksCompleted: tasksCompleted);
    await CacheHelper.SetTasksTodo(tasksTodo: tasksTodo);
    await CacheHelper.SetTasksUserId(tasksUserId: tasksUserId);

    myToast(message: "The Task has been Deleted", backgroundColor: Colors.green);
    emit(DeleteTaskFinishedState());
  }
}
