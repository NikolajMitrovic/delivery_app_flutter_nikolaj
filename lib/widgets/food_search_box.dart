import 'package:flutter/material.dart';

class FoodSearchBox extends StatelessWidget {
  const FoodSearchBox({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              // controller: controller,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: 'What would you like to eat?',
                suffixIcon: Icon(
                  Icons.search,
                  color: Theme.of(context).colorScheme.primary,
                ),
                contentPadding: const EdgeInsets.only(
                  left: 20,
                  top: 12.5,
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
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
            ),
            child: IconButton(
              icon: Icon(
                Icons.menu,
                color: Theme.of(context).colorScheme.primary,
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/filter');
              },
            ),
          )
        ],
      ),
    );
  }
}
