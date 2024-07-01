import 'package:flutter/material.dart';
import 'package:reach_collect/utils/app_styles.dart';

class CustomRadioButton extends StatefulWidget {
  const CustomRadioButton({super.key, required this.radioValue, required this.activeValue, required this.radioList});

  final Function(String) radioValue;
  final String activeValue;
  final List<String> radioList;

  @override
  // ignore: library_private_types_in_public_api
  _HorizontalRadioButtonsDemoState createState() =>
      _HorizontalRadioButtonsDemoState();
}

class _HorizontalRadioButtonsDemoState
    extends State<CustomRadioButton> {
  String _selectedValue = '';
  List<String> _radioList = [];

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
      _radioList = widget.radioList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Row(
        children: <Widget>[
          Radio(
              value: _radioList[0],
              groupValue: _selectedValue,
              onChanged: _handleRadioValueChanged,
              fillColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
                if (states.contains(MaterialState.disabled)) {
                  return  AppTheme.secondaryColor.withOpacity(.32);
                }
                return AppTheme.secondaryColor;
              })
          ),
          Text(_radioList[0]),
          const SizedBox(width: 10,),
          Radio(
              value: _radioList[1],
              groupValue: _selectedValue,
              onChanged: _handleRadioValueChanged,
              fillColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
                if (states.contains(MaterialState.disabled)) {
                  return  AppTheme.secondaryColor.withOpacity(.32);
                }
                return AppTheme.secondaryColor;
              })
          ),
      Text(_radioList[1]),
        ],
      ),
    );
  }
}
