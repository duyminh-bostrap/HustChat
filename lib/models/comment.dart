import 'user_model.dart';

class Comment {
  final User user;
  final String date;
  final String description;

  Comment({
    required this.user,
    required this.date,
    required this.description,
  });
}
