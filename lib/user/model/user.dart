class User {
  final int id;
  final String name;
  final String email;

  User({
    required this.id,
    required this.name,
    required this.email,
  });

  copyWith({
    name,
    email,
  }) {
    return User(
      id: id,
      name: name,
      email: email,
    );
  }
}
