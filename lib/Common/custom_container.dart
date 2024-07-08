import 'package:chatbot_hotel/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class CustomContainer extends StatelessWidget {
   CustomContainer({super.key, required this.containerContent,this.color,this.height,this.borderRadius,this.oppositeBorderRadius});
  Widget containerContent;
  Color ? color;
  double ? height;
  BorderRadius ? borderRadius;
  BorderRadius? oppositeBorderRadius;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height??MediaQuery.of(context).size.height * 0.80,
      width:MediaQuery.of(context).size.width,
      child: ClipRRect(
        borderRadius: borderRadius??BorderRadius.only(
          bottomLeft: Radius.circular(30.r),
          bottomRight: Radius.circular(30.r),
        ),
        child: Container(
          width: width,
          color: color??kOffWhite,
          child: SingleChildScrollView(
            child:containerContent,
          ),
        ),
      ),
    );
  }
}