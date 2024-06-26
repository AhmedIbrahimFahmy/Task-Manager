import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/cubit/task/states.dart';
import 'package:task_manager/models/task.dart';
import 'package:task_manager/services/local/database.dart';
import 'package:task_manager/shared/components/components.dart';

class TaskCubit extends Cubit<TaskStates> {
  TaskCubit() : super(TaskInitialState());

  static TaskCubit get(context) => BlocProvider.of(context);

  List<Task> myTasks = [];
  int total = 0;


  void GetUserLocalTasks() async {
    dynamic list = await LocalDatabase().getTasks();
    myTasks.clear();
    if(list == null)return;
    for (var element in list) {
      myTasks.add(Task.FromJson(element));
    }
    total = myTasks.length;
    emit(GetUserLocalTasksState());
  }


  Future AddTask({
    required String body,
  }) async {
    emit(AddTaskOnProgressState());

    await LocalDatabase().addTask(body).then((value){
      print(value);
      myTasks.add(Task(id: value, status: 0, body: body));
    });


    myToast(message: "New Task has been Added", backgroundColor: Colors.green);
    emit(AddTaskFinishedState());
  }

  Future UpdateTask({
    required int index,
    required int taskId,
    required int status,
    String? body,
  }) async {
    emit(UpdateTaskOnProgressState());

    await LocalDatabase().updateTask(
        id: taskId,
        status: status
    );
    myTasks[index].status = status;

    myToast(message: "The Task has been Updated", backgroundColor: Colors.green);
    emit(UpdateTaskFinishedState());
  }

  Future DeleteTask({
    required int index,
    required int taskId,
}) async {
    emit(DeleteTaskOnProgressState());

    await LocalDatabase().deleteTask(taskId);
    myTasks.removeAt(index);

    myToast(message: "The Task has been Deleted", backgroundColor: Colors.green);
    emit(DeleteTaskFinishedState());
  }
}
