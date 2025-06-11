import 'package:flutter/material.dart';
import 'package:graduation_project/models/vodeo_model.dart';
import 'package:graduation_project/services/get_all_videos_sercie.dart';
import 'package:graduation_project/services/video_search.dart';

import 'package:graduation_project/widgets/today_date.dart';
import 'package:graduation_project/widgets/video_card.dart';

import 'package:intl/intl.dart';

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

  bool isSearching = false;
  bool isLoadingSearch = false;
  String? searchError;

  @override
  void initState() {
    super.initState();
    _videosFuture = VideoService.fetchVideos().then((videos) {
      allVideos = videos;
      filteredVideos = videos;
      return videos;
    });
  }

  Future<void> performSmartSearch(String query) async {
    setState(() {
      isSearching = true;
      isLoadingSearch = true;
      searchError = null;
    });

    try {
      final searchResults = await SearchService.searchVideos(query);

      // نربط النتائج بالـ YoutubeVideoModel الموجود (لو العنوان مطابق)
      final matchedVideos =
          allVideos.where((video) {
            return searchResults.any(
              (result) =>
                  result["title"]!.toLowerCase().trim() ==
                  video.title.toLowerCase().trim(),
            );
          }).toList();

      setState(() {
        filteredVideos = matchedVideos;
      });
    } catch (e) {
      setState(() {
        searchError = e.toString();
      });
    } finally {
      setState(() {
        isLoadingSearch = false;
      });
    }
  }

  void onSearchChanged(String query) {
    if (query.trim().isEmpty) {
      setState(() {
        isSearching = false;
        filteredVideos = allVideos;
        searchError = null;
      });
      return;
    }

    performSmartSearch(query);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "أهلاً بك في عالم التربية 👶🎓",
          style: TextStyle(
            color: Color(0xff333333),
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Color(0xffFF8EA2)),
            tooltip: 'إعادة تحميل',
            onPressed: () {
              searchController.clear();
              setState(() {
                isSearching = false;
                filteredVideos = allVideos;
              });
            },
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
          }

          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(child: TodayDate(todayDate: todayDate)),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    controller: searchController,
                    onChanged: onSearchChanged,
                    decoration: InputDecoration(
                      hintText: '🔍 ابحثي عن مشكلة بتواجهك مع طفلك',

                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          searchController.clear();
                          onSearchChanged('');
                        },
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ),

              if (isLoadingSearch)
                const SliverToBoxAdapter(
                  child: Center(child: CircularProgressIndicator()),
                ),
              if (searchError != null)
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      searchError!,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
                ),
              SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  final video = filteredVideos[index];
                  return VideoCard(videoModel: video);
                }, childCount: filteredVideos.length),
              ),
            ],
          );
        },
      ),
    );
  }
}
