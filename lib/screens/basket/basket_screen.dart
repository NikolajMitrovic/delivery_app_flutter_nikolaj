import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../blocs/basket/basket_bloc.dart';

class BasketScreen extends StatelessWidget {
  const BasketScreen({super.key});
  static const String routeName = '/basket';
  static Route route() {
    return MaterialPageRoute(
      builder: (_) => const BasketScreen(),
      settings: const RouteSettings(name: routeName),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Basket',
          style: Theme.of(context).textTheme.displaySmall!.copyWith(
                color: Colors.white,
              ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/edit-basket');
            },
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
                Navigator.pushNamed(context, '/checkout');
              },
              child: const Text('Go To Checkout'),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Cutlery',
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.only(
                  top: 10,
                  bottom: 10,
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Do you need cutlery?',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                    BlocBuilder<BasketBloc, BasketState>(
                      builder: (context, state) {
                        if (state is BasketLoading) {
                          return const Center(child: CircularProgressIndicator());
                        } else if (state is BasketLoaded) {
                          return SizedBox(
                            width: 100,
                            child: SwitchListTile(
                              activeColor: Theme.of(context).colorScheme.primary,
                              dense: false,
                              value: state.basket.cutlery,
                              onChanged: (bool? newValue) {
                                context.read<BasketBloc>().add(const ToggleSwitch());
                              },
                            ),
                          );
                        } else {
                          return const Text('Something went wrong');
                        }
                      },
                    ),
                  ],
                ),
              ),
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
                                    Text(
                                      '\$${state.basket.itemQuantity(state.basket.items).keys.elementAt(index).price * state.basket.itemQuantity(state.basket.items).entries.elementAt(index).value}',
                                      style: Theme.of(context).textTheme.titleLarge,
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
              Container(
                height: 100,
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.only(
                  top: 5,
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SvgPicture.asset('assets/delivery.svg'),
                    BlocBuilder<BasketBloc, BasketState>(
                      builder: (context, state) {
                        if (state is BasketLoaded) {
                          return (state.basket.deliveryTime == null)
                              ? Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      'Delivery in 20 minutes',
                                      style: Theme.of(context).textTheme.titleLarge,
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pushNamed(context, '/delivery-time');
                                      },
                                      child: Text(
                                        'Change',
                                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                                              color: Theme.of(context).colorScheme.secondary,
                                            ),
                                      ),
                                    )
                                  ],
                                )
                              : Text(
                                  'Delivery at ${state.basket.deliveryTime!.value}',
                                  style: Theme.of(context).textTheme.headlineSmall,
                                );
                        } else {
                          return const Text(
                            'Something went wrong',
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
              Container(
                height: 100,
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.only(
                  top: 5,
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BlocBuilder<BasketBloc, BasketState>(
                      builder: (context, state) {
                        if (state is BasketLoaded) {
                          return (state.basket.voucher == null)
                              ? Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      'Do you have a voucher?',
                                      style: Theme.of(context).textTheme.titleLarge,
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pushNamed(context, '/vouchers');
                                      },
                                      child: Text(
                                        'Apply',
                                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                                              color: Theme.of(context).colorScheme.secondary,
                                            ),
                                      ),
                                    ),
                                  ],
                                )
                              : Text(
                                  'Your voucher is added!',
                                  style: Theme.of(context).textTheme.titleLarge,
                                );
                        } else {
                          return const Text('Something went wrong');
                        }
                      },
                    ),
                    SvgPicture.asset('assets/delivery.svg'),
                  ],
                ),
              ),
              Container(
                height: 100,
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.only(
                  top: 5,
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: BlocBuilder<BasketBloc, BasketState>(
                  builder: (context, state) {
                    if (state is BasketLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (state is BasketLoaded) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Subtotal',
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              Text(
                                '\$${state.basket.subtotalString}',
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Delivery fee',
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                                Text(
                                  '\$5.0',
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Total',
                                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                                      color: Theme.of(context).colorScheme.secondary,
                                    ),
                              ),
                              Text(
                                '\$${state.basket.totalString}',
                                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                                      color: Theme.of(context).colorScheme.secondary,
                                    ),
                              ),
                            ],
                          ),
                        ],
                      );
                    } else {
                      return const Text('Something went wrong');
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
