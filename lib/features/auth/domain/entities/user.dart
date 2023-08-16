class User {
  final String id;
  final String name;
  final String email;
  final String imageUrl;

  const User({
    required this.id,
    required this.name,
    required this.email,
    required this.imageUrl,
  });

  static const User empty = User(
    id: '',
    name: '',
    email: '',
    imageUrl: '',
  );

  bool get isEmpty => this == User.empty;

  bool get isNotEmpty => this != User.empty;
}
