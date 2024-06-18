import 'package:flutter/material.dart';
import 'package:logprota/common/helpers/date.dart';

typedef DateTimeChangedCallback = Function(DateTime datetime);

class CustomDateTimePickerField extends StatelessWidget {
  const CustomDateTimePickerField({required this.label, required this.selectedDateTime, required this.onDateTimeChanged, super.key});

  final String label;
  final DateTime selectedDateTime;
  final DateTimeChangedCallback onDateTimeChanged;

  _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(context: context, firstDate: DateTime.now(), lastDate: getOneMonthFromNow());
    if (pickedDate != null && pickedDate != selectedDateTime) {
      _selectTime(context, pickedDate);
    }
  }

  _selectTime(BuildContext context, DateTime selectedDateTime) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null) {
      var finalDateTime = DateTime(selectedDateTime.year, selectedDateTime.month, selectedDateTime.day, pickedTime.hour, pickedTime.minute);
      onDateTimeChanged(finalDateTime);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            initialValue: datetimeToString(selectedDateTime),
            readOnly: true,
            decoration: InputDecoration(
              labelText: label,
              border: const OutlineInputBorder(),
            ),
          ),
        ),
        IconButton(
          onPressed: () => _selectDate(context),
          icon: const Icon(Icons.calendar_month),
        )
      ],
    );
  }
}
