class ServicizerInstance {
  static final ServicizerInstance _instance = ServicizerInstance._internal();

  factory ServicizerInstance() {
    return _instance;
  }

  ServicizerInstance._internal();

  String? userId;

  String? firstName;

  String? email;
  String? phoneNumber;
}
