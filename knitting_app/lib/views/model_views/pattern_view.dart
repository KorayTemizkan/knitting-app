import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:knitting_app/controllers/app_bar.dart';
import 'package:knitting_app/controllers/providers/like_provider.dart';
import 'package:knitting_app/controllers/providers/pattern_provider.dart';
import 'package:knitting_app/controllers/providers/save_provider.dart';
import 'package:knitting_app/controllers/widgets/lists/card_list.dart';
import 'package:knitting_app/controllers/widgets/cards/comment_card.dart';
import 'package:knitting_app/controllers/widgets/cards/content_card.dart';
import 'package:knitting_app/controllers/widgets/cards/detail_card.dart';
import 'package:knitting_app/controllers/widgets/lists/horizontal_card_list.dart';
import 'package:knitting_app/controllers/widgets/cards/info_card.dart';
import 'package:knitting_app/controllers/widgets/titles/title_text.dart';
import 'package:knitting_app/controllers/widgets/titles/title_text_with_icon.dart';
import 'package:knitting_app/controllers/widgets/titles/title_text_with_see_all.dart';
import 'package:knitting_app/models/pattern_model.dart';
import 'package:provider/provider.dart';

class ProductView extends StatefulWidget {
  final PatternModel product;
  const ProductView({super.key, required this.product});

  @override
  State<ProductView> createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
  @override
  Widget build(BuildContext context) {
    // Burayı idareten koydum ama ihtiyaç duyulan teknikler için özelleştiricem
    final products = context.watch<PatternProvider>().products;

    // Bu sayfamızın tarifi
    PatternModel myPattern = widget.product;

    return Scaffold(
      appBar: AppBarWidget(title: 'Ayrıntı'),

      body: ListView(
        children: [
          DetailCard(
            myPattern.imageUrl,
          ), // Birinci parça: Görsel ve sağdaki küçük kart
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
                      onPressed: () {
                        context.read<LikeProvider>().togglePatternLike(
                          myPattern,
                        );
                      },
                      icon: Icon(
                        context.watch<LikeProvider>().isPatternLiked(myPattern.id.toString())
                            ? Icons.favorite
                            : Icons.favorite_outline,
                      ),
                      color: Color(0xFFFF5722),
                      iconSize: 24,
                    ),

                    IconButton(
                      onPressed: () {
                        context.read<SaveProvider>().togglePatternSave(myPattern
                        );
                      },
                      icon: Icon(
                        context.watch<SaveProvider>().isPatternSaved(
                              myPattern.id.toString()
                            )
                            ? Icons.bookmark
                            : Icons.bookmark_border,
                      ),
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
                Text('${myPattern.difficulty}'),
                SizedBox(width: 20),
                Icon(Icons.access_time, size: 24),
                SizedBox(width: 4),
                Text('${myPattern.estimatedHour}'),
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
                  Text('İplik: ${myPattern.yarnType}'),
                  SizedBox(height: 8),
                  Text('Renkler: ${myPattern.colors}'),
                  SizedBox(height: 8),
                  Text('Tığ numarası: ${myPattern.yarnType}'),
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
            itemCount: products.length,
            height: 260, // yükseklik
            cardWidthRatio: 0.6, // sağdan solal yüzde kaç oranı
            itemBuilder: (context, index) {
              final product = products[index];

              return ContentCard(
                title: product.title,
                difficulty: product.difficulty,
                estimatedHour: product.estimatedHour,
                onTap: () {
                  context.go('/product', extra: product);
                },
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
}
