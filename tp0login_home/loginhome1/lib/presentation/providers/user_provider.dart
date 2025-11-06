import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loginhome1/entities/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
final userProvider = StateNotifierProvider<UserNotifier, List<UserLogin>>(
  (ref) => UserNotifier(),
);
class UserNotifier extends StateNotifier<List<UserLogin>> {
  final CollectionReference<UserLogin> _usersRef =
      FirebaseFirestore.instance
          .collection('users')
          .withConverter<UserLogin>(
            fromFirestore: (snapshot, options) {
              final user = UserLogin.fromMap(snapshot.data()!);
              return user;
            },
            toFirestore: (user, _) => user.toMap(),
          );

  UserNotifier() : super([]) {
    // Escucha cambios en tiempo real y actualiza el estado
    _usersRef.snapshots().listen((snapshot) {
      state = snapshot.docs.map((doc) {
        final user = doc.data();
        return user;
      }).toList();
    });
  }

  /// Agregar usuario a Firestore
Future<void> addUser(UserLogin user) async {
  if (user.uid == null) return;
  await _usersRef.doc(user.uid!).set(user);
}


  /// Actualizar usuario en Firestore
  Future<void> updateUser(UserLogin user) async {
    final query = await _usersRef.where('uid', isEqualTo: user.uid).get();
    for (final doc in query.docs) {
      await _usersRef.doc(doc.id).set(user);
    }
  }
}
// Provider usuario actual
final currentUserNameProvider = StateProvider<String>((ref) => 'Invitado');
