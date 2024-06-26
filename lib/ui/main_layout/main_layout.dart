import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/cubit/task/cubit.dart';
import 'package:task_manager/cubit/task/states.dart';
import 'package:task_manager/ui/my_tasks/my_tasks.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {

  @override
  void initState() {
    super.initState();
    TaskCubit.get(context).GetUserLocalTasks();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskCubit, TaskStates>(
      builder: (context, state){
        return Scaffold(
          backgroundColor: Colors.teal,
          appBar: AppBar(
            backgroundColor: Colors.teal[300],
            elevation: 10,
            leadingWidth: 60,
            title: const Text(
              "Task Manager",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
          ),
          body: const MyTasks(),
        );
      }
    );
  }

}
