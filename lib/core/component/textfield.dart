import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {super.key, required this.controller, this.hint, this.multiline = false});

  final TextEditingController? controller;
  final String? hint;
  final bool multiline;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        hintText: hint,
      ),
      maxLines: multiline ? 3 : 1,
    );
  }
}

class LocationTextField extends StatelessWidget {
  const LocationTextField({super.key, required this.controller});

  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}

class DateTimePicker extends StatelessWidget {
  const DateTimePicker(
      {super.key,
      required this.controller,
      required this.isDate,
      required this.function});

  final TextEditingController? controller;
  final bool isDate;
  final Function function;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      readOnly: true,
      onTap: () async {
        isDate
            ? await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2101),
              ).then(
                (value) {
                  if (value != null) {
                    function(value);
                    controller?.text =
                        "${value.day}/${value.month}/${value.year}";
                  }
                },
              )
            : await showTimePicker(
                context: context,
                initialTime: const TimeOfDay(hour: 7, minute: 15),
              ).then(
                (value) {
                  if (value != null) {
                    function(value);
                    controller?.text = "${value.hour}:${value.minute}";
                  }
                },
              );
      },
    );
  }
}
