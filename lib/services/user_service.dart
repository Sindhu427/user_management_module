import 'package:dio/dio.dart';
import '../models/user_model.dart';

class UserService {
  final Dio _dio = Dio(
    BaseOptions(baseUrl: "https://jsonplaceholder.typicode.com"),
  );

  Future<List<User>> fetchUsers() async {
    final response = await _dio.get('/users');
    return (response.data as List).map((json) => User.fromJson(json)).toList();
  }

  Future<User> addUser(User user) async {
    final response = await _dio.post('/users', data: user.toJson());
    return User.fromJson(response.data);
  }

  Future<User> updateUser(User user) async {
    final response = await _dio.put('/users/${user.id}', data: user.toJson());
    return User.fromJson(response.data);
  }

  Future<void> deleteUser(int id) async {
    await _dio.delete('/users/$id');
  }
}
