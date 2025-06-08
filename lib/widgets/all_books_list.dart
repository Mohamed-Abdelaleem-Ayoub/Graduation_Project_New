import 'package:flutter/material.dart';
import 'package:graduation_project/models/book_model.dart';
import 'package:graduation_project/widgets/custom_book_card.dart';

class AllBooksList extends StatelessWidget {
  final List<BookModel> books;
  const AllBooksList({super.key, required this.books});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      sliver: SliverGrid(
        delegate: SliverChildBuilderDelegate(
          (context, index) => CustomBookCard(book: books[index]),
          childCount: books.length,
        ),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 150,
          crossAxisSpacing: 2,

          childAspectRatio: 162 / 250,
        ),
      ),
    );
  }
}
