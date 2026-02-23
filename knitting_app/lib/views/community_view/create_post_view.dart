import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:knitting_app/controllers/app_bar.dart';
import 'package:knitting_app/controllers/widgets/cards/take_note_card.dart';
import 'package:knitting_app/controllers/widgets/titles/title_text.dart';

class CreatePostView extends StatefulWidget {
  const CreatePostView({super.key});

  @override
  State<CreatePostView> createState() => _CreatePostViewState();
}

class _CreatePostViewState extends State<CreatePostView> {
  final TextEditingController _contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: 'Paylaş'),

      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton.icon(
                  onPressed: () => context.go('/register'),
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
              ],
            ),
          ),

          // Metin Girişi
          TakeNote(
            minLines: 4,
            controller: _contentController,
            labelText: 'Ne örüyorsun? (Örn: Bebek battaniyesi bitmek üzere!)',
          ),

          Card(
            elevation: 1,
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ExpansionTile(
              collapsedIconColor: Color(0xFFFF5722),
              iconColor: Color(0xFFFF5722),
              title: TitleText(text: 'Detay Ekle'),
              children: [
                Padding(
                  padding: const EdgeInsetsGeometry.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      // İp Markası Girişi
                      TextField(
                        decoration: InputDecoration(
                          labelText: 'İp Markası / Türü (örn: Ören Bayan)',
                          labelStyle: TextStyle(color: Color(0xFF1E1E1E)),
                          prefixIcon: const Icon(
                            Icons.import_contacts_sharp,
                            color: Color(0xFFFF5722),
                          ), // Yumak ikonu niyetine
                          enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFFFF5722),
                              width: 1,
                            ),
                          ),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFFFF5722),
                              width: 1,
                            ),
                          ),
                        ),
                      ),
            
                      const SizedBox(height: 12),
            
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: DropdownButton<String>(
                              isExpanded: true,
                              alignment: Alignment.center,
                              dropdownColor: Colors.white,
                              underline: Container(
                                height: 1,
                                color: const Color(0xFFFF5722),
                              ),
                              hint: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Icon(
                                    Icons.architecture,
                                    color: Color(0xFFFF5722),
                                    size: 20,
                                  ),
                                  SizedBox(width: 6),
                                  Text('Tığ'),
                                ],
                              ),
                              items: const [
                                DropdownMenuItem(
                                  value: "25",
                                  child: Center(child: Text('2.5 mm')),
                                ),
                                DropdownMenuItem(
                                  value: "30",
                                  child: Center(child: Text('3.0 mm')),
                                ),
                                DropdownMenuItem(
                                  value: "35",
                                  child: Center(child: Text('3.5 mm')),
                                ),
                              ],
                              onChanged: (value) {},
                            ),
                          ),
            
                          const SizedBox(width: 16),
            
                          Expanded(
                            child: DropdownButton<String>(
                              isExpanded: true,
                              alignment: Alignment.center,
                              dropdownColor: Colors.white,
                              underline: Container(
                                height: 1,
                                color: const Color(0xFFFF5722),
                              ),
                              hint: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Icon(
                                    Icons.category_outlined,
                                    color: Color(0xFFFF5722),
                                    size: 20,
                                  ),
                                  SizedBox(width: 6),
                                  Text('Kategori'),
                                ],
                              ),
                              items: const [
                                DropdownMenuItem(
                                  value: "Başlangıç",
                                  child: Center(child: Text('Giyim')),
                                ),
                                DropdownMenuItem(
                                  value: "orta",
                                  child: Center(child: Text('Takı')),
                                ),
                                DropdownMenuItem(
                                  value: "ileri",
                                  child: Center(child: Text('Hediyelik')),
                                ),
                              ],
                              onChanged: (value) {},
                            ),
                          ),
                        ],
                      ),
            
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: DropdownButton<String>(
                              isExpanded: true,
                              alignment: Alignment.center,
                              dropdownColor: Colors.white,
                              underline: Container(
                                height: 1,
                                color: const Color(0xFFFF5722),
                              ),
                              hint: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Icon(
                                    Icons.timeline,
                                    color: Color(0xFFFF5722),
                                    size: 20,
                                  ),
                                  SizedBox(width: 6),
                                  Text('Süre'),
                                ],
                              ),
                              items: const [
                                DropdownMenuItem(
                                  value: "25",
                                  child: Center(child: Text('1 saatten kısa')),
                                ),
                                DropdownMenuItem(
                                  value: "30",
                                  child: Center(child: Text('1 günden kısa')),
                                ),
                                DropdownMenuItem(
                                  value: "35",
                                  child: Center(child: Text('1 haftadan kısa')),
                                ),
                              ],
                              onChanged: (value) {},
                            ),
                          ),
            
                          const SizedBox(width: 16),
            
                          Expanded(
                            child: DropdownButton<String>(
                              isExpanded: true,
                              alignment: Alignment.center,
                              dropdownColor: Colors.white,
                              underline: Container(
                                height: 1,
                                color: const Color(0xFFFF5722),
                              ),
                              hint: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Icon(
                                    Icons.category_outlined,
                                    color: Color(0xFFFF5722),
                                    size: 20,
                                  ),
                                  SizedBox(width: 6),
                                  Text('Düzey'),
                                ],
                              ),
                              items: const [
                                DropdownMenuItem(
                                  value: "Yeni Başlayan",
                                  child: Center(child: Text('bas')),
                                ),
                                DropdownMenuItem(
                                  value: "Orta",
                                  child: Center(child: Text('Orta')),
                                ),
                                DropdownMenuItem(
                                  value: "İleri",
                                  child: Center(child: Text('İleri')),
                                ),
                              ],
                              onChanged: (value) {},
                            ),
                          ),
                        ],
                      ),
            
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: DropdownButton<String>(
                              isExpanded: true,
                              alignment: Alignment.center,
                              dropdownColor: Colors.white,
                              underline: Container(
                                height: 1,
                                color: const Color(0xFFFF5722),
                              ),
                              hint: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Icon(
                                    Icons.architecture,
                                    color: Color(0xFFFF5722),
                                    size: 20,
                                  ),
                                  SizedBox(width: 6),
                                  Text('İp Türü'),
                                ],
                              ),
                              items: const [
                                DropdownMenuItem(
                                  value: "25",
                                  child: Center(child: Text('Yün')),
                                ),
                                DropdownMenuItem(
                                  value: "30",
                                  child: Center(child: Text('Kumaş')),
                                ),
                                DropdownMenuItem(
                                  value: "35",
                                  child: Center(child: Text('Sentetik')),
                                ),
                              ],
                              onChanged: (value) {},
                            ),
                          ),
            
                          const SizedBox(width: 16),
            
                          Expanded(
                            child: DropdownButton<String>(
                              isExpanded: true,
                              alignment: Alignment.center,
                              dropdownColor: Colors.white,
                              underline: Container(
                                height: 1,
                                color: const Color(0xFFFF5722),
                              ),
                              hint: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Icon(
                                    Icons.category_outlined,
                                    color: Color(0xFFFF5722),
                                    size: 20,
                                  ),
                                  SizedBox(width: 6),
                                  Text('Durum'),
                                ],
                              ),
                              items: const [
                                DropdownMenuItem(
                                  value: "Başlangıç",
                                  child: Center(child: Text('Bitti')),
                                ),
                                DropdownMenuItem(
                                  value: "orta",
                                  child: Center(child: Text('Devam')),
                                ),
                                DropdownMenuItem(
                                  value: "ileri",
                                  child: Center(child: Text('Başlayacak')),
                                ),
                              ],
                              onChanged: (value) {},
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ],
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
    );
  }
}
