import 'package:chatbot_hotel/Common/appstyle.dart';
import 'package:chatbot_hotel/Common/reusable_text.dart';
import 'package:chatbot_hotel/chat_screen.dart';
import 'package:chatbot_hotel/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      height: 110.h,
      width: width,
      color: kOffWhite,
      child: Container(
        margin: EdgeInsets.only(top: 20.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                GestureDetector(
                onTap: (){
                  Get.to(()=> ChatScreen());
                },
                child: CircleAvatar(
                    radius: 22,
                    backgroundColor: kSecondary,
                    backgroundImage: AssetImage("assets/anime/chat.avif"),
                  ),
              ),
                Padding(
                  padding: EdgeInsets.only(bottom:6.h,left: 8.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ReusableText(text: "Tap to Chat", style: appStyle(13, kSecondary, FontWeight.w600)),
                      SizedBox(
                        width: width*0.65,
                        child: Text("Our Assitant for Booking",overflow: TextOverflow.ellipsis, style: appStyle(11, kGrayLight, FontWeight.normal))),
                    ],
                  ),
                ),
                 Text(getTimeOfDay(),style: const TextStyle(fontSize: 35),)
              ],
            ),
          ],
        ),
      ),
    );
  }
  String getTimeOfDay(){
    DateTime now = DateTime.now();
    int hour = now.hour;

    if(hour>=0 && hour<12){
      return '🏨';
    }else if(hour>=12 && hour<16){
      return '🏨';
    }else{
      return '🏨';
    }
  }
}