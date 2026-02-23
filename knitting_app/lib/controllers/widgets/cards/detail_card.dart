// En üstteki görsel kısım ve sağ altta bilgi kutusu

import 'package:flutter/material.dart';

class DetailCard extends StatelessWidget {
  final String imageUrl;

  const DetailCard(this.imageUrl, {super.key});

  @override
  Widget build(BuildContext context) {
    // Stack yapısı widgetleri üst üste koymak için yapılır
    return Stack(
      children: [
        // Arka plan görseli
        Column(
          children: [
            Stack(
              clipBehavior:
                  Clip.none, // İçeriğin görselin üzerine taşması için şart
              children: [
                // 1. ANA GÖRSEL (Turuncu Alan)
                Container(
                  // Görsel ayarlamaları
                  height: 240,
                  width: double.infinity,
                  color: Colors.grey[300],
                  child: Image.network(
                    imageUrl.isEmpty
                        ? 'https://via.placeholder.com/150'
                        : imageUrl, // Boş gelirse placeholder
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return const Center(child: CircularProgressIndicator());
                    },
                    // HATA BURADA OLABİLİR: Hata durumunda ne yapacağını söylemezsen uygulama çöker.
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey[300],
                        alignment: Alignment.center,
                        child: const Icon(
                          Icons.broken_image,
                          size: 40,
                          color: Colors.grey,
                        ),
                      );
                    },
                  ),
                ),
                // 2. MANİPÜLASYON ALANI (Sarı/Beyaz İçerik Başlangıcı)
                // Bu container'ı görselin bittiği yere yerleştirip biraz yukarı çekiyoruz
                Positioned(
                  bottom:
                      -1, // Görselle arasında boşluk kalmasın diye tam sıfırlıyoruz
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 30, // Kavisin derinliği kadar yükseklik
                    decoration: const BoxDecoration(
                      color: Colors
                          .white, // Uygulama arka plan rengin neyse o olmalı
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(35),
                        topRight: Radius.circular(35),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        // Sağdaki Yüzen İstatistik Kutusu
        Positioned(
          right: 20,
          bottom: 40,
          child: Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _miniStat(Icons.visibility_outlined, "157"),
                _miniStat(Icons.favorite_border, "18"),
                _miniStat(Icons.bookmark_border, "27"),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _miniStat(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        children: [Icon(icon, size: 16), SizedBox(width: 4), Text(text)],
      ),
    );
  }
}
