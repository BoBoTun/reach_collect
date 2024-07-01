import 'package:flutter/material.dart';

import '../utils/app_styles.dart';

class HomeAppBarWidget extends StatefulWidget {
  const HomeAppBarWidget({super.key});

  @override
  State<HomeAppBarWidget> createState() => _HomeAppBarWidgetState();
}

class _HomeAppBarWidgetState extends State<HomeAppBarWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.12,
      color: AppTheme.secondaryColor,
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(width: 40,),
          Text("Reach Collect",style: AppTheme.navigationTitleStyle,),

        ],
      ),
    );
  }
}
