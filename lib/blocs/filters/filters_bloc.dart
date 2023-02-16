import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/models.dart';

part 'filters_event.dart';
part 'filters_state.dart';

class FiltersBloc extends Bloc<FiltersEvent, FiltersState> {
  FiltersBloc() : super(FiltersLoading()) {
    on<FilterLoad>(_onLoadFilter);
    on<CategoryFilterUpdate>(_onUpdateCategoryFilter);
    on<PriceFilterUpdate>(_onUpdatePriceFilter);
  }

  Future<void> _onLoadFilter(
    FilterLoad event,
    Emitter<FiltersState> emit,
  ) async {
    emit(
      FiltersLoaded(
        filter: Filter(
          categoryFilters: CategoryFilter.filters,
          priceFilters: PriceFilter.filters,
        ),
      ),
    );
  }

  Future<void> _onUpdateCategoryFilter(
    CategoryFilterUpdate event,
    Emitter<FiltersState> emit,
  ) async {
    final state = this.state;
    if (state is FiltersLoaded) {
      final List<CategoryFilter> updatedCategoryFilters = state.filter.categoryFilters.map((categoryFilter) {
        return categoryFilter.id == event.categoryFilter.id ? event.categoryFilter : categoryFilter;
      }).toList();

      // var categories = updatedCategoryFilters.where((filter) => filter.value).map((filter) => filter.category).toList();

      // var prices = state.filter.priceFilters.where((filter) => filter.value).map((filter) => filter.price.price).toList();

      emit(
        FiltersLoaded(
          filter: Filter(
            categoryFilters: updatedCategoryFilters,
            priceFilters: state.filter.priceFilters,
          ),
        ),
      );
    }
  }

  Future<void> _onUpdatePriceFilter(
    PriceFilterUpdate event,
    Emitter<FiltersState> emit,
  ) async {
    final state = this.state;
    if (state is FiltersLoaded) {
      List<PriceFilter> updatedPriceFilters = state.filter.priceFilters.map(
        (priceFilter) {
          if (priceFilter.id == event.priceFilter.id) {
            return event.priceFilter;
          } else {
            return priceFilter;
          }
        },
      ).toList();

      // var categories = state.filter.categoryFilters.where((filter) => filter.value).map((filter) => filter.category).toList();

      // var prices = updatedPriceFilters.where((filter) => filter.value).map((filter) => filter.price.price).toList();

      emit(
        FiltersLoaded(
          filter: Filter(
            categoryFilters: state.filter.categoryFilters,
            priceFilters: updatedPriceFilters,
          ),
        ),
      );
    }
  }
}


// import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';
// import '/models/models.dart';

// part 'filters_event.dart';
// part 'filters_state.dart';

// class FilterBloc extends Bloc<FilterEvent, FilterState> {
//   final RestaurantsBloc _restaurantsBloc;

//   FilterBloc({required RestaurantsBloc restaurantsBloc})
//       : _restaurantsBloc = restaurantsBloc,
//         super(FilterLoading()) {
//     on<LoadFilter>(_onLoadFilter);
//     on<UpdateCategoryFilter>(_onUpdateCategoryFilter);
//     on<UpdatePriceFilter>(_onUpdatePriceFilter);
//   }

//   void _onLoadFilter(
//     LoadFilter event,
//     Emitter<FilterState> emit,
//   ) async {
//     emit(
//       FilterLoaded(
//         filter: Filter(
//           categoryFilters: CategoryFilter.filters,
//           priceFilters: PriceFilter.filters,
//         ),
//       ),
//     );
//   }

//   void _onUpdateCategoryFilter(
//     UpdateCategoryFilter event,
//     Emitter<FilterState> emit,
//   ) async {
//     final state = this.state;
//     if (state is FilterLoaded) {
//       final List<CategoryFilter> updatedCategoryFilters =
//           state.filter.categoryFilters.map((categoryFilter) {
//         return categoryFilter.id == event.categoryFilter.id
//             ? event.categoryFilter
//             : categoryFilter;
//       }).toList();

//       var categories = updatedCategoryFilters
//           .where((filter) => filter.value)
//           .map((filter) => filter.category)
//           .toList();

//       var prices = state.filter.priceFilters
//           .where((filter) => filter.value)
//           .map((filter) => filter.price.price)
//           .toList();

//       List<Restaurant> filteredRestaurants = _getFilteredRestaurants(
//         categories,
//         prices,
//       );

//       emit(
//         FilterLoaded(
//           filter: Filter(
//             categoryFilters: updatedCategoryFilters,
//             priceFilters: state.filter.priceFilters,
//           ),
//           filteredRestaurants: filteredRestaurants,
//         ),
//       );
//     }
//   }

//   void _onUpdatePriceFilter(
//     UpdatePriceFilter event,
//     Emitter<FilterState> emit,
//   ) async {
//     final state = this.state;
//     if (state is FilterLoaded) {
//       final List<PriceFilter> updatedPriceFilters =
//           state.filter.priceFilters.map((priceFilter) {
//         return priceFilter.id == event.priceFilter.id
//             ? event.priceFilter
//             : priceFilter;
//       }).toList();

//       var categories = state.filter.categoryFilters
//           .where((filter) => filter.value)
//           .map((filter) => filter.category)
//           .toList();

//       var prices = updatedPriceFilters
//           .where((filter) => filter.value)
//           .map((filter) => filter.price.price)
//           .toList();

//       List<Restaurant> filteredRestaurants = _getFilteredRestaurants(
//         categories,
//         prices,
//       );

//       emit(
//         FilterLoaded(
//           filter: Filter(
//             categoryFilters: state.filter.categoryFilters,
//             priceFilters: updatedPriceFilters,
//           ),
//           filteredRestaurants: filteredRestaurants,
//         ),
//       );
//     }
//   }

//   List<Restaurant> _getFilteredRestaurants(
//     List<Category> categories,
//     List<String> prices,
//   ) {
//     return (_restaurantsBloc.state as RestaurantsLoaded)
//         .restaurants
//         .where(
//           (restaurant) => categories.any(
//             (category) => restaurant.categories.contains(category),
//           ),
//         )
//         .where(
//           (restaurant) => prices.any(
//             (price) => restaurant.priceCategory.contains(price),
//           ),
//         )
//         .toList();
//   }
// }
