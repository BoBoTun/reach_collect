import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reach_collect/utils/app_styles.dart';

class IconButtonWidget extends StatelessWidget {
  final String buttonIcon;
  final String labelTitle;
  final VoidCallback? onPressed;
  const IconButtonWidget(this.buttonIcon,this.labelTitle,{Key? key,this.onPressed}): super (key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton.icon(onPressed: onPressed, icon: Image.asset(buttonIcon,width: 40,height: 40,),
        label:  Text(labelTitle,
          style: const TextStyle(
            color: AppTheme.whiteColor,
            //fontFamily: 'Roboto',
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red, // Background color
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22), // Corner radius
          ),
        ),
      )
    );
  }
}
