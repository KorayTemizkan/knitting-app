import 'package:flutter/material.dart';
import 'package:knitting_app/controllers/url_launcher.dart';

Future<void> DialogButton(BuildContext context) async {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        title: const Text('Merhaba!', style: TextStyle(color: Color(0xFFFF5722)),),
        content: Text('WhatsApp hattımıza yönlendiriliyorsun'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text(
              'Geri Dön',
              style: TextStyle(color: Color(0xFFFF5722)),
            ),
          ),
          TextButton(
            onPressed: () => openWhatsAppSupport(),
            child: const Text(
              'Devam Et',
              style: TextStyle(color: Color(0xFFFF5722)),
            ),
          ),
        ],
      );
    },
  );
}
