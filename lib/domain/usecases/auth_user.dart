import 'package:coolstore/domain/repositories/auth_repository.dart';

class AuthUser {
  final AuthRepository repository;

  AuthUser(this.repository);

  Future<String> call(
      {required String userName, required String password}) async {
    return await repository.authUser(userName: userName, password: password);
  }
}
