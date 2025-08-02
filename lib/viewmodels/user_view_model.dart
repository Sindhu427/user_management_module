import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../services/user_service.dart';

class UserViewModel extends ChangeNotifier {
  final UserService _service = UserService();
  List<User> _users = [];
  bool _loading = false;
  String? _error;

  List<User> get users => _users;
  bool get loading => _loading;
  String? get error => _error;

  Future<void> loadUsers() async {
    _loading = true;
    notifyListeners();
    try {
      _users = await _service.fetchUsers();
      _error = null;
    } catch (e) {
      _error = "Failed to load users";
    }
    _loading = false;
    notifyListeners();
  }

  Future<void> addUser(User user) async {
    try {
      final newUser = await _service.addUser(user);
      _users.add(newUser);
      _error = null;
    } catch (e) {
      _error = "Failed to add user";
    }
    notifyListeners();
  }

  Future<void> editUser(User user) async {
    try {
      final updated = await _service.updateUser(user);
      int idx = _users.indexWhere((u) => u.id == user.id);
      if (idx != -1) _users[idx] = updated;
      _error = null;
    } catch (e) {
      _error = "Failed to edit user";
    }
    notifyListeners();
  }

  Future<void> deleteUser(int id) async {
    try {
      await _service.deleteUser(id);
      _users.removeWhere((u) => u.id == id);
      _error = null;
    } catch (e) {
      _error = "Failed to delete user";
    }
    notifyListeners();
  }
}
