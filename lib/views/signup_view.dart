import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toastification/toastification.dart';
import 'package:you_app_test/views/login_view.dart';

import '../utils/theme/widget_themes/custom_gradient_button.dart';
import '../utils/theme/widget_themes/text_theme.dart';

import '../viewmodels/signup_viewmodel.dart';

class SignupView extends StatefulWidget {
  const SignupView({Key? key}) : super(key: key);

  @override
  _SignupViewState createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordReEnteredController = TextEditingController();
  bool _passwordVisible = false;
  bool _passwordReEnteredVisible = false;

  String? _emailError;
  String? _passwordError;
  String? _confirmPasswordError;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromRGBO(31, 66, 71, 1),
                Color.fromRGBO(13, 29, 35, 1),
                Color.fromRGBO(9, 20, 26, 1),
              ],
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                        color: Colors.white,
                        icon: Icon(Icons.arrow_back),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      Text('Back')
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Register',
                            style: YouAppTextTheme.lightTextTheme.headlineMedium),
                      ),
                      SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: 327,
                          height: 51,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(9),
                            color: _emailError != null ?Colors.red:Color.fromRGBO(255, 255, 255, 0.06),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextField(
                                controller: _emailController,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.symmetric(horizontal: 16),
                                  hintText: 'Enter Email',
                                  hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
                                ),
                                style: TextStyle(color: Colors.white),
                              ),
            
                            ],
                          ),
                        ),
                      ),
                      if (_emailError != null)
                        Padding(
                          padding: const EdgeInsets.only(left: 16, top: 4),
                          child: Text(
                            _emailError!,
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: 327,
                          height: 51,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(9),
                            color: Color.fromRGBO(255, 255, 255, 0.06),
                          ),
                          child: TextField(
                            controller: _userNameController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(horizontal: 16),
                              hintText: 'Create Username',
                              hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
                            ),
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: 327,
                          height: 51,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(9),
                            color: Color.fromRGBO(255, 255, 255, 0.06),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 16),
                                      child: TextField(
                                        controller: _passwordController,
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: 'Create Password',
                                          hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
                                        ),
                                        obscureText: !_passwordVisible,
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      _passwordVisible ? Icons.visibility : Icons.visibility_off,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _passwordVisible = !_passwordVisible;
                                      });
                                    },
                                  ),
                                ],
                              ),
                              if (_passwordError != null)
                                Padding(
                                  padding: const EdgeInsets.only(left: 16, top: 4),
                                  child: Text(
                                    _passwordError!,
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: 327,
                          height: 51,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(9),
                            color: _confirmPasswordError != null ?Colors.red:Color.fromRGBO(255, 255, 255, 0.06),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 16),
                                      child: TextField(
                                        controller: _passwordReEnteredController,
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: 'Confirm Password',
                                          hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
                                        ),
                                        obscureText: !_passwordReEnteredVisible,
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      _passwordReEnteredVisible ? Icons.visibility : Icons.visibility_off,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _passwordReEnteredVisible = !_passwordReEnteredVisible;
                                      });
                                    },
                                  ),
                                ],
                              ),
            
                            ],
                          ),
                        ),
                      ),
                      if (_confirmPasswordError != null)
                        Padding(
                          padding: const EdgeInsets.only( left:8,top: 4),
                          child: Text(
                            _confirmPasswordError!,
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      SizedBox(height: 20),
                      Consumer<SignUpViewModel>(
                        builder: (context, signUpViewModel, child) {
                          final email = _emailController.text;
                          final password = _passwordController.text;
                          final userName = _userNameController.text;
                          final passwordReEntered = _passwordReEnteredController.text;
                          final bool isDisabled = email.isEmpty || password.isEmpty || userName.isEmpty || passwordReEntered.isEmpty;
            
                          return Column(
                            children: [
                              if (signUpViewModel.isLoading)
                                CircularProgressIndicator()
                              else
                                CustomGradientButton(
                                  onPressed: isDisabled
                                      ? null
                                      : () {
                                    setState(() async {
                                      _emailError = null;
                                      _passwordError = null;
                                      _confirmPasswordError = null;
            
                                      final emailValid = RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email);
                                      if (!emailValid) {
                                        _emailError = '*Invalid email format';
                                      }
                                      if (password != passwordReEntered) {
                                        _confirmPasswordError = '*Passwords do not match';
                                      }
            
                                      if (_emailError == null && _confirmPasswordError == null) {
                                       await  signUpViewModel.register(email,  password,userName,context);
                                      }
                                      if (signUpViewModel.errorMessage != null) {
                                        toastification.show(
                                          type: ToastificationType.error,
                                          style: ToastificationStyle.fillColored,
                                          context: context,
                                          title: Text(signUpViewModel.errorMessage!),
                                          autoCloseDuration: const Duration(seconds: 5),
                                          alignment: Alignment.bottomRight,
                                        );
                                        _emailController.clear();
                                        _passwordController.clear();
                                        _userNameController.clear();
                                        _passwordReEnteredController.clear();
                                      }
                                    });
                                  },
                                  text: 'Register',
                                  width: 331,
                                  height: 48,
                                  isDisabled: isDisabled,
                                ),
            
                              // if (signUpViewModel.errorMessage != null)
                              //   Text(
                              //     signUpViewModel.errorMessage!,
                              //     style: TextStyle(color: Colors.red),
                              //   ),
            
                            ],
                          );
                        },
                      ),
                      SizedBox(height: 40),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Have an account? ',
                          ),
                          SizedBox(width: 2),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => LoginView()),
                              );
                            },
                            child: ShaderMask(
                              shaderCallback: (Rect bounds) {
                                return LinearGradient(
                                  colors: [
                                    Color.fromRGBO(148, 120, 62, 1),
                                    Color.fromRGBO(243, 237, 166, 1),
                                    Color.fromRGBO(248, 250, 229, 1),
                                    Color.fromRGBO(255, 226, 190, 1),
                                    Color.fromRGBO(213, 190, 136, 1),
                                    Color.fromRGBO(248, 250, 229, 1),
                                    Color.fromRGBO(213, 190, 136, 1),
                                  ],
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                ).createShader(bounds);
                              },
                              child: Text(
                                'Login here',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
