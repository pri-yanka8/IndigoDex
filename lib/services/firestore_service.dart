import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart';

class FirestoreService {
  final _db = FirebaseFirestore.instance;

  Future<void> saveUser(PokemonUser user) async {
    await _db.collection('users').doc(user.email).set(user.toMap());
  }

  Future<PokemonUser?> getUser(String email) async {
    final doc = await _db.collection('users').doc(email).get();
    if (doc.exists) {
      return PokemonUser.fromMap(doc.data()!);
    }
    return null;
  }
}
