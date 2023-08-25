class UserModel {
  final String id, password;

  UserModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        password = json['password'];
}
