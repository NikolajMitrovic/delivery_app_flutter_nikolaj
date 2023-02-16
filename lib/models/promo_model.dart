// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class Promo extends Equatable {
  final int id;
  final String title;
  final String description;
  final String imageUrl;
  const Promo({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        imageUrl,
      ];

  static List<Promo> promos = [
    const Promo(
      id: 1,
      title: 'FREE Delivery on Your First 3 Orders!',
      description: 'Place an order of \$10 or more and the delivey fee is on us!',
      imageUrl: 'https://images.unsplash.com/photo-1551248429-40975aa4de74?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8OHx8c2FsYWR8ZW58MHwwfDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60',
    ),
    const Promo(
      id: 2,
      title: '20% off on Selected Restaurants!',
      description: 'Get a discount at more than 200 restaurants!',
      imageUrl: 'https://images.unsplash.com/photo-1522336572468-97b06e8ef143?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MjZ8fHJlc3RhdXJhbnR8ZW58MHwwfDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60',
    ),
  ];
}
