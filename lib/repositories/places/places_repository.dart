import 'dart:convert';

import 'package:delivery_app_flutter/models/place_autocomplete_model.dart';
import 'package:delivery_app_flutter/models/place_model.dart';
import 'package:delivery_app_flutter/repositories/places/base_places_repository.dart';
import 'package:http/http.dart' as http;

class PlacesRepository implements BasePlacesRepository {
  final String key = 'AIzaSyDSLsavKSt2Soiks-p1tN8ANAleqXugkyU';
  final String types = 'geocode';

  @override
  Future<List<PlaceAutocomplete>> getAutocomplete(String searchInput) async {
    final String url = 'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$searchInput&types=$types&key=$key';

    var response = await http.get(Uri.parse(url));
    var json = jsonDecode(response.body);
    var results = json['predictions'] as List;
    final result = results.map((place) => PlaceAutocomplete.fromJson(place)).toList();
    return result;
  }

  @override
  Future<Place?> getPlace(String placeId) async {
    final String url = 'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$key';
    var response = await http.get(Uri.parse(url));
    var json = jsonDecode(response.body);
    var result = json['result'];
    return Place.fromJson(result);
  }
}
