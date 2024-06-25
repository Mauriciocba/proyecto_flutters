part of 'sponsors_category_create_bloc.dart';

sealed class SponsorsCategoryCreateState extends Equatable {
  const SponsorsCategoryCreateState();

  @override
  List<Object> get props => [];
}

final class SponsorsCategoryCreateInitial extends SponsorsCategoryCreateState {}

class SponsorsCategoryCreateSuccess extends SponsorsCategoryCreateState {
  final SponsorsCategoryModel spcModel;

  const SponsorsCategoryCreateSuccess({required this.spcModel});
}

class SponsorsCategoryCreateFailure extends SponsorsCategoryCreateState {
  final String msgFail;

  const SponsorsCategoryCreateFailure({required this.msgFail});
}

class SponsorsCategoryCreateLoading extends SponsorsCategoryCreateState {}
