import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/place_autocomplete_model.dart';
import '../../repositories/places/base_places_repository.dart';

part 'autocomplete_event.dart';
part 'autocomplete_state.dart';

class AutocompleteBloc extends Bloc<AutocompleteEvent, AutocompleteState> {
  final BasePlacesRepository placesRepository;
  StreamSubscription? placesSubscription;

  AutocompleteBloc({required this.placesRepository}) : super(AutocompleteLoading()) {
    on<LoadAutocomplete>(_onLoadAutocomplete);
    on<ClearAutocomplete>(_onClearAutocomplete);
  }

  void _onLoadAutocomplete(LoadAutocomplete event, Emitter<AutocompleteState> emit) async {
    try {
      final List<PlaceAutocomplete> autocomplete = await placesRepository.getAutocomplete(event.searchInput);
      emit(AutocompleteLoaded(autocomplete: autocomplete));
    } catch (e) {
      debugPrint(e.toString());
      emit(AutocompleteError());
    }
  }

  void _onClearAutocomplete(ClearAutocomplete event, Emitter<AutocompleteState> emit) async {
    emit(AutocompleteLoaded(autocomplete: List.empty()));
  }

  @override
  Future<void> close() async {
    placesSubscription?.cancel();
    super.close();
  }
}
