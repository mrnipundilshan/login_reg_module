import 'package:flutter/foundation.dart';

import '../models/user_model.dart';
import '../services/auth_service.dart';

enum AuthStatus { idle, loading, success, error }

class AuthProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();

  AuthStatus _status = AuthStatus.idle;
  AuthStatus get status => _status;

  UserModel? _user;
  UserModel? get user => _user;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  String? _successMessage;
  String? get successMessage => _successMessage;

  bool _rememberMe = false;
  bool get rememberMe => _rememberMe;

  bool _obscurePassword = true;
  bool get obscurePassword => _obscurePassword;

  bool _obscureConfirmPassword = true;
  bool get obscureConfirmPassword => _obscureConfirmPassword;

  bool get isLoading => _status == AuthStatus.loading;
  bool get isAuthenticated => _user != null;

  void toggleRememberMe(bool value) {
    _rememberMe = value;
    notifyListeners();
  }

  void togglePasswordVisibility() {
    _obscurePassword = !_obscurePassword;
    notifyListeners();
  }

  void toggleConfirmPasswordVisibility() {
    _obscureConfirmPassword = !_obscureConfirmPassword;
    notifyListeners();
  }

  void clearMessages() {
    _errorMessage = null;
    _successMessage = null;
    notifyListeners();
  }

  void reset() {
    _status = AuthStatus.idle;
    _errorMessage = null;
    _successMessage = null;
    _obscurePassword = true;
    _obscureConfirmPassword = true;
    notifyListeners();
  }

  Future<bool> login({
    required String username,
    required String password,
  }) async {
    _status = AuthStatus.loading;
    _errorMessage = null;
    _successMessage = null;
    notifyListeners();

    try {
      _user = await _authService.login(username: username, password: password);
      _status = AuthStatus.success;
      _successMessage = 'Welcome back, ${_user!.fullName}!';
      notifyListeners();
      return true;
    } on Exception catch (e) {
      _status = AuthStatus.error;
      _errorMessage = e.toString().replaceFirst('Exception: ', '');
      notifyListeners();
      return false;
    }
  }

  Future<bool> register({
    required String fullName,
    required String email,
    required String mobileNumber,
    required String password,
  }) async {
    _status = AuthStatus.loading;
    _errorMessage = null;
    _successMessage = null;
    notifyListeners();

    try {
      _user = await _authService.register(
        fullName: fullName,
        email: email,
        mobileNumber: mobileNumber,
        password: password,
      );
      _status = AuthStatus.success;
      _successMessage = 'Account created successfully!';
      notifyListeners();
      return true;
    } on Exception catch (e) {
      _status = AuthStatus.error;
      _errorMessage = e.toString().replaceFirst('Exception: ', '');
      notifyListeners();
      return false;
    }
  }

  Future<bool> forgotPassword({required String email}) async {
    _status = AuthStatus.loading;
    _errorMessage = null;
    _successMessage = null;
    notifyListeners();

    try {
      await _authService.forgotPassword(email: email);
      _status = AuthStatus.success;
      _successMessage = 'Password reset link sent to $email';
      notifyListeners();
      return true;
    } on Exception catch (e) {
      _status = AuthStatus.error;
      _errorMessage = e.toString().replaceFirst('Exception: ', '');
      notifyListeners();
      return false;
    }
  }

  void logout() {
    _user = null;
    _status = AuthStatus.idle;
    _errorMessage = null;
    _successMessage = null;
    _rememberMe = false;
    _obscurePassword = true;
    _obscureConfirmPassword = true;
    notifyListeners();
  }
}
