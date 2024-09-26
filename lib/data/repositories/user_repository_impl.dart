import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lingo_panda/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<void> addUser({required String name, required String email}) async {
    try {
      await _firestore.collection('users').add({
        'name': name,
        'email': email,
        'created_at': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw Exception('Error adding user to Firestore: $e');
    }
  }
}
