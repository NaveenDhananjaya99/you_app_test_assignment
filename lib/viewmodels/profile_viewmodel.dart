import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';
import 'package:you_app_test/models/profile_model.dart';
import 'package:you_app_test/repositories/profile_repository.dart';
import 'package:you_app_test/views/about_view.dart';

class ProfileViewModel extends ChangeNotifier {
  final ProfileRepository profileRepository;
  bool _isLoading = false;
  String? _errorMessage;
  Profile? _profile;

  ProfileViewModel(this.profileRepository);

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  Profile? get profile => _profile;

  Future<void> getProfile() async {
    _isLoading = true;
    _errorMessage = null;

    try {
      final response = await profileRepository.getProfile();
      print(response.statusCode);
      if (response.statusCode == 200) {
        print('naveen');
        final Map<String, dynamic> responseBody = json.decode(response.body);
        final Map<String, dynamic> data = responseBody['data'];
        print(data);
        print(data["weight"].toString());
        _profile = Profile(
          email: data["email"].toString() ?? '',
          userName: data["username"].toString() ?? '',
          interests: List<String>.from(data["interests"] ?? []),
          birthday:data["birthday"].toString() ?? '',
          horoscope:data["horoscope"].toString() ?? '',
          weight:data["weight"].toString()=="null"?0: double.parse(data["weight"].toString()),
          height:data["height"].toString() =="null"?0:double.parse(data["height"].toString()),
          name: data["name"].toString() ?? '',
          zodiac:  data["zodiac"].toString() ?? ''
        );
        print("profile?.name");
        print("Profile Name: ${_profile?.name}");

        notifyListeners();
        _isLoading = false;
      } else {

        final Map<String, dynamic> responseBody = json.decode(response.body);
        _errorMessage = responseBody['message'].join(', ');
        _isLoading = false;
      }
    } catch (e) {
      print(e);
      _errorMessage = 'Something went wrong: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }


  Future<void> createProfile(Profile profile, BuildContext context) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await profileRepository.createProfile(profile);
      final Map<String, dynamic> responseBody = json.decode(response!.body);
      print(response.statusCode);
      if (response.statusCode == 201) {
        print(responseBody);
        toastification.show(
          type: ToastificationType.success,
          style: ToastificationStyle.fillColored,
          context: context,
          title: Text(responseBody['message']),
          autoCloseDuration: const Duration(seconds: 5),
          alignment: Alignment.bottomRight,
        );
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => AboutView()), // Replace YourCurrentPage with your actual page widget
        );

        notifyListeners();

      } else {
        print("asfaf");
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

  Future<void> updateProfile(Profile profile, BuildContext context) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await profileRepository.updateProfile(profile);
      final Map<String, dynamic> responseBody = json.decode(response!.body);
      print(response.statusCode);
      if (response.statusCode == 200) {
        print(responseBody);
        toastification.show(
          type: ToastificationType.success,
          style: ToastificationStyle.fillColored,
          context: context,
          title: Text(responseBody['message']),
          autoCloseDuration: const Duration(seconds: 5),
          alignment: Alignment.bottomRight,
        );
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => AboutView()), // Replace YourCurrentPage with your actual page widget
        );

        notifyListeners();

      } else {
        print("asfaf");
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
  void clearCache() {
    _profile = null;
    _errorMessage = null;
    _isLoading = false;
    notifyListeners();
  }
}
