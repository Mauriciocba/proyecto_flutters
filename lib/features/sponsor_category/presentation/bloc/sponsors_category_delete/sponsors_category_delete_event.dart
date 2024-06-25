part of 'sponsors_category_delete_bloc.dart';

sealed class SponsorsCategoryDeleteEvent extends Equatable {
  const SponsorsCategoryDeleteEvent();

  @override
  List<Object> get props => [];
}

class SponsorsDeleteStart extends SponsorsCategoryDeleteEvent {
  final int spcId;

  const SponsorsDeleteStart({required this.spcId});
}