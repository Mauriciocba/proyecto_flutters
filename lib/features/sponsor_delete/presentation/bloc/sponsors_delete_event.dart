part of 'sponsors_delete_bloc.dart';

sealed class SponsorsDeleteEvent extends Equatable {
  const SponsorsDeleteEvent();

  @override
  List<Object> get props => [];
}

class DeleteSponsorsStart extends SponsorsDeleteEvent {
  final int spoId;

  const DeleteSponsorsStart({required this.spoId});

}