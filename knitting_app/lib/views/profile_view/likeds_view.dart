import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:knitting_app/controllers/app_bar.dart';
import 'package:knitting_app/controllers/providers/like_provider.dart';
import 'package:knitting_app/controllers/providers/tutorial_provider.dart';
import 'package:knitting_app/controllers/providers/pattern_provider.dart';
import 'package:knitting_app/controllers/widgets/lists/card_list.dart';
import 'package:knitting_app/controllers/widgets/generic_search_anchor_bar.dart';
import 'package:knitting_app/controllers/widgets/cards/subtitled_info_card_with_image.dart';
import 'package:knitting_app/controllers/widgets/segmented_tab.dart';
import 'package:knitting_app/models/design_model.dart';
import 'package:knitting_app/models/tutorial_model.dart';
import 'package:knitting_app/models/pattern_model.dart';
import 'package:knitting_app/models/searchable_model.dart';
import 'package:provider/provider.dart';

class LikedsView extends StatefulWidget {
  const LikedsView({super.key});

  @override
  State<LikedsView> createState() => _LikedsViewState();
}

class _LikedsViewState extends State<LikedsView> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    // Tariflerin model listesini aldık.
    final products = context.watch<PatternProvider>().products;
    final howTos = context.watch<TutorialProvider>().howTos;

    return Scaffold(
      appBar: AppBarWidget(title: 'Beğenilenler'),
      body: Column(
        children: [
          SizedBox(height: 15),

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

          TripleSegmentButton(
            titles: ['Eğitimler', 'Tarifler', 'Desenler'],
            selectedIndex: selectedIndex,
            onChanged: (index) {
              setState(() {
                selectedIndex = index;
              });
            },
          ),

          Expanded(
            // Consumer ile sadece bu widgetin verileri değiştiğinde yeniden çiz diyoruz. Kalana dokunma
            child: Consumer<LikeProvider>(
              builder: (context, likeProvider, child) {
                // 1. Durum: Tarifler seçiliyse
                if (selectedIndex == 0) {
                  return ListView.builder(
                    itemCount: likeProvider.likedPatterns.length,
                    itemBuilder: (context, index) {
                      final item = likeProvider
                          .likedPatterns[index]; // Artık direkt PatternModel!
                      return SubtitledInfoCardWithImage(
                        imageUrl: item.imageUrl,
                        title: item.title,
                        subtitle: item.difficulty,
                        onTap: () => context.go('/products', extra: item),
                      );
                    },
                  );
                }

                return ListView.builder(
                  itemCount: likeProvider.likedPatterns.length,
                  itemBuilder: (context, index) {
                    final item = likeProvider
                        .likedPatterns[index]; // Artık direkt PatternModel!
                    return SubtitledInfoCardWithImage(
                      imageUrl: item.imageUrl,
                      title: item.title,
                      subtitle: item.difficulty,
                      onTap: () => context.go('/products', extra: item),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
