import 'package:flutter/material.dart';
import 'package:knitting_app/controllers/app_bar.dart';

class CommunityView extends StatefulWidget {
  const CommunityView({super.key});

  @override
  State<CommunityView> createState() => _CommunityViewState();
}

class _CommunityViewState extends State<CommunityView> {
  @override
  Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBarWidget(title: 'Topluluk'),
      body: Center(
        child: Column(
          children: [
            /*
            Bu kısımla ilgili düşüncelerim tam net değil ama şimdilik orta boyutta bir logomuzu buraya koyup yakında! uyarısı versek yeter sanırım.
            
            4 UNSUR OLUCAK
            
            Kişi ara kısmı olsun. istediğiniz kişiyi arayıp onun profil sayfasına gidebilelim

            Productunu ekle , Gönderi yaz

            Kişiler ve eserleri ( Yana kaydırmalık ) 

            Gönderiler ( Aşağı kaydırmalık ), yanıtlama özelliği henüz yok, kaydetme olsun, beğenme olsun
            */
          ],
        ),
      ),
    );  }
}