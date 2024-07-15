import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toastification/toastification.dart';
import 'package:you_app_test/viewmodels/login_viewmodel.dart';
import '../models/user_model.dart';
import '../repositories/user_repository.dart';
import '../views/about_view.dart';
import '../views/login_view.dart';
import '../views/signup_view.dart';

class SignUpViewModel extends ChangeNotifier {
  final UserRepository userRepository;
  bool _isLoading = false;
  String? _errorMessage;

  SignUpViewModel(this.userRepository);

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> register(String email, String password, String userName,BuildContext context) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final user = User(email: email, password: password,userName:userName);
      final response = await userRepository.registerUser(user);
   final Map<String, dynamic> responseBody = json.decode(response!.body);
      print(responseBody);
      print(response.statusCode );
      if (response.statusCode == 201) {
        // Check if the response body contains an error message
        final Map<String, dynamic> responseBody = json.decode(response.body);
        if (responseBody.containsKey('message') && responseBody['message'] == 'User already exists') {
          // Handle the case where user already exists
          print('User already exists');
          _errorMessage = 'User already exists';
        } else {
          toastification.show(
            type: ToastificationType.success,
            style: ToastificationStyle.fillColored,
            context: context,
            title: Text(responseBody['message']),
            autoCloseDuration: const Duration(seconds: 5),
            alignment: Alignment.bottomRight,
          );
          print('Registration successful');
          final loginViewModel = Provider.of<LoginViewModel>(context, listen: false);
          loginViewModel.login(email,password,context);
        }
      } else {
        // Handle error message
        _errorMessage = responseBody['message'].join(', ');
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