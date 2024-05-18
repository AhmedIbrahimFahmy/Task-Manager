abstract class LoginStates {}

class LoginInitialState extends LoginStates {}

class LoginChangePasswordVisableState extends LoginStates {}

class LoginOnProgressState extends LoginStates {}

class LoginSuccessState extends LoginStates {}

class LoginFaildState extends LoginStates {}

class LogoutState extends LoginStates {}