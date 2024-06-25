part of 'sponsors_category_create_bloc.dart';

sealed class SponsorsCategoryCreateEvent extends Equatable {
  const SponsorsCategoryCreateEvent();

  @override
  List<Object> get props => [];
}

class SponsorsCategoryStart extends SponsorsCategoryCreateEvent{
  final SponsorsCategoryRegistrationForm spcRegister;

  const SponsorsCategoryStart({required this.spcRegister});
}