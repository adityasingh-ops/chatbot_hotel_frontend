import 'package:chatbot_hotel/Common/appstyle.dart';
import 'package:chatbot_hotel/constants/constants.dart';
import 'package:flutter/material.dart';

class PhoneTextField extends StatelessWidget {
  const PhoneTextField({super.key, this.onEditingComplete, this.keyboardType, this.initialValue,required this.controller, required this.hintText, required this.prefixIcon});
  final void Function()? onEditingComplete;
  final TextInputType? keyboardType;
  final String? initialValue;
  final TextEditingController? controller;
  final String hintText;
  final Widget prefixIcon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: kDark,
      initialValue: initialValue,
      textInputAction: TextInputAction.next,
      keyboardType: keyboardType ?? TextInputType.emailAddress,
      onEditingComplete: onEditingComplete,
      controller: controller,
      validator: (value){
        if(value!.isEmpty){
          return "It cannot be empty";
        }
        return null;
      },
      style: appStyle(12, kGray, FontWeight.normal),
      decoration: InputDecoration(
        hintText:hintText,
        prefixIcon: prefixIcon,
        isDense: true,
        contentPadding: EdgeInsets.all(6),
        hintStyle: appStyle(12, kGray, FontWeight.normal),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: kRed,width: 0.5),
          borderRadius: BorderRadius.circular(12),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: kRed,width: 0.5),
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: kPrimary,width: 0.5),
          borderRadius: BorderRadius.circular(12),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: kGray,width: 0.5),
          borderRadius: BorderRadius.circular(12),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: kPrimary,width: 0.5),
          borderRadius: BorderRadius.circular(12),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: kPrimary,width: 0.5),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}