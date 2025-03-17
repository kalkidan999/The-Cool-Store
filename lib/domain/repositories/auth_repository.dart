abstract class AuthRepository {
  Future<String> authUser({required String userName, required String password});
}
