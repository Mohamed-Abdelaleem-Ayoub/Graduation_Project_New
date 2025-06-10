import 'package:flutter/material.dart';
import 'package:graduation_project/constans.dart';
//import 'package:graduation_project/helpers/book_key_highlights_method.dart';
import 'package:graduation_project/helpers/rate_method.dart';
import 'package:graduation_project/models/book_model.dart';

class BookInfoPage extends StatelessWidget {
  final BookModel book;
  static String id = 'BookInfoScreen';
  const BookInfoPage({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: ListView(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                width: MediaQuery.of(context).size.width,
                height: 256,
                decoration: BoxDecoration(
                  color: Colors.amber,
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(book.coverImage),
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16),
            child: Center(
              child: Text(
                textDirection: TextDirection.rtl,
                book.title,
                maxLines: 2,
                style: const TextStyle(
                  color: Color(0xff4F4F4F),
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  fontFamily: kFontFamily,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Text(
                          book.author.length > 30
                              ? '${book.author.substring(0, 30)}...'
                              : book.author,

                          overflow: TextOverflow.ellipsis,

                          textDirection: TextDirection.rtl,
                          style: const TextStyle(
                            color: Color(0xff4F4F4F),
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            fontFamily: kFontFamily,
                          ),
                        ),
                      ),
                      CircleAvatar(
                        radius: 35,
                        backgroundImage: NetworkImage(book.coverImage),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 24),
                          child: Text('${book.rate}'),
                        ),
                      ),
                      rateMethod(book.rate ?? 0.0),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // ignore: avoid_unnecessary_containers
          Container(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    textDirection: TextDirection.rtl,
                    'وصف الكتاب',
                    style: const TextStyle(
                      color: Color(0xff333333),
                      fontFamily: kFontFamily,
                      fontWeight: FontWeight.w600,
                      fontSize: 24,
                    ),
                  ),
                  Text(
                    textDirection: TextDirection.rtl,
                    book.summary,
                    style: const TextStyle(
                      color: Color(0xff4F4F4F),
                      fontFamily: kFontFamily,
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
