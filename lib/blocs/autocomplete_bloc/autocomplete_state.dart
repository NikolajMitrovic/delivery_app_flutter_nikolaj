// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'autocomplete_bloc.dart';

abstract class AutocompleteState extends Equatable {
  const AutocompleteState();

  @override
  List<Object> get props => [];
}

class AutocompleteLoading extends AutocompleteState {}

class AutocompleteLoaded extends AutocompleteState {
  final List<PlaceAutocomplete> autocomplete;
  const AutocompleteLoaded({
    required this.autocomplete,
  });
  @override
  List<Object> get props => [autocomplete];
}

class AutocompleteError extends AutocompleteState {}
