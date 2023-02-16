import 'package:equatable/equatable.dart';

import 'models.dart';

class Restaurant extends Equatable {
  final int id;
  final String name;
  final String imageUrl;
  final List<String> tags;
  final int deliveryTime;
  final String priceCategory;
  final double deliveryFee;
  final double distance;

  final List<MenuItem> menuItems;

  const Restaurant({
    required this.menuItems,
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.tags,
    required this.deliveryTime,
    required this.priceCategory,
    required this.deliveryFee,
    required this.distance,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        imageUrl,
        tags,
        deliveryTime,
        deliveryFee,
        distance,
      ];

  static List<Restaurant> restaurants = [
    Restaurant(
      id: 1,
      name: 'Golden Ice Gelato Artigianale',
      imageUrl: 'https://imgs.search.brave.com/ad6aIiunnjBYLYfuFvBGit289M9WxXyDtnHjFCgPiRs/rs:fit:1200:795:1/g:ce/aHR0cHM6Ly9tdi1p/bnRlcmlvci1kZXNp/Z24uZGUvd3AtY29u/dGVudC91cGxvYWRz/LzIwMjEvMDYvMS0x/LmpwZw',
      tags: MenuItem.menuItems.where((menuItem) => menuItem.restaurantId == 1).map((menuItem) => menuItem.category).toSet().toList(),
      menuItems: MenuItem.menuItems.where((menuItem) => menuItem.restaurantId == 1).toList(),
      deliveryTime: 30,
      priceCategory: '\$',
      deliveryFee: 2.99,
      distance: 0.1,
    ),
    Restaurant(
      id: 2,
      name: 'Il Panino del Laghetto',
      imageUrl: 'https://imgs.search.brave.com/787i1etdj7CsSI920y56pasSqucF_7H-SiUZjZJBW2c/rs:fit:1200:800:1/g:ce/aHR0cDovL3d3dy5s/YWdlbGF0ZXJpYS5m/aS93cC1jb250ZW50/L3VwbG9hZHMvMjAy/MC8wOC9jZW50ZXIt/c2hvcC0xMjAweDgw/MC5qcGc',
      tags: MenuItem.menuItems.where((menuItem) => menuItem.restaurantId == 2).map((menuItem) => menuItem.category).toSet().toList(),
      menuItems: MenuItem.menuItems.where((menuItem) => menuItem.restaurantId == 2).toList(),
      deliveryTime: 30,
      priceCategory: '\$',
      deliveryFee: 2.99,
      distance: 0.3,
    ),
    Restaurant(
      id: 3,
      name: 'Viaggi Nel Gusto',
      imageUrl: 'https://images.unsplash.com/photo-1644917777632-04f68ce502dd?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8OHx8cGl6emVyaWElMjBpdGFsaWF8ZW58MHwwfDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60',
      tags: MenuItem.menuItems.where((menuItem) => menuItem.restaurantId == 3).map((menuItem) => menuItem.category).toSet().toList(),
      menuItems: MenuItem.menuItems.where((menuItem) => menuItem.restaurantId == 3).toList(),
      deliveryTime: 30,
      priceCategory: '\$',
      deliveryFee: 2.99,
      distance: 0.5,
    ),
    Restaurant(
      id: 4,
      name: 'Burgers',
      imageUrl: 'https://images.unsplash.com/photo-1501688190156-9e816757373a?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Nnx8YW1lcmljYW4lMjBidXJnZXJ8ZW58MHwwfDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60',
      tags: MenuItem.menuItems.where((menuItem) => menuItem.restaurantId == 4).map((menuItem) => menuItem.category).toSet().toList(),
      menuItems: MenuItem.menuItems.where((menuItem) => menuItem.restaurantId == 4).toList(),
      deliveryTime: 30,
      priceCategory: '\$',
      deliveryFee: 2.99,
      distance: 0.65,
    ),
    Restaurant(
      id: 5,
      name: 'Tandoori Bites',
      imageUrl: 'https://images.unsplash.com/photo-1587574293340-e0011c4e8ecf?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Nnx8aW5kaWFuJTIwcmVzdGF1cmFudHxlbnwwfDB8MHx8&auto=format&fit=crop&w=500&q=60',
      tags: MenuItem.menuItems.where((menuItem) => menuItem.restaurantId == 5).map((menuItem) => menuItem.category).toSet().toList(),
      menuItems: MenuItem.menuItems.where((menuItem) => menuItem.restaurantId == 5).toList(),
      deliveryTime: 30,
      priceCategory: '\$',
      deliveryFee: 2.99,
      distance: 0.65,
    ),
  ];
}
