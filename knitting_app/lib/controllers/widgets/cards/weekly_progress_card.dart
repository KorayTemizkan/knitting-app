import 'package:flutter/material.dart';

class WeeklyProgressCard extends StatelessWidget {
  const WeeklyProgressCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.symmetric(horizontal: 16),

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Color(0xFFFF5722), width: 1),
      ),

      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.next_week_outlined,
                  color: Color(0xFFFF5722),
                  size: 24,
                ),

                SizedBox(width: 8),

                Text(
                  'Haftalık Yolculuğum',
                  style: TextStyle(
                    color: Color(0xFF1E1E1E),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // 7 Günlük İlerleme Çizgisi (GEMİNİ YAPTI ÖZÜR DİLERİM)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(7, (index) {
                bool isCompleted = index < 3; // Örnek: ilk 3 gün tamamlanmış
                return Column(
                  children: [
                    Icon(
                      isCompleted
                          ? Icons.check_circle
                          : Icons.radio_button_unchecked,
                      color: isCompleted
                          ? const Color(0xFFFF5722)
                          : Colors.grey,
                      size: 24,
                    ),
                    Text(
                      "${index + 1}. Gün",
                      style: const TextStyle(fontSize: 10),
                    ),
                  ],
                );
              }),
            ),

            const SizedBox(height: 16),

            const Text(
              "Seriyi tamamla, Sürpriz Tarif'in kilidini aç!",
              style: TextStyle(color: Colors.black54, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
