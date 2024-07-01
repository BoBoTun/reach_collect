import 'package:flutter/material.dart';
import 'package:reach_collect/utils/app_styles.dart';

class SexRadioButton extends StatefulWidget {
  const SexRadioButton(
  {super.key, required this.radioValue, required this.activeValue});

  final Function(String) radioValue;
  final String activeValue;
  @override
  State<SexRadioButton> createState() => _SexRadioButtonState();
}

class _SexRadioButtonState extends State<SexRadioButton> {
  String _selectedValue = '';

  void _handleRadioValueChanged(String? value) {
    setState(() {
      _selectedValue = value ?? '';
      widget.radioValue(value ?? '');
    });
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      _selectedValue = widget.activeValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Row(
        children: <Widget>[
          Radio(
              value: 'Male',
              groupValue: _selectedValue,
              onChanged: _handleRadioValueChanged,
              fillColor: MaterialStateProperty.resolveWith<Color>(
                  (Set<MaterialState> states) {
                if (states.contains(MaterialState.disabled)) {
                  return AppTheme.secondaryColor.withOpacity(.32);
                }
                return AppTheme.secondaryColor;
              })),
          const Text('Male'),
          const SizedBox(
            width: 10,
          ),
          Radio(
              value: 'Female',
              groupValue: _selectedValue,
              onChanged: _handleRadioValueChanged,
              fillColor: MaterialStateProperty.resolveWith<Color>(
                  (Set<MaterialState> states) {
                if (states.contains(MaterialState.disabled)) {
                  return AppTheme.secondaryColor.withOpacity(.32);
                }
                return AppTheme.secondaryColor;
              })),
          const Text('Female'),
         
        ],
      ),
    );
  }
}