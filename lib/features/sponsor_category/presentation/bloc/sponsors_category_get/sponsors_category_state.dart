part of 'sponsors_category_bloc.dart';

sealed class SponsorsCategoryState extends Equatable {
  const SponsorsCategoryState();

  @override
  List<Object> get props => [];
}

final class SponsorsCategoryInitial extends SponsorsCategoryState {}

class SponsorsCategorySuccess extends SponsorsCategoryState {
  final List<SponsorsCategoryModel> lstCategorySponsor;

  const SponsorsCategorySuccess({required this.lstCategorySponsor});
}

class SponsorsCategoryFailure extends SponsorsCategoryState {
  final String msgFail;

  const SponsorsCategoryFailure({required this.msgFail});
}

class SponsorsCategoryLoading extends SponsorsCategoryState {}
