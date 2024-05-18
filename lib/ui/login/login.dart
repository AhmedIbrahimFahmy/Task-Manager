import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:task_manager/cubit/login/cubit.dart';
import 'package:task_manager/cubit/login/states.dart';
import 'package:task_manager/cubit/task/cubit.dart';
import 'package:task_manager/cubit/user/cubit.dart';
import 'package:task_manager/cubit/user/states.dart';
import 'package:task_manager/shared/components/components.dart';
import 'package:task_manager/ui/main_layout/main_layout.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginStates>(builder: (context, state1) {
      return BlocBuilder<UserCubit, UserStates>(
        builder: (context, state2) => Scaffold(
          backgroundColor: Colors.teal,
          appBar: AppBar(
            backgroundColor: Colors.teal,
          ),
          body: SizedBox(
            width: double.infinity,
            child: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const Text(
                        "Task Manager",
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Gap(30),
                      const Text(
                        "Login to the App",
                        style: TextStyle(
                          fontSize: 25,
                        ),
                      ),
                      const Gap(30),
                      myTextFormField(
                          controller:
                              LoginCubit.get(context).UsernameController,
                          hint: "Username",
                          validate: (value) {
                            if (value!.isEmpty) {
                              return "Username can't be empty";
                            }
                            return null;
                          }),
                      const Gap(20),
                      myTextFormField(
                          controller:
                              LoginCubit.get(context).PasswordController,
                          hint: "Password",
                          isSecure: LoginCubit.get(context).isVisable,
                          suffix: (LoginCubit.get(context).isVisable
                              ? Icons.visibility_off
                              : Icons.visibility),
                          suffixCallback: () {
                            LoginCubit.get(context).ChangePasswordVisablity();
                          },
                          validate: (value) {
                            if (value!.isEmpty) {
                              return "Password can't be empty";
                            }
                            return null;
                          }),
                      const Gap(50),
                      ElevatedButton(
                        onPressed: state1 is LoginOnProgressState
                            ? null
                            : () async {
                                if (formKey.currentState!.validate()) {
                                  dynamic result =
                                      await LoginCubit.get(context).Login();
                                  if (result != null) {
                                    NavigateToAsFirstRoute(
                                        context, MainLayout());
                                    await UserCubit.get(context)
                                        .GetUserData(result);
                                    await TaskCubit.get(context)
                                        .GetUserOnlineTasks(context);
                                  }
                                }
                              },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.tealAccent),
                        child: state1 is LoginOnProgressState
                            ? CircularProgressIndicator(color: Colors.tealAccent,)
                            : Text(
                                "LOGIN",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.teal,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
