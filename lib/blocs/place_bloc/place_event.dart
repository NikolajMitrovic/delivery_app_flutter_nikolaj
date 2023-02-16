// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'place_bloc.dart';

abstract class PlaceEvent extends Equatable {
  const PlaceEvent();

  @override
  List<Object> get props => [];
}

class LoadPLace extends PlaceEvent {
  final String placeId;
  const LoadPLace({
    required this.placeId,
  });
  @override
  List<Object> get props => [];
}
