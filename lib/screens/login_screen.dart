import 'package:flutter/material.dart';
import 'package:reach_collect/screens/prefilled_screen.dart';
import 'package:reach_collect/utils/app_styles.dart';
import 'package:reach_collect/widgets/button_widget.dart';
import 'package:reach_collect/widgets/textfield_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppTheme.primaryColor,
        body: Row(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width / 2,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(AppTheme.loginImg),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width / 2,
              color: Colors.transparent,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "REACH Collect",
                    style: AppTheme.largeStyle,
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                  Container(
                    height: 50,
                    width: 300,
                    color: Colors.transparent,
                    child: TextFieldWidget(
                        maxLength: 300,
                        maxLines: 1,
                        hintText: "User Name",
                        obscureText: false,
                        controller: userNameController),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  SizedBox(
                    height: 50,
                    width: 300,
                    child: TextFieldWidget(
                        maxLength: 300,
                        maxLines: 1,
                        hintText: "Password",
                        obscureText: true,
                        controller: passwordController),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  SizedBox(
                    height: 50,
                    width: 300,
                    child: ButtonWidget(
                        buttonText: 'Sign In',
                        onPressed: () {
                          if (userNameController.text != 'user1' ||
                              passwordController.text != '12345') {
                                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Center(child: Text('username and passwords does not match!'),)));
                          } else {
                            Navigator.of(context)
                                .pushReplacement(MaterialPageRoute(
                              builder: (_) => const PreFilledScreen(),
                            ));
                          }
                        }),
                  )
                ],
              ),
            ),
          ],
        ));
  }
}
