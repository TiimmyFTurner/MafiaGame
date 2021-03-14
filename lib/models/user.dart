class User {
  final int id;
  String name, email, token;

  User({
    this.id,
    this.name,
    this.email,
    this.token,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['id'],
        name: json['name'],
        email: json['email'],
        token: json['token'],
      );
}
