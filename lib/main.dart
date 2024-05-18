import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/cubit/login/cubit.dart';
import 'package:task_manager/cubit/task/cubit.dart';
import 'package:task_manager/cubit/user/cubit.dart';
import 'package:task_manager/services/local/cache_helper.dart';
import 'package:task_manager/services/network/authentication.dart';
import 'package:task_manager/ui/login/login.dart';
import 'dart:io';
import 'package:task_manager/ui/main_layout/main_layout.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));

  HttpOverrides.global = MyHttpOverrides();

  await CacheHelper.init();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<LoginCubit>(
          create: (BuildContext context) => LoginCubit(),
        ),
        BlocProvider<UserCubit>(
          create: (BuildContext context) => UserCubit(),
        ),
        BlocProvider<TaskCubit>(
          create: (BuildContext context) => TaskCubit(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget _homeScreen = Scaffold(
    backgroundColor: Colors.teal,
    body: Center(child: CircularProgressIndicator(color: Colors.tealAccent,)),
  );

  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    dynamic token = CacheHelper.GetToken();
    print(token);
    if (token != null) {
      var value = await Authenticate.RefreshToken(token);
      if (value is String) {
        print("Bad Token");
        setState(() {
          _homeScreen = LoginScreen();
        });
      } else {
        print("Good Token");
        await UserCubit.get(context).GetUserData(value);
        await CacheHelper.SetToken(token: value["token"]);
        TaskCubit.get(context).GetUserLocalTasks(context);
        setState(() {
          _homeScreen = MainLayout();
        });
      }
    } else {
      print("Default");
      setState(() {
        _homeScreen = LoginScreen();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: _homeScreen,
    );
  }
}
