import 'package:flutter/material.dart';
import 'package:simple_month_year_picker/simple_month_year_picker.dart';

import '../utils/app_styles.dart';
// import 'package:flutter_month_picker/flutter_month_picker.dart';

class MonthPicker extends StatefulWidget {
  const MonthPicker({super.key, required this.dateString, required this.updateDateString,});
  final Function(String) dateString;
  final String updateDateString;

  @override
  State<MonthPicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<MonthPicker> {
  DateTime _selectedDate = DateTime.now();
  String showDateString = '';
  DateTime? _selected;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: widget.updateDateString.isNotEmpty ? DateTime.parse(widget.updateDateString) : _selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );

    // final selected = await showMonthPicker(
    //   context: context,
    //   initialDate: DateTime.now(),
    //   firstDate: DateTime(2000),
    //   lastDate: DateTime(2050),
    // );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        widget.dateString("${_selectedDate.toLocal()}".split(' ')[0]);
        showDateString = "${_selectedDate.toLocal()}".split(' ')[0];

      });
    }
  }

  @override
  void initState() {
    super.initState();

    if(widget.updateDateString.isNotEmpty){
      showDateString = widget.updateDateString;
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        // This is in order to get the selected date.
        final selectedDate =
        await SimpleMonthYearPicker.showMonthYearPickerDialog(
          selectionColor: AppTheme.selectColor,
            context: context,
            titleTextStyle: AppTheme.calenderTitle,
            monthTextStyle: AppTheme.calenderTitle,
            yearTextStyle: AppTheme.calenderTitle,
            disableFuture:
            false // This will disable future years. it is false by default.
        );
        // Use the selected date as needed
        print('Selected date: $selectedDate');

        if (selectedDate != null && selectedDate != _selectedDate) {
          setState(() {
            _selectedDate = selectedDate;
            String selectDate = "${selectedDate.toLocal()}".split(' ')[0];
            if (selectDate.length >= 3) {
              selectDate = selectDate.substring(0, selectDate.length - 3);
            }
            widget.dateString(selectDate);
            showDateString = selectDate;

          });
        }
      },
      child: Container(
        height: 50,
        width: 250,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(blurRadius: 5.0, spreadRadius: 5.0, color: Colors.black12)
            ]),
        child:  Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              showDateString,
              style:const TextStyle(fontSize: 17),
            ),
            const Icon(Icons.date_range)
          ],
        ),
      ),
    );
  }
}