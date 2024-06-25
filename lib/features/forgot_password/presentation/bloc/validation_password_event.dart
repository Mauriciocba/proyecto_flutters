part of 'validation_password_bloc.dart';

sealed class ValidationPasswordEvent extends Equatable {
  const ValidationPasswordEvent();

  @override
  List<Object> get props => [];
}

class ValidationPasswordStart extends ValidationPasswordEvent {
  final ValidationEmail validationEmail;

  const ValidationPasswordStart({required this.validationEmail});
}