import 'package:flutter/material.dart';
import 'package:reach_collect/screens/login_screen.dart';
import 'package:reach_collect/utils/app_styles.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
    Future.delayed(const Duration(seconds: 2),(){
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const LoginScreen(),)
      );
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppTheme.primaryColor,
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.ac_unit_sharp,
              color: AppTheme.secondaryColor,
              size: 200,
            ),
            Text("REACH Collect",
            style: AppTheme.splashStyle,)
          ],
        ),
      ),
    );
  }
}
