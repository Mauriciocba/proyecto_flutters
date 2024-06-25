part of 'sponsors_delete_bloc.dart';

sealed class SponsorsDeleteState extends Equatable {
  const SponsorsDeleteState();
  
  @override
  List<Object> get props => [];
}

final class SponsorsDeleteInitial extends SponsorsDeleteState {}

class SponsorsDeleteSuccess extends SponsorsDeleteState {}

class SponsorsDeleteFailure extends SponsorsDeleteState {
  final String msgFail;

  const SponsorsDeleteFailure({required this.msgFail});
}

class SponsorsDeleteLoading extends SponsorsDeleteState {}