import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/user_model.dart';


class UserApiService {
  final String baseUrl;

  UserApiService(this.baseUrl);

  Future<http.Response> login(User user) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/login'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'email': user.email, 'password': user.password,"username": "string",}),
    );
    print(response.statusCode);
    print('$baseUrl/api/login');
        print(response.body);
    return response;
    // if (response.statusCode == 200) {
    //   return true;
    // } else {
    //   if (response.statusCode == 201){
    //
    //   }
    //   return false;
    // }
  }

  Future<http.Response> register(User user) async {
    var response = await http.post(
      Uri.parse('$baseUrl/api/register'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'email': user.email, 'password': user.password, 'username': user.userName}),
    );
    print(user.email);
    print(user.password);
    print(response.body);
    print('$baseUrl/api/register');
    final Map<String, dynamic> responseBody = json.decode(response!.body);
    return response;
  }
}
