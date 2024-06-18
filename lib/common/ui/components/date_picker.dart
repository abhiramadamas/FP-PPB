import 'package:flutter/material.dart';
import 'package:logprota/common/helpers/date.dart';

typedef DateChangedCallback = Function(DateTime datetime);

class CustomDatePickerField extends StatelessWidget {
  const CustomDatePickerField({
    required this.label,
    required this.selectedDate,
    required this.onDateChanged,
    super.key
  });

  final String label;
  final DateTime selectedDate;
  final DateChangedCallback onDateChanged;

  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        firstDate: DateTime.now(),
        lastDate: getOneMonthFromNow());
    if (picked != null && picked != selectedDate) {
      onDateChanged(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: InputDatePickerFormField(
            firstDate: DateTime.now(),
            lastDate: getOneMonthFromNow(),
            initialDate: selectedDate,
            fieldLabelText: label,
          ),
        ),
        IconButton(
            onPressed: () => _selectDate(context),
            icon: const Icon(Icons.calendar_month)
        )
      ],
    );
  }
}
