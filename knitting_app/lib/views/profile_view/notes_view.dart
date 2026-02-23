import 'package:flutter/material.dart';
import 'package:knitting_app/controllers/app_bar.dart';
import 'package:knitting_app/controllers/widgets/lists/card_list.dart';
import 'package:knitting_app/controllers/widgets/segmented_tab.dart';
import 'package:knitting_app/controllers/widgets/cards/subtitled_info_card_with_image.dart';
import 'package:knitting_app/controllers/widgets/cards/take_note_card.dart';
import 'package:knitting_app/controllers/widgets/titles/title_text.dart';

class NotesView extends StatefulWidget {
  const NotesView({super.key});

  @override
  State<NotesView> createState() => _NotepadViewState();
}

class _NotepadViewState extends State<NotesView> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _textController = TextEditingController();
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: 'Notlarım'),
      body: ListView(
        children: [
          CardList(
            widgets: [
              // --- Üst Aksiyonlar (Sıfırla/Taslak) ---
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton.icon(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.refresh_rounded,
                        size: 20,
                        color: Color(0xFFFF5722),
                      ),
                      label: const Text(
                        'Sıfırla',
                        style: TextStyle(color: Color(0xFFFF5722)),
                      ),
                    ),
                    TextButton.icon(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.save_as_outlined,
                        size: 20,
                        color: Color(0xFFFF5722),
                      ),
                      label: const Text(
                        'Taslağı Kaydet',
                        style: TextStyle(color: Color(0xFFFF5722)),
                      ),
                    ),
                  ],
                ),
              ),

              // --- Ana Metin Girişi ---
              TakeNote(
                minLines: 3,
                controller: _textController,
                labelText: 'Ne düşünüyorsun?',
              ),

              const Padding(
                padding: EdgeInsets.fromLTRB(16, 20, 16, 8),
                child: Text(
                  'Not Detayları',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1E1E1E),
                  ),
                ),
              ),

              // --- Teknik Ayrıntılar (İp ve Tığ) ---
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    // İp Markası Girişi
                    TextField(
                      decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.import_contacts_sharp,
                          color: Color(0xFFFF5722),
                        ), // Yumak ikonu niyetine
                        hintText: 'İp Markası / Türü (örn: Alize Cotton Gold)',
                        filled: true,
                        fillColor: Colors.grey[100],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),

                    Row(
                      children: [
                        // Tığ/Şiş Numarası
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              prefixIcon: const Icon(
                                Icons.architecture,
                                color: Color(0xFFFF5722),
                              ),
                              hintText: 'Tığ: 3.5mm',
                              filled: true,
                              fillColor: Colors.grey[100],
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        // Zorluk Seviyesi (Basit bir dropdown veya text field)
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              prefixIcon: const Icon(
                                Icons.speed,
                                color: Color(0xFFFF5722),
                              ),
                              hintText: 'Zorluk: Orta',
                              filled: true,
                              fillColor: Colors.grey[100],
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const Padding(
                padding: EdgeInsets.fromLTRB(16, 24, 16, 8),
                child: Text(
                  'Kategori Seç',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
              ),


              // --- Alt Aksiyonlar (Görsel ve Paylaş) ---
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: OutlinedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.add_a_photo_outlined),
                        label: const Text('Görsel Ekle (0/2)'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: const Color(0xFFFF5722),
                          side: const BorderSide(color: Color(0xFFFF5722)),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFF5722),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: const Text(
                          'Tığcık\'ta Paylaş',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          TripleSegmentButton(
            titles: ['Notlarım', 'Taslaklarım'],
            selectedIndex: selectedIndex,
            onChanged: (index) {
              setState(() {
                selectedIndex = index;
              });
            },
          ),

          TitleText(text: 'Notlarım'),

          CardList(
            widgets: [
              SubtitledInfoCardWithImage(
                imageUrl: 'https://via.placeholder.com/150',
                title: 'Uygulama Kullanımı',
                subtitle: 'Aklına takılan soruları yanıtlayalım',
              ),
              SubtitledInfoCardWithImage(
                imageUrl: 'https://via.placeholder.com/150',
                title: 'Uygulama Kullanımı',
                subtitle: 'Aklına takılan soruları yanıtlayalım',
              ),
              SubtitledInfoCardWithImage(
                imageUrl: 'https://via.placeholder.com/150',
                title: 'Uygulama Kullanımı',
                subtitle: 'Aklına takılan soruları yanıtlayalım',
              ),
              SubtitledInfoCardWithImage(
                imageUrl: 'https://via.placeholder.com/150',
                title: 'Uygulama Kullanımı',
                subtitle: 'Aklına takılan soruları yanıtlayalım',
              ),
              SubtitledInfoCardWithImage(
                imageUrl: 'https://via.placeholder.com/150',
                title: 'Uygulama Kullanımı',
                subtitle: 'Aklına takılan soruları yanıtlayalım',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
