part of 'delete_stands_bloc.dart';

sealed class DeleteStandsEvent extends Equatable {
  const DeleteStandsEvent();

  @override
  List<Object> get props => [];
}

class DeleteStandStart extends DeleteStandsEvent {
  final int stdId;

  const DeleteStandStart({required this.stdId});
}
