part of 'verify_code_bloc.dart';

sealed class VerifyCodeEvent extends Equatable {
  const VerifyCodeEvent();

  @override
  List<Object> get props => [];
}

class StartVerifyCode extends VerifyCodeEvent {
  final String code;
  final int userId;

  const StartVerifyCode({required this.code, required this.userId});
}
