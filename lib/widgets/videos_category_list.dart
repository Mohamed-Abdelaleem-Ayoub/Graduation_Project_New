import 'package:flutter/material.dart';

import 'package:graduation_project/widgets/videos_category.dart';

class CategoryList extends StatelessWidget {
  const CategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return const VideosCategory();
      },
    );
  }
}
