part of 'edit_stand_bloc.dart';

sealed class EditStandState extends Equatable {
  const EditStandState();

  @override
  List<Object> get props => [];
}

final class EditStandInitial extends EditStandState {}

class EditStandSuccess extends EditStandState {}

class EditStandFailure extends EditStandState {
  final String msgFail;

  const EditStandFailure({required this.msgFail});
}

class EditStandLoading extends EditStandState {}

//Load stands

final class LoadStandsEditLoading extends EditStandState {}

final class LoadStandsEditFail extends EditStandState {
  final String msgFailLoadFormStand;

  const LoadStandsEditFail({required this.msgFailLoadFormStand});
}

final class LoadStandsEditSuccess extends EditStandState {
  final StandsEditModel standEdit;

  const LoadStandsEditSuccess({required this.standEdit});
}
