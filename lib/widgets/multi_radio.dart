import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/app_styles.dart';

class MultiRadio extends StatefulWidget {
  const MultiRadio({super.key, required this.radioValue, required this.activeValue});

  @override
  State<MultiRadio> createState() => _MultiRadioState();

  final Function(String) radioValue;
  final String activeValue;
}


class _MultiRadioState extends State<MultiRadio> {
  int? _selectedValue;
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.activeValue == 'Yes'){
      _selectedValue = 1;
    }else if (widget.activeValue == 'No'){
      _selectedValue = 2;
    }else if (widget.activeValue == 'N/A'){
      _selectedValue = 3;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          // Option 1
          Row(
            children: [
              Radio<int>(
                value: 1,
                groupValue: _selectedValue,
                activeColor: AppTheme.secondaryColor,
                onChanged: (int? value) {
                  setState(() {
                    _selectedValue = value;
                    widget.radioValue('Yes');
                  });
                },
              ),
              Text('Yes'),
            ],
          ),
          // Option 2
          Row(
            children: [
              Radio<int>(
                value: 2,
                groupValue: _selectedValue,
                activeColor: AppTheme.secondaryColor,
                onChanged: (int? value) {
                  setState(() {
                    _selectedValue = value;
                    widget.radioValue('No');
                  });
                },
              ),
              Text('No'),
            ],
          ),
          // Option 3
          Row(
            children: [
              Radio<int>(
                value: 3,
                groupValue: _selectedValue,
                activeColor: AppTheme.secondaryColor,
                onChanged: (int? value) {
                  setState(() {
                    _selectedValue = value;
                    widget.radioValue('N/A');
                  });
                },
              ),
              Text('N/A'),
            ],
          ),
        ],
      ),
    );
  }
}


