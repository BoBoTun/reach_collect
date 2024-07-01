import 'package:flutter/material.dart';
import 'package:reach_collect/utils/app_styles.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.buttonHeight,
    required this.label, required this.iconName, required this.width, this.onPressed,
  });


  final double buttonHeight;
  final String label;
  final String iconName;
  final double width;
final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: buttonHeight,
        width: width,
        decoration: BoxDecoration(
            color: AppTheme.secondaryColor,
            borderRadius: BorderRadius.circular(5)),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                iconName,
                width: 28,
                height: 28,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                label,
                style: const TextStyle(color: Colors.white),
              )
            ],
          ),
        ),
      ),
    );
  }
}
