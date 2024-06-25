part of 'delete_stands_bloc.dart';

sealed class DeleteStandsState extends Equatable {
  const DeleteStandsState();

  @override
  List<Object> get props => [];
}

final class DeleteStandsInitial extends DeleteStandsState {}

class DeleteStandSuccess extends DeleteStandsState {}

class DeleteStandFailure extends DeleteStandsState {
  final String msgError;

  const DeleteStandFailure({required this.msgError});
}

class DeleteStandLoading extends DeleteStandsState {}
