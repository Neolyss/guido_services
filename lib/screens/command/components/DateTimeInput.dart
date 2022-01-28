import 'package:flutter/material.dart';

class DateTimeInput extends StatefulWidget {
  const DateTimeInput({Key? key, required this.controller}) : super(key: key);

  final TextEditingController controller;

  @override
  _DateTimeInputState createState() => _DateTimeInputState();
}

class _DateTimeInputState extends State<DateTimeInput> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      trailing: IconButton(icon: Icon(Icons.date_range), onPressed: () {
        showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2021, 1),
          lastDate: DateTime(2023, 12),
        ).then((value) {
          if(value != null) {
            widget.controller.text = value.toString();
          }
        });
      },),
      title: TextFormField(
        controller: widget.controller,
        decoration: const InputDecoration(hintText: 'dd/mm/yyyy'),
      ),
    );
  }
}
