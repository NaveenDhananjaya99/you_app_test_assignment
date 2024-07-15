import 'package:you_app_test/models/profile_model.dart';
import 'package:you_app_test/services/profile_api_services.dart';

import '../models/user_model.dart';

import 'package:http/http.dart' as http;
class ProfileRepository {
  final ProfileApiService apiService;

  ProfileRepository(this.apiService);

  Future<http.Response> getProfile() async {
    return await apiService.getUserProfile();
  }

  Future<http.Response> createProfile(Profile profile) async {
    return await apiService.createProfile(profile);
  }

  Future<http.Response> updateProfile(Profile profile) async {
    return await apiService.updateProfile(profile);
  }

}