import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:you_app_test/repositories/profile_repository.dart';
import 'package:you_app_test/services/profile_api_services.dart';
import 'package:you_app_test/services/user_api_services.dart';
import 'package:you_app_test/utils/theme/theme.dart';
import 'package:you_app_test/viewmodels/profile_viewmodel.dart';
import 'package:you_app_test/viewmodels/signup_viewmodel.dart';
import 'repositories/user_repository.dart';

import 'viewmodels/login_viewmodel.dart';
import 'views/login_view.dart';

void main() {
  final apiService = UserApiService('https://techtest.youapp.ai');
  final profileApiServiceService = ProfileApiService('https://techtest.youapp.ai');
  final userRepository = UserRepository(apiService);
  final profileRepository = ProfileRepository(profileApiServiceService);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginViewModel(userRepository)),
        ChangeNotifierProvider(create: (_) => SignUpViewModel(userRepository)),
        ChangeNotifierProvider(create: (_) => ProfileViewModel(profileRepository)),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'You App Test',
      debugShowCheckedModeBanner: false,
      home: LoginView(),
      theme: YouAppTheme.lightTheme,
    );
  }
}
