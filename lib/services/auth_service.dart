import 'package:dio/dio.dart';
import 'package:uuid/uuid.dart';

import '../models/user_model.dart';
import '../utils/constants.dart';

class AuthService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://dummyjson.com',
      headers: {'Content-Type': 'application/json'},
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  );

  Future<UserModel> login({
    required String username,
    required String password,
  }) async {
    try {
      final response = await _dio.post(
        '/auth/login',
        data: {'username': username, 'password': password},
      );

      final data = response.data;

      if (data is Map<String, dynamic>) {
        return UserModel.fromJson(data);
      } else {
        throw Exception('Invalid server response');
      }
    } on DioException catch (e) {
      //print(e.response!.data.toString());
      if (e.response?.data is Map<String, dynamic>) {
        final message =
            (e.response!.data as Map<String, dynamic>)['message'] as String?;
        throw Exception(message ?? 'Login failed');
      } else if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.connectionError) {
        throw Exception('Network error: Unable to connect to server');
      } else {
        throw Exception(e.message ?? 'An unexpected error occurred');
      }
    }
  }

  static final Map<String, Map<String, dynamic>> _mockUsers = {};

  Future<UserModel> register({
    required String fullName,
    required String email,
    required String mobileNumber,
    required String password,
  }) async {
    await Future.delayed(Duration(milliseconds: AppConstants.mockApiDelay));

    if (_mockUsers.containsKey(email)) {
      throw Exception('An account with this email already exists');
    }

    final mobileExists = _mockUsers.values.any(
      (user) => user['phone'] == mobileNumber,
    );
    if (mobileExists) {
      throw Exception('An account with this mobile number already exists');
    }

    final nameParts = fullName.trim().split(RegExp(r'\s+'));
    final firstName = nameParts.first;
    final lastName = nameParts.length > 1 ? nameParts.sublist(1).join(' ') : '';

    final newUser = {
      'id': const Uuid().v4(),
      'username': email.split('@').first,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'phone': mobileNumber,
    };

    _mockUsers[email] = newUser;

    return UserModel.fromJson(newUser);
  }

  Future<void> forgotPassword({required String email}) async {
    await Future.delayed(Duration(milliseconds: AppConstants.mockApiDelay));
  }
}
