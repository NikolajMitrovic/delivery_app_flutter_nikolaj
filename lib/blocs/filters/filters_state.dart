part of 'filters_bloc.dart';

abstract class FiltersState extends Equatable {
  const FiltersState();

  @override
  List<Object> get props => [];
}

class FiltersLoading extends FiltersState {}

class FiltersLoaded extends FiltersState {
  final Filter filter;

  const FiltersLoaded({required this.filter});
  @override
  List<Object> get props => [filter];
}


// part of 'filters_bloc.dart';

// abstract class FilterState extends Equatable {
//   const FilterState();

//   @override
//   List<Object?> get props => [];
// }

// class FilterLoading extends FilterState {}

// class FilterLoaded extends FilterState {
//   final Filter filter;
//   final List<Restaurant>? filteredRestaurants;

//   FilterLoaded({
//     this.filter = const Filter(),
//     this.filteredRestaurants = const <Restaurant>[],
//   });

//   @override
//   List<Object?> get props => [filter, filteredRestaurants];
// }