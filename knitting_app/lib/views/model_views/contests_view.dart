/*

Supabase storageden json içindeki daha önceki tüm yarışmalar çekilecek ve model listesiyle klasik liste oluşturulacak
Yapay Zeka'ya Sor bölümünün arayüzü gibi olucak. Burada üstte son yarışma bilgileri bulunacak
Yarışmanın:
Adı
tarih aralığı
yaptığını yerele yükle (not almak)
yaptığını toplulukla paylaş
ödüller: +100 tığcık, + 25.01.2025 ödülü

*/

import 'package:flutter/material.dart';
import 'package:knitting_app/controllers/app_bar.dart';
import 'package:knitting_app/controllers/providers/contest_provider.dart';
import 'package:provider/provider.dart';

class ContestsView extends StatefulWidget {
  const ContestsView({super.key});

  @override
  State<ContestsView> createState() => _ContestsViewState();
}

class _ContestsViewState extends State<ContestsView> {
  @override
  Widget build(BuildContext context) {
    final contestProvider = context.read<ContestProvider>();
    final contests = contestProvider.contests;
    final contest = contestProvider.currentContest;

    return Scaffold(
      appBar: AppBarWidget(title: 'Yarışmalar'),
      body: Column(
        children: [
          Text(
            'Mevcut Yarışma, yerelde not alabilirsiniz ancak ödül almanız için toplulukta paylaşmanız gerekmektedir. Her 100 beğeni 10 tığcık puan',
          ),

          Divider(height: 50, thickness: 15, color: Colors.amber),

          Expanded(
            child: Card(
              child: Column(
                children: [
                  Text(contest.title),
                  Text(contest.content),
                  ElevatedButton(onPressed: () {}, child: Text('Not al')),
                  ElevatedButton(onPressed: () {}, child: Text('Toplulukta paylaş')),
                ],
              ),
            ),
          ),

          Divider(height: 50, thickness: 15, color: Colors.amber),

          Text('Önceki Yarışmalarım'),
          Expanded(
            child: ListView.builder(
              itemCount: contests.length,
              itemBuilder: (context, index) {
                final contest = contests[index];

                return Card(
                  child: ExpansionTile(
                    title: Text(contest.title),
                    subtitle: Text(contest.difficulty),
                    children: <Widget>[Text(contest.content)],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
