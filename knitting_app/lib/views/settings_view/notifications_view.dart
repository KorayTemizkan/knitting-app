import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:knitting_app/controllers/app_bar.dart';
import 'package:knitting_app/controllers/providers/knitting_cafe_provider.dart';
import 'package:knitting_app/controllers/widgets/lists/card_list.dart';
import 'package:knitting_app/controllers/widgets/generic_search_anchor_bar.dart';
import 'package:knitting_app/controllers/widgets/segmented_tab.dart';
import 'package:knitting_app/controllers/widgets/cards/subtitled_info_card_with_image.dart';
import 'package:provider/provider.dart';

class NotificationsView extends StatefulWidget {
  const NotificationsView({super.key});

  @override
  State<NotificationsView> createState() => _NotificationsViewState();
}

class _NotificationsViewState extends State<NotificationsView> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    final knittingCafes = context.watch<KnittingCafeProvider>().knittingCafes;

    return Scaffold(
      appBar: AppBarWidget(title: 'Bildirimler'),
      body: ListView(
        children: [
          SizedBox(height: 16),

          GenericSearchAnchorBar(
            items: [...knittingCafes],
            onItemSelected: (item) {
              context.go('knittingCafes', extra: item);
            },
          ),

          SizedBox(height: 8),

          TripleSegmentButton(
            titles: ['Tümü', 'Sosyal', 'Uygulama'],
            selectedIndex: selectedIndex,
            onChanged: (value) {},
          ),

          CardList(
            widgets: [
              SubtitledInfoCardWithImage(
                imageUrl: 'https://via.placeholder.com/150',
                title: 'Arkadaşlık İsteği',
                subtitle: '@kkkkorayyyy',
              ),
              SubtitledInfoCardWithImage(
                imageUrl: 'https://via.placeholder.com/150',
                title: 'Yorum Beğenisi',
                subtitle:
                    '@kkkkorayyyy',
              ),
              SubtitledInfoCardWithImage(
                imageUrl: 'https://via.placeholder.com/150',
                title: 'Uygulama Güncellemesi',
                subtitle: 'Yeni sürümümüz Play Store\'de!',
              ),
              SubtitledInfoCardWithImage(
                imageUrl: 'https://via.placeholder.com/150',
                title: 'Bilgilendirme',
                subtitle: 'Karekod paylaşma hatası üzerine çalışıyoruz',
              ),
              SubtitledInfoCardWithImage(
                imageUrl: 'https://via.placeholder.com/150',
                title: 'Bilgilendirme',
                subtitle: 'Yeni Haftanın Yarışması Yayınlandı!',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
