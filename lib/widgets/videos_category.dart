import 'package:flutter/material.dart';
import 'package:graduation_project/pages/all_speaker_videos.dart';

class VideosCategory extends StatelessWidget {
  const VideosCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return const AllSpeakerVideosPage();
            },
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 7),
        child: Container(
          padding: const EdgeInsets.all(8),
          height: 30,
          decoration: BoxDecoration(
            color: const Color(0xffA7E8BD),
            borderRadius: BorderRadius.circular(10),
          ),

          child: const Center(
            child: Text(
              'Solafa Seleim',
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 13),
            ),
          ),
        ),
      ),
    );
  }
}
