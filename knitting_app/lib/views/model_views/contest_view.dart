import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:knitting_app/controllers/app_bar.dart';
import 'package:knitting_app/controllers/providers/contest_provider.dart';
import 'package:knitting_app/controllers/providers/pattern_provider.dart';
import 'package:knitting_app/controllers/widgets/lists/card_list.dart';
import 'package:knitting_app/controllers/widgets/cards/comment_card.dart';
import 'package:knitting_app/controllers/widgets/cards/content_card.dart';
import 'package:knitting_app/controllers/widgets/cards/detail_card.dart';
import 'package:knitting_app/controllers/widgets/lists/horizontal_card_list.dart';
import 'package:knitting_app/controllers/widgets/cards/info_card.dart';
import 'package:knitting_app/controllers/widgets/titles/title_text.dart';
import 'package:knitting_app/controllers/widgets/titles/title_text_with_icon.dart';
import 'package:knitting_app/controllers/widgets/titles/title_text_with_see_all.dart';
import 'package:knitting_app/models/contest_model.dart';
import 'package:knitting_app/models/pattern_model.dart';
import 'package:knitting_app/controllers/providers/shared_preferences_provider.dart';
import 'package:provider/provider.dart';

class ContestView extends StatefulWidget {
  const ContestView({super.key});

  @override
  State<ContestView> createState() => _ContestViewState();
}

class _ContestViewState extends State<ContestView> {
  bool isSaved = false; // burada neden string kullandın ki gerek yoktu akıllı
  bool isLiked = false;

  List<String> savedCharactersList = [];

  /*
  
  burada tüm uygulamada kullanmak için tek bir provider treferansı önerilmiyor.
  Context her zaman güvenli değildir ve lifecylcle bağlıdır. çünkü daha context oluşmadı,
  widget ağaca eklenmedi, provider tree hazır değil.
  Hot reload/ yeniden başlatma ya da başka durumlarda sorun çıkabilir
  o yüzden aşağıda elevated button içinde yeniden tanımlıyoruz.
  özet : en güvenli yol ihtiyaç anında context üzerinden almak veya build içinde okumaktır

  unutma ! Provider.of nesne oluşturmaz. O(1)'lik referans oluşturur.

  */

