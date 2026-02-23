import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:knitting_app/controllers/app_bar.dart';
import 'package:knitting_app/controllers/providers/contest_provider.dart';
import 'package:knitting_app/controllers/widgets/cards/content_card.dart';
import 'package:knitting_app/controllers/widgets/cards/contest_card.dart';
import 'package:knitting_app/controllers/widgets/generic_search_anchor_bar.dart';
import 'package:knitting_app/controllers/widgets/titles/title_text.dart';
import 'package:knitting_app/controllers/widgets/lists/vertical_card_list.dart';
import 'package:knitting_app/models/searchable_model.dart';
import 'package:provider/provider.dart';

class ContestsView extends StatefulWidget {
  const ContestsView({super.key});

  @override
  State<ContestsView> createState() => _ContestsViewState();
}

class _ContestsViewState extends State<ContestsView> {
  @override
  Widget build(BuildContext context) {
    final contests = context.read<ContestProvider>().contests;

    return Scaffold(
      appBar: AppBarWidget(title: 'Yarışmalar'),
      body: ListView(
        children: [
          TitleText(text: 'Haftanın Yarışması'),
          ContestCard(
            teacher: 'Fidan',
            name: 'Bebek Patiği',
            difficulty: 'Normal',
            header: '500 tığcık puanı ödüllü yarışma',
            content:
                'Yeni doğmuş bebeğinize gönül rahatlığıyla giydirebilirsiniz',
          ),

          TitleText(text: 'Önceki Yarışmalar'),

          GenericSearchAnchorBar<Searchable>(
            items: [...contests],
            hintText: 'Ara...',
            onItemSelected: (item) {
              context.go('/products', extra: item);
            },
          ),

          VerticalCardList(
            itemCount: contests.length,
            cardHeight: 260, // yükseklik
            crossAxisCount: 2, // sağdan solal yüzde kaç oranı
            itemBuilder: (context, index) {
              final contest = contests[index];

              return ContentCard(
                title: contest.title,
                difficulty: contest.difficulty,
                estimatedHour: contest.content,
                onTap: () {},
              );
            },
          ),
        ],
      ),
    );
  }
}
