import 'package:meta/meta.dart';

class User {
  final int id;
  final String name, email, imageUrl;

  const User({
    required this.id,
    required this.name,
    required this.email,
    required this.imageUrl,
  });
}
