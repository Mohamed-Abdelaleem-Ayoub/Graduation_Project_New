// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:workmanager/workmanager.dart';

// const simplePeriodicTask = "simplePeriodicTask";

// const List<String> educationalTips = [
//   'احرصي على الاستماع لطفلك دون مقاطعة، فهذا يعزز ثقته بنفسه.',
//   'خصصي وقتًا للعب مع طفلك يوميًا، فذلك يقوي علاقتكما.',
//   'عانقي طفلك كثيرًا، فالحب غير المشروط ينمي الأمان النفسي.',
//   'اجعلي القراءة عادة يومية، فالقراءة تطور خياله وقدرته على التعبير.',
//   'لا توبخي الطفل أمام الآخرين، فذلك يحرج مشاعره.',
//   'مدحي الجهد أكثر من النتيجة، لتغرس فيه المثابرة.',
//   'كوني قدوة في السلوك الذي ترغبين أن يتعلمه.',
//   'ضعي قواعد واضحة ومتسقة، فذلك يساعده على فهم التوقعات.',
//   'ابتعدي عن الصراخ، فالتواصل الهادئ أكثر فعالية.',
//   'شاركي طفلك الاهتمام بدراسته دون ضغط.',
// ];

// final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//     FlutterLocalNotificationsPlugin();

// void callbackDispatcher() {
//   Workmanager().executeTask((task, inputData) async {
//     const AndroidInitializationSettings androidSettings =
//         AndroidInitializationSettings('@mipmap/ic_launcher');

//     final InitializationSettings initializationSettings =
//         InitializationSettings(android: androidSettings);

//     await flutterLocalNotificationsPlugin.initialize(initializationSettings);

//     final prefs = await SharedPreferences.getInstance();
//     int currentTipIndex = prefs.getInt('tipIndex') ?? 0;

//     final String tip = educationalTips[currentTipIndex];

//     const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
//       'your_channel_id',
//       'your_channel_name',
//       channelDescription: 'your_channel_description',
//       importance: Importance.max,
//       priority: Priority.high,
//     );

//     const NotificationDetails platformDetails = NotificationDetails(
//       android: androidDetails,
//     );

//     await flutterLocalNotificationsPlugin.show(
//       0,
//       'نصيحة تربوية',
//       tip,
//       platformDetails,
//     );

//     currentTipIndex = (currentTipIndex + 1) % educationalTips.length;
//     await prefs.setInt('tipIndex', currentTipIndex);

//     return Future.value(true);
//   });
// }

// Future<void> initializeNotificationService() async {
//   await Workmanager().initialize(callbackDispatcher, isInDebugMode: false);

//   await Workmanager().registerPeriodicTask(
//     "1",
//     simplePeriodicTask,
//     frequency: const Duration(minutes: 15),
//   );
// }
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workmanager/workmanager.dart';

const String simplePeriodicTask = "simplePeriodicTask";
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

const List<String> educationalTips = [
  'نصيحة 1: الاستماع لطفلك يعزز ثقته بنفسه.',
  'نصيحة 2: احرصي على وقت نوم كافٍ لطفلك.',
  'نصيحة 3: شاركي طفلك اللعب لتفهمي عالمه.',
  'نصيحة 4: امدحي الجهد أكثر من النتيجة.',
  'نصيحة 5: القراءة اليومية تطور خيال الطفل.',
];

Future<void> initializeNotificationService() async {
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  const InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  await Workmanager().initialize(callbackDispatcher, isInDebugMode: false);

  await Workmanager().registerPeriodicTask(
    "1",
    simplePeriodicTask,
    frequency: const Duration(minutes: 15),
  );
}

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);

    final prefs = await SharedPreferences.getInstance();
    int currentTipIndex = prefs.getInt('tipIndex') ?? 0;
    final String tip = educationalTips[currentTipIndex];

    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
          'your_channel_id',
          'your_channel_name',
          channelDescription: 'your_channel_description',
          importance: Importance.max,
          priority: Priority.high,
        );

    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidDetails,
    );

    await flutterLocalNotificationsPlugin.show(
      0,
      'نصيحة تربوية',
      tip,
      notificationDetails,
    );

    currentTipIndex = (currentTipIndex + 1) % educationalTips.length;
    await prefs.setInt('tipIndex', currentTipIndex);

    return Future.value(true);
  });
}
