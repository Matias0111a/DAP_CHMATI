import 'package:firebase_auth/firebase_auth.dart';

class UserLogin {
  String userName;
  String password;
  String? email;
  String? direction;
  String? uid;

  UserLogin(this.userName, this.password, this.email, this.direction, {this.uid});

  factory UserLogin.fromFirebaseUser(User user, {String? direction}) {
    final email = user.email;
    final displayName = user.displayName;
    final userName = displayName ?? (email != null ? email.split('@').first : '');
    return UserLogin(userName, '', email, direction, uid: user.uid);
  }

  Map<String, dynamic> toMap() => {
        'userName': userName,
        'password': password,
        'email': email,
        'direction': direction,
        'uid': uid,
      };

  factory UserLogin.fromMap(Map<String, dynamic> map) => UserLogin(
        map['userName'] as String? ?? '',
        map['password'] as String? ?? '',
        map['email'] as String?,
        map['direction'] as String?,
        uid: map['uid'] as String?,
      );
}

List<UserLogin> listaUsuarios = <UserLogin>[];
