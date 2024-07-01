import 'package:flutter/material.dart';
import 'package:reach_collect/utils/app_styles.dart';

class TextFieldWidget extends StatefulWidget {
  final int maxLength;
  final int? maxLines;
  final String hintText;
  final bool obscureText;
  final TextEditingController controller;

  const TextFieldWidget({super.key, required this.maxLength, this.maxLines, required this.hintText, required this.controller, required this.obscureText});

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  final _focusNode = FocusNode();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _focusNode.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width * 0.82,
        height: MediaQuery.of(context).size.height * 0.28,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: const [
            BoxShadow(
            //offset: Offset(0, 4),
            color: AppTheme.shadowColor, //edited
        spreadRadius: 4,
        blurRadius: 10  //edited
    )],

    ),
      child: TextField(
        focusNode: _focusNode,
        onEditingComplete: () => FocusScope.of(context).nextFocus(),
        controller: widget.controller,
        maxLines: widget.maxLines,
        keyboardType: TextInputType.number,
        //maxLength: widget.maxLength,
        obscureText: widget.obscureText,
        cursorColor: AppTheme.secondaryColor,
        style: AppTheme.inputStyle,
        decoration: InputDecoration(
          hintStyle: AppTheme.hintStyle,
          hintText: widget.hintText,
            border: InputBorder.none,
        ),

      ),
    );
  }
}
