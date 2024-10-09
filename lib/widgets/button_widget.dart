import 'package:flutter/material.dart';

import '../utils/app_styles.dart';

class ButtonWidget extends StatefulWidget {

  final String buttonText;
  final VoidCallback? onPressed;
  final int? type;
  const ButtonWidget({super.key, required this.buttonText, this.onPressed, this.type});

  @override
  State<ButtonWidget> createState() => _ButtonWidgetState();
}

class _ButtonWidgetState extends State<ButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: widget.type == 1 ? AppTheme.cancelColor : AppTheme.secondaryColor,
        borderRadius: BorderRadius.circular(25),
        boxShadow: const [
          BoxShadow(
            //offset: Offset(0, 4),
              color: AppTheme.shadowColor, //edited
              spreadRadius: 4,
              blurRadius: 10  //edited
          )],

      ),
      child: TextButton(
        onPressed: widget.onPressed,
        child: Text(
          widget.buttonText,
        style: AppTheme.buttonTextStyle
      ),),
    );
  }
}
