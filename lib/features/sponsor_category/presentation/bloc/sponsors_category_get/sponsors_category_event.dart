part of 'sponsors_category_bloc.dart';

sealed class SponsorsCategoryEvent extends Equatable {
  const SponsorsCategoryEvent();

  @override
  List<Object> get props => [];
}

class CategorySponsorsStart extends SponsorsCategoryEvent {
  final int eventId;

  const CategorySponsorsStart({required this.eventId});
}
