class UserInstance {
  static final UserInstance _instance = UserInstance._internal();

  factory UserInstance() {
    return _instance;
  }

  UserInstance._internal();

  String? userId;

  String? firstName;

  String? email;
  String? phoneNumber;
}
