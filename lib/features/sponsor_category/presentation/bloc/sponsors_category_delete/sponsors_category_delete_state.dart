part of 'sponsors_category_delete_bloc.dart';

sealed class SponsorsCategoryDeleteState extends Equatable {
  const SponsorsCategoryDeleteState();
  
  @override
  List<Object> get props => [];
}

final class SponsorsCategoryDeleteInitial extends SponsorsCategoryDeleteState {}

class SponsorsDeleteSuccess extends SponsorsCategoryDeleteState {}

class SponsorsDeleteFailure extends SponsorsCategoryDeleteState {
  final String msgFail;

  const SponsorsDeleteFailure({required this.msgFail});
}

class SponsorsDeleteLoading extends SponsorsCategoryDeleteState {}