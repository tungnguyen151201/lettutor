import 'package:flutter/material.dart';

class BirthdayEdition extends StatefulWidget {
  const BirthdayEdition({
    Key? key,
    required this.setBirthday,
    required this.birthday,
  }) : super(key: key);

  final Function({DateTime? birthday}) setBirthday;
  final DateTime? birthday;

  @override
  State<BirthdayEdition> createState() => _BirthdayEditionState();
}

class _BirthdayEditionState extends State<BirthdayEdition> {
  void _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: widget.birthday ?? DateTime.now(), // Refer step 1
      firstDate: DateTime(1900),
      lastDate: DateTime(2030),
    );
    if (picked != null && picked != widget.birthday) {
      widget.setBirthday(birthday: picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _selectDate(context);
      },
      child: Container(
        margin: const EdgeInsets.only(top: 7),
        padding: const EdgeInsets.only(left: 15, right: 15),
        height: 48,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black38),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              stringFormatDateTime(widget.birthday ?? DateTime.now()),
              style: const TextStyle(fontSize: 17),
            ),
          ],
        ),
      ),
    );
  }
}

String stringFormatDateTime(DateTime date) {
  String twoDigits(int n) => n.toString().padLeft(2, "0");

  return "${twoDigits(date.day)}/${twoDigits(date.month)}/${date.year}";
}
