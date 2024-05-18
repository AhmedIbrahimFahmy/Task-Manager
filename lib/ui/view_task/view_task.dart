import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:task_manager/cubit/task/cubit.dart';
import 'package:task_manager/cubit/task/states.dart';
import 'package:task_manager/models/task.dart';
import 'package:task_manager/shared/components/components.dart';

class ViewTask extends StatelessWidget {
  final int index;
  ViewTask({required this.index});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskCubit, TaskStates>(
      builder: (context, state){
        Task task = TaskCubit.get(context).myTasks[index];
        return Scaffold(
          backgroundColor: Colors.teal,
          appBar: AppBar(backgroundColor: Colors.teal,),
          body: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Row(
                  textDirection: TextDirection.rtl,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        await TaskCubit.get(context).UpdateTask(
                            index: index,
                            taskId: task.id,
                            completed: !task.completed
                        );
                      },
                      style: ElevatedButton.styleFrom(backgroundColor: task.completed ? Colors.yellow : Colors.green),
                      child: Icon(task.completed ? Icons.hourglass_bottom : Icons.done_all_rounded, color: Colors.black,),
                    ),
                    Gap(10),
                    ElevatedButton(
                      onPressed: () async {
                        NavigateBack(context);
                        await TaskCubit.get(context).DeleteTask(index: index, taskId: task.id);
                      },
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                      child: const Icon(Icons.delete_rounded, color: Colors.black,),
                    ),
                    Spacer(),
                    Container(
                      decoration: BoxDecoration(
                        color: task.completed ? Colors.green : Colors.yellow,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          task.completed ? "completed" : "incomplete",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Gap(10),
                Expanded(
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: task.completed ? Colors.green : Colors.yellow,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "${task.todo}",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 25,
                                ),
                              ),
                            )
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

        );
      }
    );
  }
}
