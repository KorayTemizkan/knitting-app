import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:knitting_app/controllers/app_bar.dart';
import 'package:knitting_app/controllers/providers/tutorial_provider.dart';
import 'package:knitting_app/controllers/providers/pattern_provider.dart';
import 'package:knitting_app/controllers/widgets/lists/card_list.dart';
import 'package:knitting_app/controllers/widgets/generic_search_anchor_bar.dart';
import 'package:knitting_app/controllers/widgets/segmented_tab.dart';
import 'package:knitting_app/controllers/widgets/cards/subtitled_info_card_with_image.dart';
import 'package:knitting_app/controllers/widgets/cards/take_note_card.dart';
import 'package:knitting_app/controllers/widgets/titles/title_text.dart';
import 'package:knitting_app/models/tutorial_model.dart';
import 'package:knitting_app/models/pattern_model.dart';
import 'package:knitting_app/models/searchable_model.dart';
import 'package:provider/provider.dart';

class PostsView extends StatefulWidget {
  const PostsView({super.key});

  @override
  State<PostsView> createState() => _LikedsViewState();
}

class _LikedsViewState extends State<PostsView> {
  TextEditingController _textController = TextEditingController();
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final products = context.watch<PatternProvider>().products;
    final howTos = context.watch<TutorialProvider>().howTos;

    return Scaffold(
      appBar: AppBarWidget(title: 'Gönderilerim'),
      body: ListView(
        children: [
          TitleText(text: 'Gönderilerim'),

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
            titles: ['Gönderilerim', 'Taslaklarım'],
            selectedIndex: selectedIndex,
            onChanged: (index) {
              setState(() {
                selectedIndex = index;
              });
            },
          ),

          CardList(
            widgets: [
              SubtitledInfoCardWithImage(
                imageUrl: 'https://via.placeholder.com/150',
                title: 'Amigurumi Ayıcık',
                subtitle: 'Eğitim',
              ),
              SubtitledInfoCardWithImage(
                imageUrl: 'https://via.placeholder.com/150',
                title: 'Amigurumi Ayıcık',
                subtitle: 'Eğitim',
              ),
              SubtitledInfoCardWithImage(
                imageUrl: 'https://via.placeholder.com/150',
                title: 'Amigurumi Ayıcık',
                subtitle: 'Eğitim',
              ),
              SubtitledInfoCardWithImage(
                imageUrl: 'https://via.placeholder.com/150',
                title: 'Amigurumi Ayıcık',
                subtitle: 'Eğitim',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
