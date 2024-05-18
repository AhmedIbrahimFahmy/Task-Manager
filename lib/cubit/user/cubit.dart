import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/cubit/user/states.dart';
import 'package:task_manager/models/user.dart';

class UserCubit extends Cubit<UserStates>{
  UserCubit(): super(UserInitialState());

  static UserCubit get(context) => BlocProvider.of(context);

  UserModel? myUser;

  Future GetUserData(json) async {
    myUser = UserModel.FromJson(json);
    emit(UserGetAllData());
  }

  void ClearUserData() {
    myUser!.token = null;
    myUser!.id = null;
    emit(UserClearData());
  }

}