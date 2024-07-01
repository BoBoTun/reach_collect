import 'package:flutter/material.dart';
import 'package:reach_collect/utils/app_styles.dart';
import 'package:reach_collect/widgets/icon_button_widget.dart';
class CustomBarWidget extends StatefulWidget {
  const CustomBarWidget({super.key});


  @override
  State<CustomBarWidget> createState() => _CustomBarWidgetState();
}

class _CustomBarWidgetState extends State<CustomBarWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.12,
      color: AppTheme.secondaryColor,
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(width: 40,),
          Text("Prefilled",style: AppTheme.navigationTitleStyle,),
          //IconButtonWidget(AppTheme.importImg, "",onPressed: widget.onPressed,)
        ],
      ),
    );
  }
}
