import 'package:delivery_app_flutter/models/restaurant_model.dart';
import 'package:delivery_app_flutter/widgets/widgets.dart';
import 'package:flutter/material.dart';

class RestaurantListingScreen extends StatelessWidget {
  const RestaurantListingScreen({required this.restaurants, super.key});
  static const String routeName = '/restaurant-listing';
  static Route route({required List<Restaurant> restaurants}) {
    return MaterialPageRoute(
      builder: (_) => RestaurantListingScreen(restaurants: restaurants),
      settings: const RouteSettings(name: routeName),
    );
  }

  final List<Restaurant> restaurants;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Restaurant'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
              itemCount: restaurants.length,
              itemBuilder: (context, index) {
                return RestaurantCard(
                  restaurant: restaurants[index],
                );
              }),
        ));
  }
}
