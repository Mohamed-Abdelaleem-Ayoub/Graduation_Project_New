import 'package:flutter/material.dart';
import 'package:graduation_project/models/vodeo_model.dart';
import 'package:graduation_project/services/get_all_videos_sercie.dart';
import 'package:graduation_project/widgets/today_date.dart';
import 'package:graduation_project/widgets/video_card.dart';
import 'package:graduation_project/widgets/videos_category_list.dart';
import 'package:intl/intl.dart';

// code with search
class AllVideosPage extends StatefulWidget {
  static String id = 'AllViedosPage';
  const AllVideosPage({super.key});

  @override
  State<AllVideosPage> createState() => _AllVideosPageState();
}

class _AllVideosPageState extends State<AllVideosPage> {
  String todayDate = DateFormat('MMM,dd,yyyy').format(DateTime.now());
  late Future<List<YoutubeVideoModel>> _videosFuture;

  TextEditingController searchController = TextEditingController();
  List<YoutubeVideoModel> allVideos = [];
  List<YoutubeVideoModel> filteredVideos = [];

  @override
  void initState() {
    super.initState();
    _videosFuture = VideoService.fetchVideos().then((videos) {
      allVideos = videos;
      filteredVideos = videos;
      return videos;
    });
  }

  void filterSearchResults(String query) {
    if (query.isEmpty) {
      setState(() {
        filteredVideos = allVideos;
      });
      return;
    }

    setState(() {
      filteredVideos =
          allVideos.where((video) {
            return video.title.toLowerCase().contains(query.toLowerCase());
          }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
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
      body: FutureBuilder<List<YoutubeVideoModel>>(
        future: _videosFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('حدث خطأ: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('لا توجد فيديوهات حالياً'));
          }

          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(child: TodayDate(todayDate: todayDate)),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                      hintText: 'ابحث عن فيديو...',
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
              const SliverToBoxAdapter(
                child: SizedBox(height: 50, child: CategoryList()),
              ),
              SliverToBoxAdapter(
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: filteredVideos.length,
                  itemBuilder: (context, index) {
                    final video = filteredVideos[index];
                    return VideoCard(videoModel: video);
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

//Code without search

// import 'package:flutter/material.dart';
// import 'package:graduation_project/models/vodeo_model.dart';

// import 'package:graduation_project/services/get_all_videos_sercie.dart';
// import 'package:graduation_project/widgets/search_bar.dart';
// import 'package:graduation_project/widgets/today_date.dart';
// import 'package:graduation_project/widgets/video_card.dart';
// import 'package:graduation_project/widgets/videos_category_list.dart';
// import 'package:intl/intl.dart';

// class AllVideosPage extends StatefulWidget {
//   static String id = 'AllViedosPage';
//   const AllVideosPage({super.key});

//   @override
//   State<AllVideosPage> createState() => _AllVideosPageState();
// }

// class _AllVideosPageState extends State<AllVideosPage> {
//   String todayDate = DateFormat('MMM,dd,yyyy').format(DateTime.now());
//   late Future<List<YoutubeVideoModel>> _videosFuture;

//   @override
//   void initState() {
//     super.initState();
//     _videosFuture = VideoService.fetchVideos();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         // backgroundColor: kBackgroundColor,
//         elevation: 0,

//         title: const Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               'Hi , ',
//               style: TextStyle(
//                 color: Color(0xff333333),
//                 fontSize: 16,
//                 fontWeight: FontWeight.w700,
//               ),
//             ),

//             Text(
//               'Jenny',
//               style: TextStyle(
//                 color: Color(0xffFF8EA2),
//                 fontSize: 16,
//                 fontWeight: FontWeight.w700,
//               ),
//             ),
//             Padding(
//               padding: EdgeInsets.only(left: 8.0),
//               child: Icon(
//                 Icons.waving_hand_rounded,
//                 color: Colors.amber,
//                 size: 15,
//               ),
//             ),
//           ],
//         ),
//         actions: const [
//           Icon(Icons.settings),
//           Padding(
//             padding: EdgeInsets.only(left: 8),
//             child: Icon(Icons.notifications_none),
//           ),
//         ],
//       ),

//       body: FutureBuilder<List<YoutubeVideoModel>>(
//         future: _videosFuture,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('حدث خطأ: ${snapshot.error}'));
//           } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//             return const Center(child: Text('لا توجد فيديوهات حالياً'));
//           }
//           final videos = snapshot.data!;

//           return CustomScrollView(
//             slivers: [
//               SliverToBoxAdapter(child: TodayDate(todayDate: todayDate)),
//               const SliverToBoxAdapter(child: SearchBarWidget()),
//               const SliverToBoxAdapter(
//                 child: SizedBox(height: 50, child: CategoryList()),
//               ),
//               SliverToBoxAdapter(
//                 child: ListView.builder(
//                   shrinkWrap: true,
//                   physics: const NeverScrollableScrollPhysics(),
//                   itemCount: videos.length,
//                   itemBuilder: (context, index) {
//                     final video = videos[index];
//                     return VideoCard(videoModel: video);
//                   },
//                 ),
//               ),
//             ],
//           );

//           // final videos = snapshot.data!;
//           // return ListView.builder(
//           //   itemCount: videos.length,
//           //   itemBuilder: (context, index) {
//           //     final video = videos[index];
//           //     return Card(
//           //       margin: const EdgeInsets.all(8),
//           //       child: ListTile(
//           //         title: Text(video.title),
//           //         trailing: const Icon(Icons.play_circle_fill),
//           //         onTap: () {
//           //           Navigator.push(
//           //             context,
//           //             MaterialPageRoute(
//           //               builder:
//           //                   (_) => VideoPlayerPage(youtubeUrl: video.url),
//           //             ),
//           //           );
//           //         },
//           //       ),
//           //     );
//           //   },
//           // );
//         },
//       ),
//     );
//   }
// }
