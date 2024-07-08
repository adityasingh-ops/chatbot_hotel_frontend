import 'package:chatbot_hotel/Common/appstyle.dart';
import 'package:chatbot_hotel/Common/reusable_text.dart';
import 'package:chatbot_hotel/Login/login_page.dart';
import 'package:chatbot_hotel/Model/login_response.dart';
import 'package:chatbot_hotel/constants/constants.dart';
import 'package:chatbot_hotel/controller/otpcontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';


class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
   void _logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('isRegistered');
    Get.to(() => LoginPage());
  }
  final controller = Get.put(OtpController());
  final TextEditingController _controller = TextEditingController();
  List<Map<String, String>> messages = [];

   void sendMessage(String message) async {
  final box = GetStorage();
    String? token = box.read('token');
    LoginresponseModel? user;

    if (token != null) {
      user = controller.getuserinfo();
    }
  // Add user message immediately to display
  setState(() {
    messages.add({'user': message, 'bot': '...'}); // Show three dots initially
  });

  try {
    final response = await http.post(
      Uri.parse('http://10.0.2.2:3453/chat'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'userId': "aditya sing23", 'message': message}),
    );

    final data = jsonDecode(response.body);

    // Update the state with bot's response
    setState(() {
      messages.last['bot'] = data['response']; // Update the last message with bot's response
    });
  } catch (e) {
    print('Error sending message: $e');
    setState(() {
      messages.last['bot'] = 'Error: Failed to fetch response'; // Handle error case
    });
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            Center(
              child: ReusableText(
                text: 'Book a Hotel Room',
                style: appStyle(20, kGray, FontWeight.bold),
              ),
            ),
            GestureDetector(
              onTap: () {
                _logout();
              },
              child: Icon(Icons.logout_outlined, color: kDark,)),
          ],
        ),
        backgroundColor: kOffWhite,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            backgroundColor: kDark,
                            child: Icon(Icons.person, color: kOffWhite),
                          ),
                          SizedBox(width: 8),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: kOffWhite,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                messages[index]['user']!,
                                style: appStyle(16, kDark, FontWeight.w500),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Container(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.only(left: 50),
                                padding: EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [Colors.black, Colors.indigo],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                  ),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(30),
                                    bottomRight: Radius.circular(30),
                                  ),
                                ),
                                child: messages[index]['bot'] == '...'
                                    ? Row(
                                        children: [
                                          Text(
                                            'Typing',
                                            style: appStyle(
                                                16, kDark, FontWeight.bold),
                                          ),
                                          SizedBox(width: 8),
                                          SizedBox(
                                            width: 20,
                                            height: 20,
                                            child: CircularProgressIndicator(
                                              strokeWidth: 2,
                                              valueColor:
                                                  AlwaysStoppedAnimation<Color>(
                                                      kDark),
                                            ),
                                          ),
                                        ],
                                      )
                                    : Text(
                                        messages[index]['bot']!,
                                        style: appStyle(
                                            14, kWhite, FontWeight.normal),
                                      ),
                              ),
                            ),
                             SizedBox(width: 8),
                            CircleAvatar(
                              radius: 22,
                              backgroundColor: kSecondary,
                              backgroundImage:
                                  AssetImage("assets/anime/chat.avif"),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.black, Colors.indigo],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
              boxShadow: [
                BoxShadow(
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: Offset(0, -1),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Type a message',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.grey[200],
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                Container(
                  decoration: BoxDecoration(
                    color: kDark,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: Icon(Icons.send, color: kOffWhite),
                    onPressed: () {
                      if (_controller.text.isNotEmpty) {
                        sendMessage(_controller.text);
                        _controller.clear();
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
