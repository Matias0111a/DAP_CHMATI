import 'package:firebase_auth/firebase_auth.dart';
class UserLogin {
  String userName;
  String details;
  String? uid;
  List<String> favouriteBands = [];

  UserLogin(this.userName, this.details, {this.uid});

  factory UserLogin.fromFirebaseUser(User user) {
    final email = user.email;
    final displayName = user.displayName;
    final userName = displayName ?? (email != null ? email.split('@').first : '');
    return UserLogin(userName, '', uid: user.uid);
  }

  Map<String, dynamic> toMap() => {
        'userName': userName,
        'details': details,
        'uid': uid,
      };

  factory UserLogin.fromMap(Map<String, dynamic> map) => UserLogin(
        map['userName'] as String? ?? '',
        map['details'] as String? ?? '',
        uid: map['uid'] as String?,
      );
}

List<UserLogin> listaUsuarios = <UserLogin>[];
