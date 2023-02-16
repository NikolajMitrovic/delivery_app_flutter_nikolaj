// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'filters_bloc.dart';

abstract class FiltersEvent extends Equatable {
  const FiltersEvent();

  @override
  List<Object> get props => [];
}

class FilterLoad extends FiltersEvent {
  @override
  List<Object> get props => [];
}

class CategoryFilterUpdate extends FiltersEvent {
  final CategoryFilter categoryFilter;
  const CategoryFilterUpdate({
    required this.categoryFilter,
  });
  @override
  List<Object> get props => [categoryFilter];
}

class PriceFilterUpdate extends FiltersEvent {
  final PriceFilter priceFilter;
  const PriceFilterUpdate({
    required this.priceFilter,
  });
  @override
  List<Object> get props => [priceFilter];
}

// part of 'filters_bloc.dart';

// abstract class FilterEvent extends Equatable {
//   const FilterEvent();

//   @override
//   List<Object> get props => [];
// }

// class LoadFilter extends FilterEvent {
//   @override
//   List<Object> get props => [];
// }

// class UpdateCategoryFilter extends FilterEvent {
//   final CategoryFilter categoryFilter;

//   const UpdateCategoryFilter({required this.categoryFilter});

//   @override
//   List<Object> get props => [categoryFilter];
// }

// class UpdatePriceFilter extends FilterEvent {
//   final PriceFilter priceFilter;

//   const UpdatePriceFilter({required this.priceFilter});

//   @override
//   List<Object> get props => [priceFilter];
// }
