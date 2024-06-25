part of 'verify_code_password_bloc.dart';

sealed class VerifyCodePasswordState extends Equatable {
  const VerifyCodePasswordState();
  
  @override
  List<Object> get props => [];
}

final class VerifyCodePasswordInitial extends VerifyCodePasswordState {}

class VerifyCodePasswordSuccess extends VerifyCodePasswordState {}

class VerifyCodePasswordLoading extends VerifyCodePasswordState {}

class VerifyCodePasswordFail  extends VerifyCodePasswordState {
  final String msgFail;

  VerifyCodePasswordFail({required this.msgFail});
}