import 'package:delivery_app_flutter/blocs/autocomplete_bloc/autocomplete_bloc.dart';
import 'package:delivery_app_flutter/blocs/location/location_bloc.dart';
import 'package:delivery_app_flutter/widgets/location_search_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationScreen extends StatefulWidget {
  static const String routeName = '/location';

  const LocationScreen({super.key});

  static Route route() {
    return MaterialPageRoute(
      builder: (_) => const LocationScreen(),
      settings: const RouteSettings(name: routeName),
    );
  }

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  final controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<LocationBloc, LocationState>(
        builder: (context, state) {
          if (state is LocationLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is LocationLoaded) {
            return Stack(
              children: [
                GoogleMap(
                  myLocationEnabled: true,
                  onMapCreated: (GoogleMapController controller) {
                    context.read<LocationBloc>().add(
                          LoadMap(controller: controller),
                        );
                  },
                  initialCameraPosition: CameraPosition(
                    target: LatLng(state.lat, state.lng),
                    zoom: 13,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 40,
                  ),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset('assets/logo.svg', height: 50),
                          const SizedBox(width: 10),
                          Expanded(
                            child: LocationSearchBox(
                              controller: controller,
                            ),
                          ),
                        ],
                      ),
                      BlocBuilder<AutocompleteBloc, AutocompleteState>(
                        builder: (context, state) {
                          if (state is AutocompleteLoading) {
                            return const SizedBox();
                          }
                          if (state is AutocompleteLoaded) {
                            if (state.autocomplete.isEmpty) {
                              return Container();
                            }
                            return Container(
                              height: 300,
                              color: Colors.black.withOpacity(0.6),
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: state.autocomplete.length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    title: Text(
                                      state.autocomplete[index].description,
                                      style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.white),
                                    ),
                                    onTap: () {
                                      // context.read<PlaceBloc>().add(
                                      //       LoadPLace(placeId: state.autocomplete[index].placeId),
                                      //     );
                                      context.read<LocationBloc>().add(
                                            SearchLocation(
                                              placeId: state.autocomplete[index].placeId,
                                            ),
                                          );
                                      context.read<AutocompleteBloc>().add(
                                            ClearAutocomplete(),
                                          );
                                      controller.clear();
                                    },
                                  );
                                },
                              ),
                            );
                          } else {
                            return const Text('Something went wrong!');
                          }
                        },
                      ),
                      const Expanded(child: SizedBox()),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).colorScheme.primary,
                          fixedSize: const Size(200, 40),
                        ),
                        child: const Text('Save'),
                        onPressed: () {
                          Navigator.pushNamed(context, '/');
                        },
                      ),
                    ],
                  ),
                ),
              ],
            );
          } else {
            return const Text('Something went wrong!');
          }
        },
      ),
    );
  }
}

class _GoogleMap extends StatelessWidget {
  const _GoogleMap({
    Key? key,
    required this.lat,
    required this.lng,
  }) : super(key: key);

  final double lat;
  final double lng;

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      myLocationEnabled: true,
      onMapCreated: (GoogleMapController controller) {
        context.read<LocationBloc>().add(
              LoadMap(controller: controller),
            );
      },
      initialCameraPosition: CameraPosition(
        target: LatLng(lat, lng),
        zoom: 13,
      ),
    );
  }
}
