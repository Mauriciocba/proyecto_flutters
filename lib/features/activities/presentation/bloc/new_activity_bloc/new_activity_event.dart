part of 'new_activity_bloc.dart';

sealed class NewActivityEvent extends Equatable {
  const NewActivityEvent();

  @override
  List<Object> get props => [];
}

final class SubmittedNewActivity extends NewActivityEvent {
  final ActivityFormInput dataInput;

  const SubmittedNewActivity({required this.dataInput});
}
