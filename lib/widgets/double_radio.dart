import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/app_styles.dart';

class DoubleRadio extends StatefulWidget {
  const DoubleRadio({super.key, required this.radioValue, required this.activeValue, required this.radioList});

  @override
  State<DoubleRadio> createState() => _DoubleRadioState();

  final Function(String) radioValue;
  final String activeValue;
  final List<String> radioList;
}


class _DoubleRadioState extends State<DoubleRadio> {
  int? _selectedValue;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.radioList.isNotEmpty){
      if (widget.activeValue == widget.radioList[0]){
        _selectedValue = 1;
      }else if (widget.activeValue == widget.radioList[1]){
        _selectedValue = 2;
      }
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
                    widget.radioValue(widget.radioList[0]);
                  });
                },
              ),
              Text(widget.radioList[0]),
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
                    widget.radioValue(widget.radioList[1]);
                  });
                },
              ),
              Text(widget.radioList[1]),
            ],
          ),
        ],
      ),
    );
  }
}


