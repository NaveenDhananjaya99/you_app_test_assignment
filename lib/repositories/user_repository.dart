import '../models/user_model.dart';
import '../services/user_api_services.dart';
import 'package:http/http.dart' as http;
class UserRepository {
  final UserApiService apiService;

  UserRepository(this.apiService);

  Future<http.Response> loginUser(User user) async {
    return await apiService.login(user);
  }
  Future<http.Response> registerUser(User user) async {
    return await apiService.register(user);
  }
}