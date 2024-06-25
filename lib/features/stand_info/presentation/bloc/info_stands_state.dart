part of 'info_stands_bloc.dart';

sealed class InfoStandsState extends Equatable {
  const InfoStandsState();

  @override
  List<Object> get props => [];
}

final class InfoStandsInitial extends InfoStandsState {}

final class InfoStandsSuccess extends InfoStandsState {
  final List<StandsInfoModel> listStands;

  const InfoStandsSuccess({required this.listStands});
}

final class InfoStandsLoading extends InfoStandsState {}

final class InfoStandsFailure extends InfoStandsState {
  final String msgFail;

  const InfoStandsFailure({required this.msgFail});
}
