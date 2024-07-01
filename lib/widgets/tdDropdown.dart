import 'package:flutter/material.dart';
import 'package:reach_collect/utils/app_styles.dart';
import 'package:reach_collect/widgets/date_picker.dart';

class TDDropDownView extends StatefulWidget {
  TDDropDownView({
    super.key,
    required this.currentValue,
    required this.dateString,

  });
  final String currentValue;
  Function(String) dateString;

  /*
  final String currentValue;
  const DropdownListView({super.key, required this.containerWidth, required this.value, required this.options, required this.currentValue});
   */

  @override
  _TDDropDownState createState() => _TDDropDownState();
}

class _TDDropDownState extends State<TDDropDownView> {
  String _selectedOption = ''; // Initial selected option

  // Options for the dropdown
  final List<String> _options = [
    '1st',
    '2nd',
  ];

  DateTime selectedDate = DateTime.now();
  String showDateString = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _selectedOption = widget.currentValue;
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1900),
        lastDate: DateTime(2101),
        );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
       widget.dateString("$_selectedOption | "+"${selectedDate.toLocal()}".split(' ')[0]);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(blurRadius: 5.0, spreadRadius: 5.0, color: Colors.black12)
          ]),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: DropdownButton<String>(
          isExpanded: true,
          underline: Container(),
          focusColor: AppTheme.primaryColor,
          iconEnabledColor: AppTheme.secondaryColor,
          iconSize: 30,
          value: _selectedOption,
          onChanged: (newValue) async {
            setState(() {
              _selectedOption = newValue ?? '';
              widget.dateString("$_selectedOption");
            });

            // Future.delayed(Duration(milliseconds: 200), () {
            //   _selectDate(context);
            // });
          },
          items: _options.map<DropdownMenuItem<String>>((String value) {
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
