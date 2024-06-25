part of 'sponsors_category_edit_bloc.dart';

sealed class SponsorsCategoryEditEvent extends Equatable {
  const SponsorsCategoryEditEvent();

  @override
  List<Object> get props => [];
}

final class CategoryUpdaterPressed extends SponsorsCategoryEditEvent {
  final int categoryId;
  final SponsorsCategoryRegistrationForm newData;

  const CategoryUpdaterPressed({
    required this.categoryId,
    required this.newData,
  });

    @override
  List<Object> get props => [categoryId,newData];
}

final class CategoryUpdaterLoadedForm extends SponsorsCategoryEditEvent {
  final SponsorsCategoryModel SpoCategory;

  const CategoryUpdaterLoadedForm(this.SpoCategory);
}