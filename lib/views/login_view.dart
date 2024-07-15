

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:you_app_test/views/signup_view.dart';


import '../utils/theme/widget_themes/custom_gradient_button.dart';
import '../utils/theme/widget_themes/text_theme.dart';
import '../viewmodels/login_viewmodel.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery
              .of(context)
              .size
              .height,
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
                      child: Text('Login',
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
                          color: Color.fromRGBO(255, 255, 255, 0.06),
                        ),
                        child: TextField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 16),
                            hintText: 'Enter Username/Email',
                            hintStyle: TextStyle(
                                color: Colors.white.withOpacity(0.5)),
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
                        child: Row(
                          children: [
                            Expanded(

                              child: Padding(
                                padding: const EdgeInsets.only(left:16),
                                child: TextField(
                                  controller: _passwordController,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Enter Password',
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
                      ),
                    ),

                    SizedBox(height: 20),
                    Consumer<LoginViewModel>(
                      builder: (context, viewModel, child) {
                        final email = _emailController.text;
                        final password = _passwordController.text;
                        final bool isDisabled = email.isEmpty || password.isEmpty ;

                        return Column(
                          children: [
                            if (viewModel.isLoading)
                              CircularProgressIndicator()
                            else
                              CustomGradientButton(
                                onPressed: isDisabled
                                    ? null
                                    : () {

                                  viewModel.login(email, password,context);
                                },
                                text: 'Login',
                                width: 331,
                                height: 48,
                                isDisabled: isDisabled,
                              ),
                            if (viewModel.errorMessage != null)
                              Text(
                                viewModel.errorMessage!,
                                style: TextStyle(color: Colors.red),
                              ),
                          ],
                        );
                      },
                    ),

                    SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [Text(
                        'No account? ',
                      ),
                        SizedBox(width: 2),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => SignupView()),
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
                              'Register here',
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
    );
  }


}
