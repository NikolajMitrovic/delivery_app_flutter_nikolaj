import 'package:delivery_app_flutter/blocs/autocomplete_bloc/autocomplete_bloc.dart';
import 'package:delivery_app_flutter/blocs/basket/basket_bloc.dart';
import 'package:delivery_app_flutter/blocs/filters/filters_bloc.dart';
import 'package:delivery_app_flutter/blocs/place_bloc/place_bloc.dart';
import 'package:delivery_app_flutter/blocs/voucher/voucher_bloc.dart';
import 'package:delivery_app_flutter/config/app_router.dart';
import 'package:delivery_app_flutter/config/theme.dart';
import 'package:delivery_app_flutter/repositories/geolocation/geolocation_repository.dart';
import 'package:delivery_app_flutter/repositories/places/places_repository.dart';
import 'package:delivery_app_flutter/repositories/voucher/voucher_repository.dart';
import 'package:delivery_app_flutter/screens/screens.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/blocs/location/location_bloc.dart';

void main() async {
  // BlocOverrides.runZoned(
  //   () {
  //     runApp(const MyApp());
  //   },
  //   blocObserver: SimpleBlocObserver(),
  // );
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<GeolocationRepository>(
          create: (_) => GeolocationRepository(),
        ),
        RepositoryProvider<PlacesRepository>(
          create: (_) => PlacesRepository(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => LocationBloc(
              geolocationRepository: context.read<GeolocationRepository>(),
              placesRepository: context.read<PlacesRepository>(),
            )..add(const LoadMap()),
          ),
          BlocProvider(
            create: (context) => AutocompleteBloc(
              placesRepository: context.read<PlacesRepository>(),
            )..add(
                const LoadAutocomplete(),
              ),
          ),
          BlocProvider(
            create: (context) => PlaceBloc(
              placesRepository: context.read<PlacesRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) => FiltersBloc()
              ..add(
                FilterLoad(),
              ),
          ),
          BlocProvider(
            create: (context) => VoucherBloc(voucherRepository: VoucherRepository())
              ..add(
                LoadVouchers(),
              ),
          ),
          BlocProvider(
            create: (context) => BasketBloc()
              ..add(
                StartBasket(),
              ),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Delivery App',
          theme: theme(),
          onGenerateRoute: AppRouter.onGenerateRoute,
          initialRoute: HomeScreen.routeName,
        ),
      ),
    );
  }
}
