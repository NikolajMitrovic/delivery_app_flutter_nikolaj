// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/filters/filters_bloc.dart';
import '../../models/restaurant_model.dart';
import '../../widgets/widgets.dart';

class FilterScreen extends StatelessWidget {
  const FilterScreen({super.key});
  static const String routeName = '/filter';
  static Route route() {
    return MaterialPageRoute(
      builder: (_) => const FilterScreen(),
      settings: const RouteSettings(name: routeName),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Filter Screen'),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocBuilder<FiltersBloc, FiltersState>(
              builder: (context, state) {
                if (state is FiltersLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state is FiltersLoaded) {
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      backgroundColor: Theme.of(context).colorScheme.secondary,
                      shape: const RoundedRectangleBorder(),
                    ),
                    onPressed: () {
                      var categories = state.filter.categoryFilters.where((filter) => filter.value).map((filter) => filter.category.name).toList();
                      var prices = state.filter.priceFilters.where((filter) => filter.value).map((filter) => filter.price.price).toList();

                      List<Restaurant> restaurants = Restaurant.restaurants
                          .where(
                            (restaurant) => categories.any(
                              (category) => restaurant.tags.contains(category),
                            ),
                          )
                          .where(
                            (restaurant) => prices.any(
                              (price) => restaurant.priceCategory.contains(price),
                            ),
                          )
                          .toList();

                      Navigator.pushNamed(context, '/restaurant-listing', arguments: restaurants);
                    },
                    child: const Text('Apply'),
                  );
                } else {
                  return const Text('Something went wrong');
                }
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Price',
              style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
            ),
            const CustomPriceFilter(),
            Text(
              'Category',
              style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
            ),
            const CustomCategoryFilter(),
          ],
        ),
      ),
    );
  }
}
