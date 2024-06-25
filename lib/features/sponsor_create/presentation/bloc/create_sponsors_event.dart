part of 'create_sponsors_bloc.dart';

sealed class CreateSponsorsEvent extends Equatable {
  const CreateSponsorsEvent();

  @override
  List<Object> get props => [];
}
class SponsorsCreateStart extends CreateSponsorsEvent {
  final SponsorsCreateModel sponsorModel;

  const SponsorsCreateStart({required this.sponsorModel});
}