import 'package:flutter/material.dart';
import 'package:graduation_project/constans.dart';

class AllSpeakerVideosPage extends StatelessWidget {
  static String id = 'AllSpeakersVideoPage';
  const AllSpeakerVideosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'All Speaker Videos',
          style: TextStyle(
            fontFamily: kFontFamily,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          const SliverToBoxAdapter(child: SizedBox(height: 50)),
          SliverToBoxAdapter(
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 10,
              itemBuilder: (context, indx) {
                return Text(''); // مؤقتا لحد ما نجيلها
                // return  VideoCard();
              },
            ),
          ),
        ],
      ),
    );
  }
}
