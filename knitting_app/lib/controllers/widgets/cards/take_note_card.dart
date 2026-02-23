import 'package:flutter/material.dart';

class TakeNote extends StatelessWidget {
  final int minLines;
  TextEditingController controller;
  final String labelText;
  TakeNote({
    super.key,
    required this.minLines,
    required this.controller,
    required this.labelText,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 1,

      child: TextField(
        maxLines: null,
        minLines: minLines,
        controller: controller,

        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: TextStyle(color: Color(0xFF1E1E1E)),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFFF5722)),
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Color(0xFFFF5722), width: 2),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Color(0xFFFF5722)),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Color(0xFFFF5722)),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Color(0xFFFF5722)),
          ),
        ),
      ),
    );
  }
}
