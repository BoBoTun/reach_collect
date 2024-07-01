import 'package:flutter/material.dart';
import 'package:reach_collect/utils/app_constant.dart';
import 'package:reach_collect/utils/app_styles.dart';

class DropdownListView extends StatefulWidget {
  final double containerWidth;
  final Function(String, int) value;
  final List<String> options;
  final String currentValue;
  const DropdownListView({super.key, required this.containerWidth, required this.value, required this.options, required this.currentValue});
  
  @override
  _DropdownExampleState createState() => _DropdownExampleState();
}

class _DropdownExampleState extends State<DropdownListView> {
   String _selectedOption = "";//widget.options[0]; // Initial selected option

  // // Options for the dropdown
  // final List<String> _options = widget.options;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _selectedOption = widget.currentValue;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.containerWidth,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(blurRadius: 5.0, spreadRadius: 5.0, color: Colors.black12)
          ]),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: DropdownButton<String>(
          isExpanded: true,
          underline: Container(),
          focusColor: AppTheme.primaryColor,
          iconEnabledColor: AppTheme.secondaryColor,
          iconSize: 30,
          value: _selectedOption,
          onChanged: (newValue) {
            setState(() {
              print("On Change Value :: $newValue");
              _selectedOption = newValue ?? '';
              widget.value(newValue ?? '', widget.options.indexOf(newValue ?? ''));
            });
          },
          items: widget.options.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ),
    );
  }
}
