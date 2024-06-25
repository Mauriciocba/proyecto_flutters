part of 'create_sponsors_bloc.dart';

sealed class CreateSponsorsState extends Equatable {
  const CreateSponsorsState();
  
  @override
  List<Object> get props => [];
}

final class CreateSponsorsInitial extends CreateSponsorsState {}

class CreateSponsorSuccess extends CreateSponsorsState {}

class CreateSponsorLoading extends CreateSponsorsState {}

class CreateSponsorFailure extends CreateSponsorsState {
  final String msgFail;

  const CreateSponsorFailure({required this.msgFail});
}