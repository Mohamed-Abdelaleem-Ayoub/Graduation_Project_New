// import 'package:flutter/material.dart';
// import 'package:google_generative_ai/google_generative_ai.dart';
// import 'package:graduation_project/constans.dart';
// import 'package:intl/intl.dart';

// class ChatBotPage extends StatefulWidget {
//   static String id = 'ChatbotPage';
//   const ChatBotPage({super.key});

//   @override
//   State<ChatBotPage> createState() => _ChatBotPageState();
// }

// class _ChatBotPageState extends State<ChatBotPage> {
//   final TextEditingController _userMessage = TextEditingController();

//   static const apiKey = "AIzaSyADDKLJYKfVGwRCEZ-tOKytrBKRcxPmoko";
//   final model = GenerativeModel(model: 'gemini-1.5-pro', apiKey: apiKey);

//   final List<Message> _messages = [];

//   Future<void> sendMessage() async {
//     final message = _userMessage.text;
//     _userMessage.clear();

//     setState(() {
//       _messages.add(
//         Message(isUser: true, message: message, date: DateTime.now()),
//       );
//     });

//     try {
//       final content = [Content.text(message)];
//       final response = await model.generateContent(content);
//       setState(() {
//         _messages.add(
//           Message(
//             isUser: false,
//             message: response.text ?? "No response",
//             date: DateTime.now(),
//           ),
//         );
//       });
//     } catch (e) {
//       setState(() {
//         _messages.add(
//           Message(
//             isUser: false,
//             message: "Error: ${e.toString()}",
//             date: DateTime.now(),
//           ),
//         );
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         backgroundColor: kBackgroundColor,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back_ios, color: Colors.pink),
//           onPressed: () => Navigator.of(context).pop(),
//         ),
//         title: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Container(
//               padding: const EdgeInsets.only(right: 8),
//               child: CircleAvatar(
//                 radius: 16,
//                 backgroundColor: kBackgroundColor,
//                 backgroundImage: AssetImage(
//                   'assets/images/2-removebg-preview (1) 1.png',
//                 ),
//               ),
//             ),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const Text(
//                   'MummyGuide',
//                   style: TextStyle(
//                     color: Colors.pink,
//                     fontWeight: FontWeight.bold,
//                     fontSize: 16,
//                   ),
//                 ),
//                 Row(
//                   children: const [
//                     Icon(Icons.circle, size: 8, color: Colors.green),
//                     SizedBox(width: 4),
//                     Text(
//                       'Online',
//                       style: TextStyle(color: Colors.green, fontSize: 12),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.end,
//         children: [
//           Expanded(
//             child: ListView.builder(
//               itemCount: _messages.length,
//               itemBuilder: (context, index) {
//                 final message = _messages[index];
//                 return Messages(
//                   isUser: message.isUser,
//                   message: message.message,
//                   date: DateFormat('HH:mm').format(message.date),
//                 );
//               },
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 15),
//             child: Row(
//               children: [
//                 Expanded(
//                   flex: 15,
//                   child: TextFormField(
//                     controller: _userMessage,
//                     decoration: InputDecoration(
//                       border: OutlineInputBorder(
//                         borderSide: const BorderSide(color: kBackgroundColor),
//                         borderRadius: BorderRadius.circular(50),
//                       ),
//                       label: const Text("Ask Gemini..."),
//                     ),
//                   ),
//                 ),
//                 const Spacer(),
//                 IconButton(
//                   padding: const EdgeInsets.all(15),
//                   iconSize: 30,
//                   style: ButtonStyle(
//                     backgroundColor: WidgetStateProperty.all(Color(0xffFF8EA2)),
//                     foregroundColor: WidgetStateProperty.all(Colors.white),
//                     shape: WidgetStateProperty.all(const CircleBorder()),
//                   ),
//                   onPressed: () {
//                     sendMessage();
//                   },
//                   icon: const Icon(Icons.send),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class Messages extends StatelessWidget {
//   final bool isUser;
//   final String message;
//   final String date;
//   const Messages({
//     super.key,
//     required this.isUser,
//     required this.message,
//     required this.date,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.all(15),
//       margin: const EdgeInsets.symmetric(
//         vertical: 15,
//       ).copyWith(left: isUser ? 100 : 10, right: isUser ? 10 : 100),
//       decoration: BoxDecoration(
//         color: isUser ? Color(0xffFFC1CC) : Colors.grey.shade200,
//         borderRadius: BorderRadius.only(
//           topLeft: const Radius.circular(30),
//           bottomLeft: isUser ? const Radius.circular(30) : Radius.zero,
//           topRight: const Radius.circular(30),
//           bottomRight: isUser ? Radius.zero : const Radius.circular(30),
//         ),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             message,
//             style: TextStyle(color: isUser ? Colors.white : Colors.black),
//           ),
//           Text(
//             date,
//             style: TextStyle(color: isUser ? Colors.white : Colors.black),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class Message {
//   final bool isUser;
//   final String message;
//   final DateTime date;

