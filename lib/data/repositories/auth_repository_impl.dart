import 'package:coolstore/core/di/injector.dart';
import 'package:coolstore/domain/repositories/auth_repository.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/error/error_handler.dart';

class AuthRepositoryImpl implements AuthRepository {
  @override
  Future<String> authUser(
      {required String userName, required String password}) async {
    try {
      final response = await getIt<Dio>(instanceName: "FakeStoreApi").post(
          "/auth/login",
          data: {"username": userName, "password": password});

      final result = response.data;

      if (response.statusCode == 200) {
        String? token = result["token"];
        if (token != null) {
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('authToken', token);
          return token;
        } else {
          throw ErrorHandler(errorMessage: "Error on Signin");
        }
      } else {
        throw ErrorHandler(errorMessage: "Error on Signin");
      }
    } on DioException catch (e) {
      throw ErrorHandler.fromDioException(e);
    } on ErrorHandler catch (e) {
      throw ErrorHandler(errorMessage: e.errorMessage);
    } catch (e) {
      throw ErrorHandler(errorMessage: "Error on Signin");
    }
  }
}
