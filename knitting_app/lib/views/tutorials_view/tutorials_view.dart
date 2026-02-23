import 'package:flutter/material.dart';
import 'package:knitting_app/controllers/app_bar.dart';
import 'package:go_router/go_router.dart';
import 'package:knitting_app/controllers/providers/tutorial_provider.dart';
import 'package:knitting_app/controllers/providers/pattern_provider.dart';
import 'package:knitting_app/controllers/widgets/cards/content_card.dart';
import 'package:knitting_app/controllers/widgets/generic_search_anchor_bar.dart';
import 'package:knitting_app/controllers/widgets/lists/horizontal_card_list.dart';
import 'package:knitting_app/controllers/widgets/cards/mini_info_card.dart';
import 'package:knitting_app/controllers/widgets/segmented_tab.dart';
import 'package:knitting_app/controllers/widgets/titles/title_text.dart';
import 'package:knitting_app/controllers/widgets/titles/title_text_with_category.dart';
import 'package:knitting_app/controllers/widgets/lists/vertical_card_list.dart';
import 'package:knitting_app/controllers/widgets/cards/weekly_stars_card.dart';
import 'package:knitting_app/models/tutorial_model.dart';
import 'package:knitting_app/models/pattern_model.dart';
import 'package:knitting_app/models/searchable_model.dart';
import 'package:provider/provider.dart';

class ExploreView extends StatefulWidget {
  const ExploreView({super.key});

  @override
  State<ExploreView> createState() => _SearchViewState();
}

class _SearchViewState extends State<ExploreView> {
  final TextEditingController messageController = TextEditingController();
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final howTos = context.watch<TutorialProvider>().howTos;
    final products = context.watch<PatternProvider>().products;

    return Scaffold(
      appBar: AppBarWidget(title: 'Eğitim'),
      body: ListView(
        // Scrollable yapmaktansa bunu yap, sadece ekranda ne varsa onu render eder
        children: [
          TitleText(text: 'Araçlar'),

          GridView.count(
            crossAxisCount: 2,
            childAspectRatio: 3, // 👈 BU ÇOK KRİTİK
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 8),
            children: [
              MiniInfoCard(
                icon: Icons.menu_book,
                title: 'Rehber',
                onTap: 'sss',
              ),
              MiniInfoCard(
                icon: Icons.emoji_events,
                title: 'Yarışmalar',
                onTap: 'contests',
              ),
              MiniInfoCard(
                icon: Icons.smart_toy,
                title: 'Akıllı Tığcık',
                onTap: 'ai',
              ),
              MiniInfoCard(
                icon: Icons.question_answer,
                title: 'Soru Sor',
                onTap: 'wp',
              ),
            ],
          ),

          TitleText(text: 'Kategoriler'),

          // Amigurumi, Hediyelik, Üst Giyim, Alt Giyim, Aksesuar, Süs
          HorizontalCardList(
            itemCount: 20,
            height: 120,
            cardWidthRatio: 0.18,
            itemBuilder: (context, index) {
              return WeeklyStarsCard(
                title: "Takı",
                difficulty: "27 tarif",
                estimatedHour: "",
                onTap: () {
                  context.go('/tutorials/category');
                },
              );
            },
          ),

          TitleTextWithCategory(title: 'Toplu Eğitimler'),

          TripleSegmentButton(
            titles: ['Eğitimler', 'Tarifler', 'Desenler'],
            selectedIndex: selectedIndex,
            onChanged: (index) {
              setState(() {
                selectedIndex = index;
              });
            },
          ),

          HorizontalCardList(
            itemCount: products.length,
            height: 260, // yükseklik
            cardWidthRatio: 0.6, // sağdan solal yüzde kaç oranı
            itemBuilder: (context, index) {
              final product = products[index];

              return ContentCard(
                title: product.title,
                difficulty: product.difficulty,
                estimatedHour: product.estimatedHour,
                onTap: () {},
              );
            },
          ),

          TitleTextWithCategory(title: 'Tüm İçerikler'),

          GenericSearchAnchorBar<Searchable>(
            items: [...products, ...howTos],
            hintText: 'Ara...',
            onItemSelected: (item) {
              if (item is PatternModel) {
                context.go('/products', extra: item);
              } else if (item is TutorialModel) {
                context.go('/howTo', extra: item);
              }
            },
          ),

          VerticalCardList(
            itemCount: products.length,
            cardHeight: 260, // yükseklik
            crossAxisCount: 2, // sağdan solal yüzde kaç oranı
            itemBuilder: (context, index) {
              final product = products[index];

              return ContentCard(
                title: product.title,
                difficulty: product.difficulty,
                estimatedHour: product.estimatedHour,
                onTap: () {},
              );
            },
          ),

          /*
            Divider(height: 50, thickness: 15, color: Colors.amber),

            Text('PRODUCTS'),
            Expanded(
              child: ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final p = products[index];

                  return Card(
                    child: ListTile(
                      onTap: () {
                        context.go('/product', extra: p);
                      },

                      leading: Image.network(
                        p.imageUrl,
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                      ),

                      title: Text(p.title),
                      subtitle: Text("${p.difficulty}, ${p.estimatedHour}"),
                    ),
                  );
                },
              ),
            ),

            Divider(height: 50, thickness: 15, color: Colors.amber),

            Text('HOWTOS'),
            Expanded(
              child: ListView.builder(
                itemCount: howTos.length,
                itemBuilder: (context, index) {
                  final h = howTos[index];

                  return Card(
                    child: ListTile(
                      onTap: () {
                        context.go('/howTo', extra: h);
                      },

                      leading: Image.network(
                        h.imageUrl,
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                      ),

                      title: Text(h.title),
                      subtitle: Text("${h.difficulty}, ${h.estimatedHour}"),
                    ),
                  );
                },
              ),
            ),
            */
        ],
      ),
    );
  }
}
