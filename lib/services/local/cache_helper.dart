import 'package:shared_preferences/shared_preferences.dart';

/*
Keys:
  - token
  - tasksId
  - tasksTodo
  - tasksUserId
  - tasksCompleted
 */

class CacheHelper{
  static SharedPreferences? _sharedPreferences;

  static init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }


  /* Set Methods */

  static Future <bool?> SetToken({
    required String token,
}) async {
    return await _sharedPreferences?.setString("token", token);
  }


  static Future SetTasksId({
    required List<String> tasksId,
}) async {
    return await _sharedPreferences?.setStringList("tasksId", tasksId);
  }

  static Future SetTasksTodo({
    required List<String> tasksTodo,
  }) async {
    return await _sharedPreferences?.setStringList("tasksTodo", tasksTodo);
  }

  static Future SetTasksUserId({
    required List<String> tasksUserId,
  }) async {
    return await _sharedPreferences?.setStringList("tasksUserId", tasksUserId);
  }

  static Future SetTasksCompleted({
    required List<String> tasksCompleted,
  }) async {
    return await _sharedPreferences?.setStringList("tasksCompleted", tasksCompleted);
  }


  /* Get Methods */

  static String? GetToken() => _sharedPreferences?.getString("token");

  static dynamic GetKeyListValue({required String key}) => _sharedPreferences?.getStringList(key);


  /* Delete Methods */

  static Future DeleteKey({
    required String key,
}) async {
    return await _sharedPreferences?.remove(key);
}

  static Future ClearAllData() async {
    await _sharedPreferences?.remove("token");
    await _sharedPreferences?.remove("tasksId");
    await _sharedPreferences?.remove("tasksTodo");
    await _sharedPreferences?.remove("tasksUserId");
    await _sharedPreferences?.remove("tasksCompleted");
  }

}