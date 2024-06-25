part of 'verify_code_password_bloc.dart';

sealed class VerifyCodePasswordEvent extends Equatable {
  const VerifyCodePasswordEvent();

  @override
  List<Object> get props => [];
}

class StartVerifyCode extends VerifyCodePasswordEvent {
  final int userId; 
  final String code;

  const StartVerifyCode({required this.code, required this.userId});
}
