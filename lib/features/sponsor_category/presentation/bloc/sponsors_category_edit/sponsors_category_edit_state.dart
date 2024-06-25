part of 'sponsors_category_edit_bloc.dart';

sealed class SponsorsCategoryEditState extends Equatable {
  const SponsorsCategoryEditState();
  
  @override
  List<Object> get props => [];
}

final class SponsorsCategoryEditInitial extends SponsorsCategoryEditState {}

class SponsorsCategoryEditLoadSuccess extends SponsorsCategoryEditState {}

class SponsorsCategoryEditLoadFailure extends SponsorsCategoryEditState {
  final String msgFail;

  const SponsorsCategoryEditLoadFailure({required this.msgFail});
}

class SponsorsCategoryEditLoading extends SponsorsCategoryEditState {}


final class SponsorsCategoryUpdaterLoadForm extends SponsorsCategoryEditState {
  final SponsorsCategoryModel spcEdit;

  const SponsorsCategoryUpdaterLoadForm({required this.spcEdit});
}
