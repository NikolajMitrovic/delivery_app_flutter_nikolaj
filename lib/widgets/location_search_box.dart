// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:delivery_app_flutter/blocs/autocomplete_bloc/autocomplete_bloc.dart';

class LocationSearchBox extends StatelessWidget {
  const LocationSearchBox({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AutocompleteBloc, AutocompleteState>(
      builder: (context, state) {
        if (state is AutocompleteLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is AutocompleteLoaded) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: controller,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: 'Enter your location',
                suffixIcon: const Icon(Icons.search),
                contentPadding: const EdgeInsets.only(
                  left: 20,
                  top: 5,
                  right: 5,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.white),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.white),
                ),
              ),
              onChanged: ((value) {
                context.read<AutocompleteBloc>().add(
                      LoadAutocomplete(searchInput: value),
                    );
              }),
            ),
          );
        } else {
          return const Text('Something went wrong');
        }
      },
    );
  }
}
