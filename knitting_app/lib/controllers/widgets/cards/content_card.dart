/*
Çalışma Akışı:

Model -> Provider -> View -> HorizontalCardList -> ContentCardList
*/

import 'package:flutter/material.dart';

class ContentCard extends StatelessWidget {
  final String title;
  final String difficulty;
  final String estimatedHour;
  final String imageUrl;
  final VoidCallback? onTap;

  const ContentCard({
    super.key,
    required this.title,
    required this.difficulty,
    required this.estimatedHour,
    this.imageUrl = '',
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: Card(
        // Kartlar arasındaki ayarlama
        elevation: 1, // Kartların gölgelendirmesi
        clipBehavior:
            Clip.antiAlias, // Köşeler taşmasın, görseller düzgün kesilsin
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ), // Kartın kareli ve köşelerinin yuvarlak olması

        child: InkWell(
          // Tıklanabilirlik özelliği
          onTap: onTap,
          child: Column(
            children: [
              Expanded(
                flex: 6,
                child: Container(
                  // Görsel ayarlamaları
                  height: 120,
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
              ),

              Expanded(
                flex: 4,
                child: Padding(
                  padding: const EdgeInsets.all(
                    12,
                  ), // İç kısımda kenarlara uzaklıklar
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.center, // Ortadan başlasın yazılar
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 4),
                      Text(difficulty, style: const TextStyle(fontSize: 12)),
                      const SizedBox(height: 2),
                      Text(
                        estimatedHour,
                        style: const TextStyle(
                          fontSize: 10,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
