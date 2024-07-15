import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toastification/toastification.dart';
import '../models/user_model.dart';
import '../repositories/user_repository.dart';
import '../views/about_view.dart';

class LoginViewModel extends ChangeNotifier {
  final UserRepository userRepository;
  bool _isLoading = false;
  String? _errorMessage;

  LoginViewModel(this.userRepository);

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> login(String email, String password,BuildContext context) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final user = User(email: email, password: password,userName:"");
      final response = await userRepository.loginUser(user);
      final Map<String, dynamic> responseBody = json.decode(response.body);
      if (response.statusCode == 200) {

          toastification.show(
            type: ToastificationType.success,
            style: ToastificationStyle.fillColored,
            context: context,
            title: Text(responseBody['message']),
            autoCloseDuration: const Duration(seconds: 5),
            alignment: Alignment.bottomRight,
          );
          print('login successful');
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AboutView()),

          );

      } else {
        if (response.statusCode == 201) {
          if (responseBody.containsKey('message') && responseBody['message'] == 'User has been logged in successfully') {
            final SharedPreferences _prefs = await SharedPreferences.getInstance();
            _prefs.clear();
             _prefs.setString('token',responseBody['access_token'] );
            toastification.show(
              type: ToastificationType.success,
              style: ToastificationStyle.fillColored,
              context: context,
              title: Text(responseBody['message']),
              autoCloseDuration: const Duration(seconds: 5),
              alignment: Alignment.bottomRight,
            );
            print('login successful');
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AboutView()),

            );
          }else{
            toastification.show(
              type: ToastificationType.error,
              style: ToastificationStyle.fillColored,
              context: context,
              title: Text(responseBody['message']),
              autoCloseDuration: const Duration(seconds: 5),
              alignment: Alignment.bottomRight,
            );
          }

        }else{
          print(responseBody);
          _errorMessage ="Something went wrong";
        }


      }
    } catch (e) {
      print(e);
      _errorMessage = 'Something went wrong';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}