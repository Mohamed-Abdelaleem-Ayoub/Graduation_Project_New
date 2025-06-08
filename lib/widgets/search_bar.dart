import 'package:flutter/material.dart';
import 'package:graduation_project/constans.dart';

class SearchBarWidget extends StatelessWidget {
  final double height;
  const SearchBarWidget({super.key, this.height = 60});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: SizedBox(
        height: 60,
        child: TextField(
          decoration: InputDecoration(
            fillColor: kBackgroundColor,
            suffixIcon: const Icon(Icons.search, size: 32),
            hintText: '  Search...',
            hintStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(24)),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.grey),
              borderRadius: BorderRadius.circular(24),
            ),
          ),
        ),
      ),
    );
  }
}
