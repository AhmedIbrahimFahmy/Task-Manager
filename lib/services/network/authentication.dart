import 'dart:convert';
import 'package:http/http.dart' as http;

class Authenticate {

  static Future Login(username, password) async {
    try{
      const url = 'https://dummyjson.com/auth/login';
      final headers = {'Content-Type': 'application/json'};
      final data = {
        'username': username,
        'password' : password,
        'expiresInMins': 60,
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

  static Future GetUserWithToken(token) async {
    try{
      const url = 'https://dummyjson.com/auth/me';
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      };
      final response =
      await http.get(Uri.parse(url), headers: headers);

      print("Get User with Token Result: ");
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

  static Future RefreshToken(token) async {
    try{
      const url = 'https://dummyjson.com/auth/refresh';
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };
      final data = {
        'expiresInMins': 60,
      };
      final body = json.encode(data);
      final response =
      await http.post(Uri.parse(url), headers: headers, body: body);

      print("Refresh Result: ");
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