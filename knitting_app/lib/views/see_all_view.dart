import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:knitting_app/controllers/app_bar.dart';
import 'package:knitting_app/controllers/providers/contest_provider.dart';
import 'package:knitting_app/controllers/providers/pattern_provider.dart';
import 'package:knitting_app/controllers/providers/tutorial_provider.dart';
import 'package:knitting_app/controllers/widgets/cards/content_card.dart';
import 'package:knitting_app/controllers/widgets/generic_search_anchor_bar.dart';
import 'package:knitting_app/controllers/widgets/lists/vertical_card_list.dart';
import 'package:knitting_app/models/pattern_model.dart';
import 'package:knitting_app/models/searchable_model.dart';
import 'package:knitting_app/models/tutorial_model.dart';
import 'package:provider/provider.dart';

class SeeAllView extends StatefulWidget {
  final String category;

  const SeeAllView({super.key, required this.category});

  @override
  State<SeeAllView> createState() => _SeeAllViewState();
}

class _SeeAllViewState extends State<SeeAllView> {
  @override
  Widget build(BuildContext context) {
    String myCategory = '';
    List myList = [];
    String itemCategory = '';

    switch (widget.category) {
      case 'patterns':
        myList = context.watch<PatternProvider>().products;
        myCategory = 'Tarifler';
        itemCategory = 'product';
        break;
      case 'tutorials':
        myList = context.watch<TutorialProvider>().howTos;
        myCategory = 'Eğitimler';
        break;
      default:
    }

    return Scaffold(
      appBar: AppBarWidget(title: myCategory),
      body: ListView(
        children: [
          SizedBox(height: 16),

          GenericSearchAnchorBar<Searchable>(
            items: [...myList],
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
            itemCount: myList.length,
            cardHeight: 260, // yükseklik
            crossAxisCount: 2, // sağdan solal yüzde kaç oranı
            itemBuilder: (context, index) {
              final element = myList[index];

              return ContentCard(
                title: element.title,
                difficulty: element.difficulty,
                estimatedHour: element.estimatedHour,
                onTap: () {
                  context.go('/${itemCategory}', extra: element);
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
