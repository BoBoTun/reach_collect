import 'package:flutter/material.dart';
import 'package:reach_collect/utils/app_styles.dart';

class LiveStillRadioButton extends StatefulWidget {
const LiveStillRadioButton(
      {super.key, required this.radioValue, required this.activeValue});

  final Function(String) radioValue;
  final String activeValue;
  @override
  State<LiveStillRadioButton> createState() => _LiveStillRadioButtonState();
}

class _LiveStillRadioButtonState extends State<LiveStillRadioButton> {
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
              value: 'Live birth',
              groupValue: _selectedValue,
              onChanged: _handleRadioValueChanged,
              fillColor: MaterialStateProperty.resolveWith<Color>(
                  (Set<MaterialState> states) {
                if (states.contains(MaterialState.disabled)) {
                  return AppTheme.secondaryColor.withOpacity(.32);
                }
                return AppTheme.secondaryColor;
              })),
          const Text('Live birth'),
          
          Radio(
              value: 'Still birth',
              groupValue: _selectedValue,
              onChanged: _handleRadioValueChanged,
              fillColor: MaterialStateProperty.resolveWith<Color>(
                  (Set<MaterialState> states) {
                if (states.contains(MaterialState.disabled)) {
                  return AppTheme.secondaryColor.withOpacity(.32);
                }
                return AppTheme.secondaryColor;
              })),
          const Text('Still birth'),
         
        ],
      ),
    );
  }
}