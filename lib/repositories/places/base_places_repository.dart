import 'package:delivery_app_flutter/models/place_model.dart';

import '../../models/place_autocomplete_model.dart';

abstract class BasePlacesRepository {
  Future<List<PlaceAutocomplete>> getAutocomplete(String searchInput);
  Future<Place?> getPlace(String placeId) async {}
}
