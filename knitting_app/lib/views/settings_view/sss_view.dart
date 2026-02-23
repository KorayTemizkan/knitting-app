import 'package:flutter/material.dart';
import 'package:knitting_app/controllers/app_bar.dart';
import 'package:knitting_app/controllers/url_launcher.dart';
import 'package:knitting_app/controllers/widgets/lists/card_list.dart';
import 'package:knitting_app/controllers/widgets/my_gesture_button.dart';
import 'package:knitting_app/controllers/widgets/titles/title_text.dart';

class SssView extends StatefulWidget {
  const SssView({super.key});

  @override
  State<SssView> createState() => _SssViewState();
}

class _SssViewState extends State<SssView> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: 'Rehber'),

      body: ListView(
        children: [
          SizedBox(height: 15),

          TitleText(text: 'Başlarken'),
          CardList(
            widgets: [
              MyGestureButton(
                upperRoute: 'profile',
                route: 'how_to_use',
                text: 'Uygulama Nasıl Kullanılır',
                icon: Icons.auto_stories_outlined, // Rehber/Okuma ikonu
              ),
              MyGestureButton(
                upperRoute: 'profile',
                route: 'stitch_glossary',
                text: 'Terimler ve İkonlar',
                icon: Icons.menu_book_outlined,
              ),
              MyGestureButton(
                upperRoute: 'profile',
                route: 'faq',
                text: 'Sık Sorulan Sorular',
                icon: Icons.question_answer_outlined,
              ),
            ],
          ),

          TitleText(text: 'Genel Bilgiler'),
          CardList(
            widgets: [
              MyGestureButton(
                upperRoute: 'profile',
                route: 'size_tables',
                text: 'Ölçü Tabloları',
                icon: Icons.straighten_rounded, // Ölçü/Cetvel ikonu
              ),
              MyGestureButton(
                upperRoute: 'profile',
                route: 'knitting_care',
                text: 'Örgü Bakımı',
                icon: Icons.wash_outlined, // Yıkama/Bakım ikonu
              ),
              MyGestureButton(
                upperRoute: 'profile',
                route: 'knitting_tips',
                text: 'Örgü Örerken Dikkat Edilecekler',
                icon:
                    Icons.lightbulb_outline_rounded, // İpucu/Püf noktası ikonu
              ),
            ],
          ),

          TitleText(text: 'Araçlar'),
          CardList(
            widgets: [
              MyGestureButton(
                upperRoute: 'profile',
                route: 'calculators',
                text: 'Hesaplama Araçları',
                icon: Icons.calculate_outlined, // Hesaplama ikonu
              ),
            ],
          ),

          SizedBox(height: 15),
        ],
      ),
    );
  }
}
