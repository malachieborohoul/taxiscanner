import 'package:flutter/material.dart';
import 'package:scanner/constants/colors.dart';
import 'package:scanner/constants/padding.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    Key? key,
    // required this.prefixIcon,
    required this.labelText,
    required this.controller,
    this.readOnlyField = false,
    this.isPassword = false,
    this.iconHeight = 17.0,
    this.maxLine = 1,
    this.height = 50.0,
    this.keyboardType,
    this.iconColor,
  }) : super(key: key);
  // final String prefixIcon;
  final double iconHeight;
  final String labelText;
  final TextEditingController? controller;
  final bool isPassword;
  final bool readOnlyField;
  final int maxLine;
  final double height;
  final TextInputType? keyboardType;
  final Color? iconColor;

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      width: double.infinity,
      // decoration: BoxDecoration(
      //   border: Border(
      //     bottom: BorderSide(color: secondary.withOpacity(0.25), width: 0.5),
      //   ),
      // ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: miniSpacer),
          Flexible(
              child: TextFormField(
            keyboardType: widget.keyboardType,
            readOnly: widget.readOnlyField,
            obscureText: widget.isPassword,
            controller: widget.controller,
            maxLines: widget.maxLine,
            style: TextStyle(
              fontSize: 15.0,
              color: primary,
              fontWeight: FontWeight.w500,
            ),
            cursorColor: primary,
            decoration: InputDecoration(
              // prefixIcon: Container(
              //   height: 50.0,
              //   width: 50.0,
              //   // color: grey,
              //   alignment: Alignment.center,
              //   child: Container(
              //       child: SvgPicture.asset(
              //     assetImg + widget.prefixIcon,
              //     height: widget.iconHeight,
              //     color: widget.iconColor,
              //   )),
              // ),
              // border: InputBorder.none,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(color: primary),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(color: primary),
              ),
              //  errorBorder: OutlineInputBorder(
              //   borderRadius: BorderRadius.circular(20),
              //   borderSide: BorderSide(color: Colors.red),
              // ),
              
              labelText: widget.labelText,
              labelStyle: TextStyle(
                color: primary.withOpacity(0.5),
                fontSize: 15.0,
                height: 1,
              ),
            ),
            validator: (val) {
              if (val == null || val.isEmpty) {
                return "Entrez votre ${widget.labelText}";
              }
              return null;
            },
          )),
        ],
      ),
    );
  }
}
