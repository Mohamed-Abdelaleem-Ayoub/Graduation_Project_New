import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workmanager/workmanager.dart';

const String simplePeriodicTask = "simplePeriodicTask";
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

const List<String> educationalTips = [
  ' الاستماع لطفلك يعزز ثقته بنفسه.',
  '  احرصي على وقت نوم كافٍ لطفلك.',
  '  شاركي طفلك اللعب لتفهمي عالمه.',
  '  امدحي الجهد أكثر من النتيجة'
      '  القراءة اليومية تطور خيال الطفل 📚✨',
  ' كل كلمة تقولينها لطفلك تُشكّل صورته عن نفسه. اختاري كلماتك بحب. 💬💖',
  ' الاحتضان اليومي يقوّي العلاقة ويُشعر الطفل بالأمان. 🤗💞',
  ' استمعي قبل أن تُعلّقي، فالأطفال يحتاجون لمن يفهمهم أولًا. 👂🧠',
  ' التربية الإيجابية لا تعني غياب الحدود، بل تعني احترام الطفل عند وضعها. 🚧❤️',
  ' كل لحظة غضب هي فرصة لتعليم طفلك كيف يتحكم بمشاعره. 🌈🧘‍♂️',
  ' قدوة الطفل الأولى... هي أنتِ. كوني ما تتمنين أن يكون عليه. 👩‍👧‍👦💫',
  ' لا بأس أن تخطئي... الأهم أن تعتذري وتعلمي طفلك قوة الاعتراف بالخطأ. 🙏✨',
  ' طفلك لا يحتاج أمًا مثالية، بل أمًا حنونة حاضرة بقلبها. 💖',
  ' عندما يستمع الطفل لصوتك بلُطف، يتعلم أن اللطف هو القوة. 🌿',
  ' ركّزي على السلوك، لا على الشخص. قولي "تصرفك خاطئ" بدلًا من "أنت سيء". 🚫➡️✅',
  ' لا تقارني طفلك بغيره، قارنيه بنفسه كيف كان وكيف أصبح. 📈🧒',
  ' اللعب مع طفلك هو استثمار في مشاعره، وليس مضيعة للوقت. 🧸⏰',
  ' رد الفعل الهادئ وقت الغضب، أقوى من أي عقاب. 🌊🔥',
  ' كل جملة:"أنا فخورة بك" تزرع ثقة تدوم عمرًا. 🌟🫶',
  ' اجعلي بيتك ملاذًا آمنًا، لا مكانًا للخوف واللوم. 🏡❤️',
  ' طفلك يتعلم مما تفعليه أكثر مما تقوليه. 👀👂',
  ' نبرة صوتك تصبح صوت ضمير طفلك لاحقًا. اجعليها دافئة. 🎙️💬',
  ' الروتين اليومي يجعل الطفل يشعر بالأمان والانضباط. 📅⏳',
  ' الصراخ لا يعلّم، بل يخيف. والتربية لا تحتاج ترهيبًا. 🚫📢',
  ' احتضني طفلك بدون سبب، فالحب لا يحتاج مناسبة. 💞',
  ' التربية الإيجابية هي تربية بالقرب، لا بالقسوة.',
  ' سلوك الطفل رسالة... استمعي لما خلف التصرف. 🧠💭',
  ' وقت الخطأ هو وقت التعليم، لا وقت الإهانة. ⏱️📚',
  ' طفلك لا يعاندك... إنه يختبر حدود العالم من خلالك. 🌍👶',
  ' كل مرة تتفاهمين فيها بدلًا من العقاب، تبنين جسرًا بدل جدار. 🧱➡️🌉',
  ' مشاعر الطفل حقيقية، حتى وإن كانت بسيطة في نظرك. 💡❤️',
  ' في كل مرة تتحكمين في أعصابك، تعلّمين طفلك التحكم في نفسه. 😌🧠',
  ' العناق يُصلح ما لا تصلحه الكلمات. 🤗🩷',
  ' أحيانًا كل ما يحتاجه طفلك هو أن تنزلي لمستواه وتسمعيه بعيونك. 👀💬',
  ' لا تُكثري من "لا"... اجعليها عند الضرورة، ليشعر بأثرها. 🙅‍♀️📉',
  ' الثقة تُزرع بكلمة، وتُهدم بتجاهل. 🌱🚧',
  ' المقارنة تسرق طفلك من نفسه. دعيه يتفتح على طريقته. 🌸',
  ' طفلك لا يتذكر ما قلتِ، بل كيف جعلتِه يشعر. 💭❤️',
  ' الطفل كثير الحركة ليس "مشاغبًا"، بل فضولي يكتشف الحياة. 🏃‍♂️🔍',
  ' امنحي طفلك فرصة للاختيار، ليتعلم تحمّل المسؤولية. ✅❌',
  ' الروتين والنظام لا يُقيّدان الطفل، بل يمنحانه أمانًا. 🗓️🔐',
  ' كوني الأم التي تتمنى طفلتها أن تصبح مثلها. 👩‍👧✨',
  ' الاعتذار من طفلك لا يُنقص من قيمتك، بل يُعلمه الاحترام الحقيقي. 🙇‍♀️❤️',
  ' كلما زاد صبرك، زادت مساحة التفاهم بينكما. ⏳🧩',
  ' الأطفال لا "يختبرون صبرك"، بل يبحثون عن قربك. 🫂',
  ' كوني مرآة طفلك العاكسة للأمان، لا للتهديد. 🪞🛡️',
  ' القصص قبل النوم تصنع ذكريات تبقى في القلب للأبد. 📚🌙',
  ' سلوك الطفل في الخارج يعكس ما يشعر به في الداخل. 🌍🧠',
  ' لا تتعاملي مع الطفل وكأنه "صغير"، بل كشخص يستحق الاحترام. 🤝🧒',
  ' الوقت الذي تقضينه مع طفلك أهم من عدد الدروس التي تعلّمينه إياها. ⏰❤️📚',
  ' تقبلي طفلك في كل حالاته... ليس فقط حين يكون مطيعًا. 🧒💕',
  ' طفلك يتعلم كيف يُحب نفسه من طريقة حبك له. 🪞❤️',
  ' نبرة الحنان تغيّر نتائج النقاش أكثر من أي تهديد. 🎵🤍',
  ' لا تسألي الطفل "ليش سويت كذا؟"، بل اسأليه "كيف كنت تحس وقتها؟" 🤔💭',
  ' الطفل ما يحتاج كل شيء... هو يحتاجك أنت. 🫶',
  ' لا تعالجي الخطأ بالغضب، بل بالهدوء والفهم. 🌤️🚸',
  ' في كل مرة تصغين له بصدق، تقوين جسره نحوك. 🌉👂',
  ' أظهري حبك بالقول والفعل، فالحب الغير معلن قد لا يُفهم. 💬💞',
  ' عندما تُظهرين الضعف أحيانًا، تُعلّمين طفلك الشجاعة الحقيقية. 🫂💡',
  ' طفلك لا يحتاجك "مثالية"، يحتاجك "متواجدة بحب". 🕊️',
  ' تذكّري: خلف كل سلوك مزعج، احتياج غير ملبى. 🔍💔',
  ' نعم، التربية مرهقة... لكن كل لحظة فيها تبني إنسانًا عظيمًا. 🛠️🌟',
  ' الطفولة مرحلة "بناء"، لا "ضبط". لا تتعجلي النتيجة. 🏗️🧱',
  ' كل مرة تمدحين أخلاق طفلك، أنتِ تبنينها فيه أكثر. 👏🌼',
  ' الأمومة رحلة تعلّم متبادل، لا دور تعليمي من طرف واحد. 🧭👩‍👧‍👦',
  ' لا تهتمي بكمال البيت أكثر من دفء القلب الذي يسكنه. 🏠❤️',
  ' كلما شعرتِ بالإرهاق، تذكري أن وجودك وحده هدية لطفلك. 🎁🫶',
  ' إذا أردتِ أن ينصت طفلك لك، ابدئي أنت بالإنصات له. 🔁👂',
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
