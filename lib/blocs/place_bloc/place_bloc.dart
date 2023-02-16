import 'dart:async';

import 'package:delivery_app_flutter/models/place_model.dart';
import 'package:delivery_app_flutter/repositories/places/places_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'place_event.dart';
part 'place_state.dart';

class PlaceBloc extends Bloc<PlaceEvent, PlaceState> {
  final PlacesRepository _placesRepository;
  StreamSubscription? _placesSubsrciption;
  PlaceBloc({required PlacesRepository placesRepository})
      : _placesRepository = placesRepository,
        super(PlaceLoading()) {
    on<LoadPLace>(_loadPlace);
  }

  Future<void> _loadPlace(LoadPLace event, Emitter<PlaceState> emit) async {
    emit(PlaceLoading());
    try {
      _placesSubsrciption?.cancel();
      final Place? place = await _placesRepository.getPlace(event.placeId);
      emit(PlaceLoaded(place: place!));
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Future<void> close() {
    _placesSubsrciption?.cancel();
    return super.close();
  }
}
