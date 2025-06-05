class UserLogin extends Object {
  String userName;
  String password;
  String? email;
  String? direction;
  UserLogin(this.userName, this.password,this.email, this.direction);
}

List listaUsuarios = [
  UserLogin('admin', '1234', 'admin@admin', '0'),
  UserLogin('user1', 'abcd','user@user1', '1'),
  UserLogin('user2', 'efgh', 'user@user2', '2'),
  UserLogin('user3', 'ijkl', 'user@user3', '3'),
  UserLogin('user4', 'mnop', 'user@user4', '4'),
  UserLogin('user5', 'qrst', 'user@user5', '5'),
  UserLogin('user6', 'uvwx', 'user@user6', '6'),
  UserLogin('user7', 'yz12', 'user@user7', '7'),
  UserLogin('user8', '3456', 'user@user8', '8'),
  UserLogin('user9', '7890', 'user@user9', '9'),
];
