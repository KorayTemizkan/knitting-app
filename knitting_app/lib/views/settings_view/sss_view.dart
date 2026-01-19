// SUPABASE'DEN YERELE ÇEKİLECEK AMA SONRA YAPARIZ

import 'package:flutter/material.dart';
import 'package:knitting_app/controllers/app_bar.dart';
import 'package:knitting_app/controllers/url_launcher_controller.dart';

class SssView extends StatefulWidget {
  const SssView({super.key});

  @override
  State<SssView> createState() => _SssViewState();
}

class _SssViewState extends State<SssView> {
  Future<void> _showMyDialog() async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Merhaba'),
          content: Text(
            'WhatsApp hattımıza yönlendiriliyorsunuz! Soru, öneri ve şikayetlerinizi bizlere iletebilirsiniz',
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Geri dön'),
            ),
            TextButton(
              onPressed: () => openWhatsAppSupport(),
              child: const Text('Devam et'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: 'Sık Sorulan Sorular'),

      body: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              'Uygulama hakkında kafanıza takılan ya da takılabilecek tüm soruları burada bulabilirsiniz!',
            ),

            Divider(height: 50, thickness: 15, color: Colors.amber),

            Text('Uygulama nasıl kullanılır? Herkes için rehber!'),
            Text('''
          Uygulamada 5 temel ekran vardır. Bunlar Ana sayfa .....
          Arama yapmak için arama butonuna tıkladıktan sonra isted....
          '''),

            Divider(height: 50, thickness: 15, color: Colors.amber),

            Text('Terimler'),
            Text('''
          Tarif: Genel yapılmış bir üründür
          Tığ numarası: ...
          '''),

            Divider(height: 50, thickness: 15, color: Colors.amber),

            Text('Simgeler ve anlamları'),

            Divider(height: 50, thickness: 15, color: Colors.amber),

            Text('Sık Sorulan Sorular'),
            Text('''
          1) Uygulamada yanlışlıkla satın alım yapabilir miyim?
          Hayır, uygulamamızın hiçbir bölümünde satın alma işlevi bulunmamaktadır.

          2) Neden topluluk bölümünde sürekli dönen bir şey var?
          Cihazınızın internet bağlantısının olmaması ya da bir hata olması durumunda topluluk bölümüne erişemezsiniz.

          3)
          
          '''),

            Divider(height: 50, thickness: 15, color: Colors.amber),

            ElevatedButton(
              onPressed: () {
                _showMyDialog();
              },
              child: Text(
                'Aradığını bulamadın mı? Fidan Öğretmen-e sorabilirsin',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
