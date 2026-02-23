import 'package:flutter/material.dart';

class EditProfile extends StatelessWidget {
  TextEditingController controller;
  final String labelText;
  final IconData icon;
  EditProfile({
    super.key,
    required this.controller,
    required this.labelText,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 32, vertical: 8),
      elevation: 0,

      child: TextFormField(
        controller: controller,
        // Varsayılan olarak okey tuşununun 
        textInputAction: TextInputAction.done,
        // Klavyeyi kapattığında odağı kaldır
        onFieldSubmitted: (value) {
          FocusScope.of(context).unfocus();
        },
        decoration: InputDecoration(
          prefixIcon: Icon(icon),
          labelText: labelText,
          labelStyle: TextStyle(color: Color(0xFF1E1E1E)),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFFF5722)),
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFFF5722), width: 1),
            borderRadius: BorderRadius.circular(8),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFFF5722)),
            borderRadius: BorderRadius.circular(8),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFFF5722)),
            borderRadius: BorderRadius.circular(8),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFFF5722)),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}
