part of 'validation_password_bloc.dart';

sealed class ValidationPasswordState extends Equatable {
  const ValidationPasswordState();
  
  @override
  List<Object> get props => [];
}

final class ValidationPasswordInitial extends ValidationPasswordState {}

class ValidationPasswordSuccess extends ValidationPasswordState {}

class ValidationPasswordFail extends ValidationPasswordState {
  final String msgFail;

  ValidationPasswordFail({required this.msgFail});
}

class ValidationPasswordLoading extends ValidationPasswordState {}