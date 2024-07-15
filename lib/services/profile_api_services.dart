import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:you_app_test/models/profile_model.dart';
import 'dart:convert';



class ProfileApiService {
  final String baseUrl;

  ProfileApiService(this.baseUrl);


  Future<http.Response> getUserProfile() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    print('${_prefs.getString("token").toString()}');
    print('${_prefs.getString("token").toString()}');
    print('token');
    var response = await http.get(
      Uri.parse('$baseUrl/api/getProfile'),
      headers: <String, String>{
        'Content-Type':
        'application/x-www-form-urlencoded; charset=UTF-8',
        "x-access-token": "${_prefs.getString("token").toString()}",
      },

    );

    return response;
  }

  Future<http.Response> createProfile(Profile profile) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    print(profile.name);
    print(profile.birthday);
    print(json.encode({
      'name': profile.name.toString(),
      'birthday': profile.birthday.toString(), // Ensure birthday is in the correct format
      'height': profile.height, // Convert height to string if necessary
      'weight': profile.weight, // Convert weight to string if necessary
      'interests': profile.interests.map((interest) => interest.toString()).toList(), // Convert interests to strings if necessary
    }));
    print('${_prefs.getString("token").toString()}');
    print('token');
    var response = await http.post(
      Uri.parse('$baseUrl/api/createProfile'),
      headers: <String, String>{
        'Content-Type':
        'application/json',
        "x-access-token": "${_prefs.getString("token").toString()}",
      },
      body: json.encode({
        'name': profile.name.toString(),
        'birthday': profile.birthday.toString(), // Ensure birthday is in the correct format
        'height': profile.height, // Convert height to string if necessary
        'weight': profile.weight, // Convert weight to string if necessary
        'interests': profile.interests.map((interest) => interest.toString()).toList(), // Convert interests to strings if necessary
      }),
      // body: json.encode({
      //   "name": "sss",
      //   "birthday": "03/19/1994",
      //   "height": 122,
      //   "weight": 47,
      //   "interests": [
      //     "no"
      //   ]
      // }),
    );

    print(response.body);
    print('$baseUrl/api/createProfile');

    return response;
  }

  Future<http.Response> updateProfile(Profile profile) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    print(profile.name);
    print(profile.birthday);
    print(json.encode({
      'name': profile.name.toString(),
      'birthday': profile.birthday.toString(), // Ensure birthday is in the correct format
      'height': profile.height, // Convert height to string if necessary
      'weight': profile.weight, // Convert weight to string if necessary
      'interests': profile.interests.map((interest) => interest.toString()).toList(), // Convert interests to strings if necessary
    }));
    print('${_prefs.getString("token").toString()}');
    print('token');
    var response = await http.put(
      Uri.parse('$baseUrl/api/updateProfile'),
      headers: <String, String>{
        'Content-Type':
        'application/json',
        "x-access-token": "${_prefs.getString("token").toString()}",
      },
      body: json.encode({
        'name': profile.name.toString(),
        'birthday': profile.birthday.toString(), // Ensure birthday is in the correct format
        'height': profile.height, // Convert height to string if necessary
        'weight': profile.weight, // Convert weight to string if necessary
        'interests': profile.interests.map((interest) => interest.toString()).toList(), // Convert interests to strings if necessary
      }),
      // body: json.encode({
      //   "name": "sss",
      //   "birthday": "03/19/1994",
      //   "height": 122,
      //   "weight": 47,
      //   "interests": [
      //     "no"
      //   ]
      // }),
    );

    print(response.body);
    print('$baseUrl/api/updateProfile');

    return response;
  }

}
