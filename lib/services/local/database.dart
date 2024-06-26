import 'package:sqflite/sqflite.dart';

/*
  Task parameters
    - id
    - body
    - status
 */

class LocalDatabase{
  static late Database database;

  Future initialize() async {
    await openDatabase(
        'tasks.db',
        version: 1,
        onCreate: (database, version) {
          print("database has been created");
          database.execute(
              "CREATE TABLE tasks (id INTEGER PRIMARY KEY, body TEXT, status INTEGER)")
              .then((value) {
            print("table has been created");
          }).catchError((error) {
            print("Error when creating table : ${error.toString()}");
          });
        },
        onOpen: (database) {
          print("database has been opened");
        }
    ).then((value){
      print("Value : $value");
      database = value;
    });
  }

  addTask(body) async {
      print("database is not null");
      int id = -1;
      await database.transaction((txn) async {
        txn.rawInsert(
            'INSERT INTO tasks(body, status) VALUES("$body", 0)').then((value){
              print("$value is inserted");
              id = value;
        });
      }).catchError((error){
        print("Error : ${error.toString()}");
      });
      return id;
  }

  updateTask({
    required int id,
    String? body,
    int? status
  }) async {
    int? count = await database.rawUpdate(
        'UPDATE tasks SET status = $status WHERE id = $id');
    return count;
  }

  getTasks() async {
    return await database.rawQuery('SELECT * FROM tasks');
  }

  deleteTask(id) async {
    int? count = await database
        .rawDelete('DELETE FROM tasks WHERE id = $id');
    return count;
  }

}