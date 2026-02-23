import 'package:flutter/material.dart';
import 'package:knitting_app/controllers/app_bar.dart';
import 'package:knitting_app/controllers/providers/contest_provider.dart';
import 'package:knitting_app/controllers/widgets/cards/content_card.dart';
import 'package:knitting_app/controllers/widgets/generic_search_anchor_bar.dart';
import 'package:knitting_app/controllers/widgets/lists/vertical_card_list.dart';
import 'package:knitting_app/models/searchable_model.dart';
import 'package:provider/provider.dart';

class CategoryView extends StatefulWidget {
  const CategoryView({super.key});

  @override
  State<CategoryView> createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
  /*

Kullanıcı şapkayı seçti diyelim, bu sayfada şapka tarifleri listelenecek.

*/
  @override
  Widget build(BuildContext context) {
    final contests = context.read<ContestProvider>().contests;

    return Scaffold(
      appBar: AppBarWidget(title: 'Kategori'),

      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: GenericSearchAnchorBar<Searchable>(
              items: [...contests],
              hintText: 'Ara...',
              onItemSelected: (item) {},
            ),
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
