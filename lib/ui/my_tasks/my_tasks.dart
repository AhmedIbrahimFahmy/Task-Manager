import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:task_manager/cubit/task/cubit.dart';
import 'package:task_manager/cubit/task/states.dart';
import 'package:task_manager/cubit/user/cubit.dart';
import 'package:task_manager/shared/components/components.dart';

class MyTasks extends StatefulWidget {
  const MyTasks({super.key});

  @override
  State<MyTasks> createState() => _MyTasksState();
}

class _MyTasksState extends State<MyTasks> {
  var formKey = GlobalKey<FormState>();
  var newTask = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskCubit, TaskStates>(
      builder: (context, state){
        return Scaffold(
          backgroundColor: Colors.teal,
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  ListView.separated(
                    reverse: true,
                    itemBuilder: (context, index) => TaskBuilder(context, index, TaskCubit.get(context).myTasks[index]),
                    separatorBuilder: (context, index) => const Gap(8),
                    itemCount: TaskCubit.get(context).myTasks.length,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                  ),
                  ConditionalBuilder(
                      condition: TaskCubit.get(context).limit > 0,
                      builder: (context) => TextButton(
                        onPressed: (){
                          TaskCubit.get(context).GetUserOnlineTasks(context);
                        },
                        child: Container(
                            decoration: BoxDecoration(
                              color: Colors.teal[900],
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                  "Show more...",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                  ),
                              ),
                            )
                        ),
                      ),
                      fallback: null,
                  ),
                ],
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: (){
                showModalBottomSheet(context: context, builder: (context) => BottomSheetBuilder(context));
            },
            child: const Icon(Icons.add),
            backgroundColor: Colors.tealAccent,
          ),
        );
      }
    );
  }
  Widget BottomSheetBuilder(context) => Container(
    height: MediaQuery.of(context).size.height * 0.5,
    color: Colors.teal[800],
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              myTextFormField(
                  controller: newTask,
                  hint: "what's your goal ?",
                  keyboard: TextInputType.text,
                  validate: (value){
                    if(value!.isEmpty)return "The Task can't be empty";
                    return null;
                  },
              ),
              const Gap(10),
              Row(
                textDirection: TextDirection.rtl,
                children: [
                  Expanded(
                      child: ElevatedButton(
                          onPressed: () async {
                            if(formKey.currentState!.validate()){
                              // add task to database
                              await TaskCubit.get(context).AddTask(
                                  todo: newTask.text,
                                  userId: UserCubit.get(context).myUser!.id!,
                              );
                              NavigateBack(context);
                            }
                          },
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                          child: const Icon(Icons.add, color: Colors.black,),
                      ),
                  ),
                  const Gap(10),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: (){
                        NavigateBack(context);
                      },
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
                      child: const Icon(Icons.cancel, color: Colors.black,),
                    ),
                  ),
                ],
              ),

            ],
          ),
        ),
      ),
    ),
  );
}