  @override
  Widget build(BuildContext context) {
    final contests = context.watch<ContestProvider>().contests;
    ContestModel myContest = contests.first;

    return Scaffold(
      appBar: AppBarWidget(title: 'Ayrıntı'),

      body: ListView(
        children: [
          //DetailCard(
          //myContest.imageUrl,
          //), // Birinci parça: Görsel ve sağdaki küçük kart
          // Başlık ve İkonlar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Yazlık Battaniye",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.favorite_outline),
                      color: Color(0xFFFF5722),
                      iconSize: 24,
                    ),

                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.bookmark_border),
                      color: Color(0xFFFF5722),
                      iconSize: 24,
                    ),

                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.share_outlined),
                      color: Color(0xFFFF5722),
                      iconSize: 24,
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Seviye ve Süre
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Icon(Icons.show_chart, size: 24),
                SizedBox(width: 4),
                Text('${myContest.difficulty}'),
                SizedBox(width: 20),
                Icon(Icons.access_time, size: 24),
                SizedBox(width: 4),
                Text('${myContest.dateRange}'),
              ],
            ),
          ),

          SizedBox(height: 20),

          TitleWithIcon(title: 'İhtiyaçlar', icon: Icons.inventory_2_outlined),

          // Gri Bilgi Kutusu
          Card(
            elevation: 1,
            margin: const EdgeInsets.all(8),

            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('İplik: ${myContest.difficulty}'),
                  SizedBox(height: 8),
                  Text('Renkler: ${myContest.rewards}'),
                  SizedBox(height: 8),
                  Text('Tığ numarası: ${myContest.title}'),
                ],
              ),
            ),
          ),

          TitleWithIcon(title: 'Açıklama', icon: Icons.description_outlined),
          // Gri Bilgi Kutusu
          Card(
            elevation: 1,
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "WAFEGWKRHTMDIOXFGKJDRTIXGFNJGCKMDRFNVMKDLMDKMF GNMDFKSLFJIDSKOMIDKOPLMGIODFKMGWKRHTMDIOXFGKJDRTIXGFNJGCKMDRFNVMKDLMDKMF GNMDFKSLFJGWKRHTMDIOXFGKJDRTIXGFNJGCKMDRFNVMKDLMDKMF GNMDFKSLFJGWKRHTMDIOXFGKJDRTIXGFNJGCKMDRFNVMKDLMDKMF GNMDFKSLFJGWKRHTMDIOXFGKJDRTIXGFNJGCKMDRFNVMKDLMDKMF GNMDFKSLFJ",
                  ),
                ],
              ),
            ),
          ),

          TitleWithIcon(
            title: 'Bilmen Gereken Teknikler',
            icon: Icons.auto_awesome_motion,
          ),

          HorizontalCardList(
            itemCount: contests.length,
            height: 260, // yükseklik
            cardWidthRatio: 0.6, // sağdan solal yüzde kaç oranı
            itemBuilder: (context, index) {
              final contest = contests[index];

              return ContentCard(
                title: contest.title,
                difficulty: contest.difficulty,
                estimatedHour: contest.dateRange,
                onTap: () {},
              );
            },
          ),

          TitleWithIcon(
            title: 'Eğitime Başla',
            icon: Icons.rocket_launch_outlined,
          ),

          Card(
            color: Color(0xFFFF5722),
            // margin: En dışta yatay ve dikey ne kadar boşluk olacağını ayarlar
            margin: EdgeInsets.only(top: 0, left: 16, right: 16),
            // elevation: Kartın altındaki gölge miktarını ayarlar.
            elevation: 0,

            shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusGeometry.circular(16),
              side: const BorderSide(color: Color(0xFFFF5722), width: 1),
            ),

            child: Column(
              // Elemanlar nereye yatık dizilecek
              children: [
                // Elemanlar arası boşluğu ayarlar
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // Sol taraftaki profil fotoğrafı ayarları
                      const CircleAvatar(
                        // Çap büyüklüğü
                        radius: 24,
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.person_outline,
                          color: Color(0xFFFF5722),
                        ),
                      ),

                      // Elemanlar arası boşluğu ayarlar
                      const SizedBox(width: 16),

                      Text(
                        "Merhaba Koray :)",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 16),

                Padding(
                  padding: const EdgeInsets.only(
                    left: 16,
                    right: 16,
                    bottom: 16,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,

                    children: [
                      // Orta kısımdaki altı çizili metin
                      const Expanded(
                        child: Text(
                          "Eğitime Başlamaya Hazır Mısın?",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),

                      // Sağ alt köşedeki ok ikonu
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: Icon(
                          Icons.arrow_forward,
                          color: Color(0xFFFF5722),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          TitleWithSeeAll(text: 'Yorumlar'),

          PostCard(showComments: false),

          TitleText(text: 'İletişim'),

          CardList(
            widgets: [
              InfoCard(
                icon: Icon(Icons.abc_outlined),
                text: 'Aklına takılanı sor :)',
              ),
            ],
          ),
        ],
      ),
    );
  }
  
  /*
  ElevatedButton likeProduct(BuildContext context) => ElevatedButton(
    onPressed: () {
      setState(() {
        isLiked = !isLiked;
      });
    },
    child: Text(isLiked ? 'Unlike' : 'Like'),
  );

  ElevatedButton saveProduct(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        final sp = context.read<SharedPreferencesProvider>();

        if (isSaved) {
          sp.removeSavedRecipe(contest.id);
        } else {
          sp.saveRecipe(widget.contest.id);
        }

        setState(() {
          isSaved = !isSaved;
        });
      },
      child: Text(isSaved ? 'Unsave' : 'Save'),
    );
  }
  */
}
