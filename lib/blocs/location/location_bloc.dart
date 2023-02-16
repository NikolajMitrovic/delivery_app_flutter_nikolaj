import 'dart:async';

import 'package:delivery_app_flutter/models/place_model.dart';
import 'package:delivery_app_flutter/repositories/geolocation/geolocation_repository.dart';
import 'package:delivery_app_flutter/repositories/places/base_places_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  final BasePlacesRepository placesRepository;
  final GeolocationRepository geolocationRepository;
  StreamSubscription? placesSubscription;
  StreamSubscription? geolocationSubscription;

  LocationBloc({
    required this.placesRepository,
    required this.geolocationRepository,
  }) : super(LocationLoading()) {
    on<LoadMap>(_onLoadMap);
    on<SearchLocation>(_onSearchLocation);
  }

  Future<void> _onLoadMap(
    LoadMap event,
    Emitter<LocationState> emit,
  ) async {
    final Position position = await geolocationRepository.getCurrentLocation();

    emit(
      LocationLoaded(
        controller: event.controller,
        lat: position.latitude,
        lng: position.longitude,
      ),
    );
  }

  Future<void> _onSearchLocation(
    SearchLocation event,
    Emitter<LocationState> emit,
  ) async {
    final state = this.state as LocationLoaded;
    final Place? place = await placesRepository.getPlace(event.placeId);

    state.controller!.animateCamera(
      CameraUpdate.newLatLng(
        LatLng(place!.lat, place.lon),
      ),
    );

    emit(
      LocationLoaded(
        controller: state.controller,
        lat: place.lat,
        lng: place.lon,
      ),
    );
  }

  @override
  Future<void> close() {
    placesSubscription?.cancel();
    geolocationSubscription?.cancel();
    return super.close();
  }
}