//   Message({required this.isUser, required this.message, required this.date});
// }
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:graduation_project/constans.dart';
import 'package:intl/intl.dart';

class ChatBotPage extends StatefulWidget {
  static String id = 'ChatbotPage';
  const ChatBotPage({super.key});

  @override
  State<ChatBotPage> createState() => _ChatBotPageState();
}

class _ChatBotPageState extends State<ChatBotPage> {
  final TextEditingController _userMessage = TextEditingController();
  final List<Message> _messages = [];

  static const String apiKey =
      "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";
  static const String apiUrl = "https://openrouter.ai/api/v1/chat/completions";

  Future<void> sendMessage() async {
    final message = _userMessage.text;
    _userMessage.clear();

    setState(() {
      _messages.add(
        Message(isUser: true, message: message, date: DateTime.now()),
      );
    });

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $apiKey',
          'Content-Type': 'application/json',
        },
        body: json.encode({
          "model": "mistralai/mistral-7b-instruct",
          "messages": [
            {"role": "user", "content": message},
          ],
        }),
      );

      final data = json.decode(response.body);

      if (response.statusCode == 200 && data["choices"] != null) {
        final reply = data["choices"][0]["message"]["content"] ?? "No response";
        setState(() {
          _messages.add(
            Message(isUser: false, message: reply, date: DateTime.now()),
          );
        });
      } else {
        throw Exception(data["error"]?['message'] ?? "Unknown error");
      }
    } catch (e) {
      setState(() {
        _messages.add(
          Message(
            isUser: false,
            message: "Error: ${e.toString()}",
            date: DateTime.now(),
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: kBackgroundColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.pink),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.only(right: 8),
              child: CircleAvatar(
                radius: 16,
                backgroundColor: kBackgroundColor,
                backgroundImage: AssetImage(
                  'assets/images/2-removebg-preview (1) 1.png',
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'MummyGuide',
                  style: TextStyle(
                    color: Colors.pink,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Row(
                  children: const [
                    Icon(Icons.circle, size: 8, color: Colors.green),
                    SizedBox(width: 4),
                    Text(
                      'Online',
                      style: TextStyle(color: Colors.green, fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return Messages(
                  isUser: message.isUser,
                  message: message.message,
                  date: DateFormat('HH:mm').format(message.date),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 15),
            child: Row(
              children: [
                Expanded(
                  flex: 15,
                  child: TextFormField(
                    controller: _userMessage,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(color: kBackgroundColor),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      label: const Text("Ask Gemini..."),
                    ),
                  ),
                ),
                const Spacer(),
                IconButton(
                  padding: const EdgeInsets.all(15),
                  iconSize: 30,
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(Color(0xffFF8EA2)),
                    foregroundColor: WidgetStateProperty.all(Colors.white),
                    shape: WidgetStateProperty.all(const CircleBorder()),
                  ),
                  onPressed: () {
                    sendMessage();
                  },
                  icon: const Icon(Icons.send),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Messages extends StatelessWidget {
  final bool isUser;
  final String message;
  final String date;
  const Messages({
    super.key,
    required this.isUser,
    required this.message,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.symmetric(
        vertical: 15,
      ).copyWith(left: isUser ? 100 : 10, right: isUser ? 10 : 100),
      decoration: BoxDecoration(
        color: isUser ? Color(0xffFFC1CC) : Colors.grey.shade200,
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(30),
          bottomLeft: isUser ? const Radius.circular(30) : Radius.zero,
          topRight: const Radius.circular(30),
          bottomRight: isUser ? Radius.zero : const Radius.circular(30),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            message,
            style: TextStyle(color: isUser ? Colors.white : Colors.black),
          ),
          Text(
            date,
            style: TextStyle(color: isUser ? Colors.white : Colors.black),
          ),
        ],
      ),
    );
  }
}

class Message {
  final bool isUser;
  final String message;
  final DateTime date;

  Message({required this.isUser, required this.message, required this.date});
}
