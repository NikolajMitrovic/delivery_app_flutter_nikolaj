import 'package:flutter/material.dart';

import '../models/models.dart';

class CategoryBox extends StatelessWidget {
  final Category category;
  const CategoryBox({
    Key? key,
    required this.category,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Restaurant> restaurants = Restaurant.restaurants
        .where(
          (restaurant) => restaurant.tags.contains(category.name),
        )
        .toList();
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, '/restaurant-listing', arguments: restaurants);
      },
      child: Container(
        margin: const EdgeInsets.only(right: 5),
        width: 80,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Stack(
          children: [
            Positioned(
              top: 10,
              left: 10,
              child: Container(
                height: 50,
                width: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.white,
                ),
                child: category.image,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  category.name,
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
