abstract class UserRepository {
  Future<void> addUser({required String name, required String email});
}
