import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/basket/basket_bloc.dart';

class EditBasketScreen extends StatelessWidget {
  const EditBasketScreen({super.key});
  static const String routeName = '/edit-basket';
  static Route route() {
    return MaterialPageRoute(
      builder: (_) => const EditBasketScreen(),
      settings: const RouteSettings(name: routeName),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Edit Basket',
          style: Theme.of(context).textTheme.displaySmall!.copyWith(
                color: Colors.white,
              ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.edit),
            splashRadius: 20,
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                backgroundColor: Theme.of(context).colorScheme.secondary,
                shape: const RoundedRectangleBorder(),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Done'),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Items',
              style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
            ),
            BlocBuilder<BasketBloc, BasketState>(
              builder: (context, state) {
                if (state is BasketLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is BasketLoaded) {
                  return state.basket.items.isEmpty
                      ? Container(
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.only(top: 5),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 30,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'No items in the basket',
                                textAlign: TextAlign.left,
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                            ],
                          ),
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          itemCount: state.basket.itemQuantity(state.basket.items).keys.length,
                          itemBuilder: (context, index) {
                            return Container(
                              width: MediaQuery.of(context).size.width,
                              margin: const EdgeInsets.only(
                                top: 5,
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 30,
                                vertical: 10,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Row(
                                children: [
                                  Text(
                                    '${state.basket.itemQuantity(state.basket.items).entries.elementAt(index).value}x',
                                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                                          color: Theme.of(context).colorScheme.secondary,
                                        ),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Expanded(
                                    child: Text(
                                      '${state.basket.itemQuantity(state.basket.items).keys.elementAt(index).name}',
                                      style: Theme.of(context).textTheme.titleLarge,
                                    ),
                                  ),
                                  IconButton(
                                    splashRadius: 20,
                                    visualDensity: VisualDensity.compact,
                                    onPressed: () {
                                      context.read<BasketBloc>().add(
                                            RemoveAllItem(
                                              state.basket.itemQuantity(state.basket.items).keys.elementAt(index),
                                            ),
                                          );
                                    },
                                    icon: const Icon(Icons.delete),
                                    color: Theme.of(context).colorScheme.secondary,
                                  ),
                                  IconButton(
                                    splashRadius: 20,
                                    visualDensity: VisualDensity.compact,
                                    onPressed: () {
                                      context.read<BasketBloc>().add(
                                            RemoveItem(
                                              state.basket.itemQuantity(state.basket.items).keys.elementAt(index),
                                            ),
                                          );
                                    },
                                    icon: const Icon(Icons.remove_circle),
                                    color: Theme.of(context).colorScheme.secondary,
                                  ),
                                  IconButton(
                                    splashRadius: 20,
                                    visualDensity: VisualDensity.compact,
                                    onPressed: () {
                                      context.read<BasketBloc>().add(
                                            AddItem(
                                              state.basket.itemQuantity(state.basket.items).keys.elementAt(index),
                                            ),
                                          );
                                    },
                                    icon: const Icon(Icons.add_circle),
                                    color: Theme.of(context).colorScheme.secondary,
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                } else {
                  return const Text('Something went wrong');
                }
              },
            ),
            // Container(
            //   height: 100,
            //   width: MediaQuery.of(context).size.width,
            //   margin: const EdgeInsets.only(
            //     top: 5,
            //   ),
            //   padding: const EdgeInsets.symmetric(
            //     horizontal: 30,
            //   ),
            //   decoration: BoxDecoration(
            //     color: Colors.white,
            //     borderRadius: BorderRadius.circular(5),
            //   ),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       SvgPicture.asset('assets/delivery.svg'),
            //       Column(
            //         mainAxisAlignment: MainAxisAlignment.center,
            //         children: [
            //           const SizedBox(
            //             height: 20,
            //           ),
            //           Text(
            //             'Delivery in 20 minutes',
            //             style: Theme.of(context).textTheme.headline6,
            //           ),
            //           TextButton(
            //             onPressed: () {},
            //             child: Text(
            //               'Change',
            //               style: Theme.of(context).textTheme.headline6!.copyWith(
            //                     color: Theme.of(context).colorScheme.secondary,
            //                   ),
            //             ),
            //           )
            //         ],
            //       ),
            //     ],
            //   ),
            // ),
            // Container(
            //   height: 100,
            //   width: MediaQuery.of(context).size.width,
            //   margin: const EdgeInsets.only(
            //     top: 5,
            //   ),
            //   padding: const EdgeInsets.symmetric(
            //     horizontal: 30,
            //   ),
            //   decoration: BoxDecoration(
            //     color: Colors.white,
            //     borderRadius: BorderRadius.circular(5),
            //   ),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       Column(
            //         mainAxisAlignment: MainAxisAlignment.center,
            //         children: [
            //           const SizedBox(
            //             height: 20,
            //           ),
            //           Text(
            //             'Dp you have a voucher?',
            //             style: Theme.of(context).textTheme.headline6,
            //           ),
            //           TextButton(
            //             onPressed: () {},
            //             child: Text(
            //               'Apply',
            //               style: Theme.of(context).textTheme.headline6!.copyWith(
            //                     color: Theme.of(context).colorScheme.secondary,
            //                   ),
            //             ),
            //           ),
            //         ],
            //       ),
            //       SvgPicture.asset('assets/delivery.svg'),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
