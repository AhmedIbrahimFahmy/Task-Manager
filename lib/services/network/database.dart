import 'dart:convert';

import 'package:http/http.dart' as http;

class Database{

  Future GetUserTasks({
    required int id,
    required int skip,
    required int limit,
}) async {
    try{
      var url = 'https://dummyjson.com/todos/user/$id?limit=$limit&skip=$skip';
      final headers = {
        'Content-Type': 'application/json',
      };
      final response =
      await http.get(Uri.parse(url), headers: headers);

      print(response.statusCode);
      print(response.body);

      var DecodedJson = json.decode(response.body);

      switch (response.statusCode){
        case 200:
          return DecodedJson;
        default:
          return DecodedJson["message"];
      }
    }catch(e){
      print("Ex===========================");
      print(e.toString());
      if(e.toString().contains("SocketException"))
        return "Internet Connection Error";
    }
  }

  Future AddNewTask ({
    required int userId,
    required String todo,
}) async {
    try{
      var url = 'https://dummyjson.com/todos/add';
      final headers = {
        'Content-Type': 'application/json',
      };
      final data = {
        'todo': todo,
        'completed': false,
        'userId': userId,
      };
      final body = json.encode(data);
      final response =
      await http.post(Uri.parse(url), headers: headers, body: body);

      print(response.statusCode);
      print(response.body);

      var DecodedJson = json.decode(response.body);

      switch (response.statusCode){
        case 200:
          return DecodedJson;
        default:
          return DecodedJson["message"];
      }
    }catch(e){
      print("Ex===========================");
      print(e.toString());
      if(e.toString().contains("SocketException"))
        return "Internet Connection Error";
    }
}

  Future UpdateTask ({
    required int taskId,
    required bool completed,
  }) async {
    try{
      var url = 'https://dummyjson.com/todos/$taskId';
      final headers = {
        'Content-Type': 'application/json',
      };
      final data = {
        'completed': completed,
      };
      final body = json.encode(data);
      final response =
      await http.put(Uri.parse(url), headers: headers, body: body);

      print(response.statusCode);
      print(response.body);

      var DecodedJson = json.decode(response.body);

      switch (response.statusCode){
        case 200:
          return DecodedJson;
        default:
          return DecodedJson["message"];
      }
    }catch(e){
      print("Ex===========================");
      print(e.toString());
      if(e.toString().contains("SocketException"))
        return "Internet Connection Error";
    }
  }

  Future DeleteTask ({
    required int taskId,
  }) async {
    try{
      var url = 'https://dummyjson.com/todos/$taskId';
      final headers = {
        'Content-Type': 'application/json',
      };
      final response =
      await http.delete(Uri.parse(url), headers: headers);

      print(response.statusCode);
      print(response.body);

      var DecodedJson = json.decode(response.body);

      switch (response.statusCode){
        case 200:
          return DecodedJson;
        default:
          return DecodedJson["message"];
      }
    }catch(e){
      print("Ex===========================");
      print(e.toString());
      if(e.toString().contains("SocketException"))
        return "Internet Connection Error";
    }
  }

}