import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/filters/filters_bloc.dart';

class CustomCategoryFilter extends StatelessWidget {
  const CustomCategoryFilter({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FiltersBloc, FiltersState>(
      builder: (context, state) {
        if (state is FiltersLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is FiltersLoaded) {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: state.filter.categoryFilters.length,
            itemBuilder: (context, index) {
              return Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.only(
                  top: 10,
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      state.filter.categoryFilters[index].category.name,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    SizedBox(
                      height: 25,
                      child: Checkbox(
                        activeColor: Theme.of(context).colorScheme.secondary,
                        value: state.filter.categoryFilters[index].value,
                        onChanged: (bool? newValue) {
                          context.read<FiltersBloc>().add(
                                CategoryFilterUpdate(
                                  categoryFilter: state.filter.categoryFilters[index].copyWith(
                                    value: !state.filter.categoryFilters[index].value,
                                  ),
                                ),
                              );
                        },
                      ),
                    )
                  ],
                ),
              );
            },
          );
        } else {
          return const Text('Something went wrong');
        }
      },
    );
  }
}
