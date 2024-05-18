import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/cubit/login/states.dart';
import 'package:task_manager/cubit/task/cubit.dart';
import 'package:task_manager/cubit/user/cubit.dart';
import 'package:task_manager/services/local/cache_helper.dart';
import 'package:task_manager/services/network/authentication.dart';
import 'package:task_manager/shared/components/components.dart';

class LoginCubit extends Cubit<LoginStates>{
  LoginCubit(): super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);

  var UsernameController = TextEditingController();
  var PasswordController = TextEditingController();

  bool isVisable = false;

  void ChangePasswordVisablity (){
    isVisable = !isVisable;
    emit(LoginChangePasswordVisableState());
  }

  Future Login() async {
    emit(LoginOnProgressState());
    dynamic result = await Authenticate.Login(
        UsernameController.text,
        PasswordController.text
    );
    if(result is String){
      emit(LoginFaildState());
      myToast(
        message: result,
        backgroundColor: Colors.redAccent,
      );
    }
    else{
      emit(LoginSuccessState());
      await CacheHelper.SetToken(token: result["token"]);
      myToast(
        message: "Login successful! Welcome aboard!",
        backgroundColor: Colors.green,
      );
      return result;
    }
  }

  Future Logout(context) async {
    UserCubit.get(context).ClearUserData();
    TaskCubit.get(context).ClearMyTasks();
    await CacheHelper.ClearAllData();
    emit(LogoutState());
  }

}