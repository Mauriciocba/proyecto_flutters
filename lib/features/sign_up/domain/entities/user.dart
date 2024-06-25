import 'package:equatable/equatable.dart';

final class User extends Equatable {
  final int userId;
  final String email;

  const User({required this.userId, required this.email});

  @override
  List<Object?> get props => [userId];
}
