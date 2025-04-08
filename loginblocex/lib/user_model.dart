class User {
  final String message;
  final bool status;

  User({required this.message, required this.status});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      message: json['message'],
      status: json['status'],
    );
  }
}
