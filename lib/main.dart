import 'package:flutter/material.dart';
import 'package:graduation_project/pages/all_books_page.dart';

import 'package:graduation_project/pages/all_videos.dart';
import 'package:graduation_project/pages/chat_bot_screen.dart';
import 'package:graduation_project/pages/consultants_page.dart';
import 'package:graduation_project/services/notification_service.dart';
// ✅ إضافة جديدة

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // ✅ تهيئة خدمة الإشعارات التربوية
  await initializeNotificationService();

  runApp(const GraduationProject());
}

class GraduationProject extends StatelessWidget {
  const GraduationProject({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        AllBooksPage.id: (context) => const AllBooksPage(),
        ConsultantPage.id: (context) => const ConsultantPage(),
        ChatBotPage.id: (context) => const ChatBotPage(),
        AllVideosPage.id: (context) => const AllVideosPage(),
      },
      initialRoute: AllVideosPage.id,
    );
  }
}
