import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/cubit/login/cubit.dart';
import 'package:task_manager/cubit/task/cubit.dart';
import 'package:task_manager/cubit/task/states.dart';
import 'package:task_manager/cubit/user/cubit.dart';
import 'package:task_manager/cubit/user/states.dart';
import 'package:task_manager/shared/components/components.dart';
import 'package:task_manager/ui/login/login.dart';
import 'package:task_manager/ui/my_tasks/my_tasks.dart';

class MainLayout extends StatelessWidget {
  const MainLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserStates>(
      builder: (context, state1){
        return BlocBuilder<TaskCubit, TaskStates>(
          builder: (context, state2){
            return Scaffold(
              backgroundColor: Colors.teal,
              appBar: AppBar(
                backgroundColor: Colors.teal[300],
                elevation: 10,
                leadingWidth: 60,
                leading: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: CircleAvatar(
                    child: Image.network(UserCubit.get(context).myUser!.image),
                    backgroundColor: Colors.transparent,
                  ),
                ),
                title: Text(
                  UserCubit.get(context).myUser!.username,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                actions: [
                  IconButton(
                      onPressed: () async {
                        await LoginCubit.get(context).Logout(context);
                        NavigateToAsFirstRoute(context, LoginScreen());
                      },
                      icon: Icon(
                        Icons.logout,
                        color: Colors.white,
                      )),
                ],
              ),
              body: MyTasks(),
            );
          }
        );
      },
    );
  }
}
