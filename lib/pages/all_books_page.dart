import 'package:flutter/material.dart';
import 'package:graduation_project/constans.dart';
import 'package:graduation_project/models/book_model.dart';
import 'package:graduation_project/services/get_all_books_service.dart';
import 'package:graduation_project/widgets/all_books_list.dart';

class AllBooksPage extends StatefulWidget {
  static String id = 'AllBooksPage';
  const AllBooksPage({super.key});

  @override
  State<AllBooksPage> createState() => _AllBooksPageState();
}

class _AllBooksPageState extends State<AllBooksPage> {
  late Future<List<BookModel>> _booksFuture;
  TextEditingController searchController = TextEditingController();
  List<BookModel> allBooks = [];
  List<BookModel> filteredBooks = [];

  @override
  void initState() {
    super.initState();
    _booksFuture = AllBookService.fetchBooks().then((books) {
      allBooks = books;
      filteredBooks = books;
      return books;
    });
  }

  void filterSearchResults(String query) {
    if (query.isEmpty) {
      setState(() => filteredBooks = allBooks);
      return;
    }

    setState(() {
      filteredBooks =
          allBooks.where((book) {
            return book.title.toLowerCase().contains(query.toLowerCase());
          }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        elevation: 0,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Hi , ',
              style: TextStyle(
                color: Color(0xff333333),
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              'Jenny',
              style: TextStyle(
                color: Color(0xffFF8EA2),
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Icon(
                Icons.waving_hand_rounded,
                color: Colors.amber,
                size: 15,
              ),
            ),
          ],
        ),
        actions: const [
          Icon(Icons.settings),
          Padding(
            padding: EdgeInsets.only(left: 8),
            child: Icon(Icons.notifications_none),
          ),
        ],
      ),
      body: FutureBuilder<List<BookModel>>(
        future: _booksFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('حدث خطأ: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('لا توجد كتب حالياً'));
          }

          return Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                const SliverToBoxAdapter(child: SizedBox(height: 20)),
                //    const   SliverToBoxAdapter(child: SizedBox(height: 20)),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),

                    child: TextField(
                      controller: searchController,
                      decoration: InputDecoration(
                        hintText: 'ابحث عن كتاب...',
                        prefixIcon: const Icon(Icons.search),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            searchController.clear();
                            filterSearchResults('');
                          },
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onChanged: filterSearchResults,
                    ),
                  ),
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 120)),
                AllBooksList(books: filteredBooks),
              ],
            ),
          );
        },
      ),
    );
  }
}
