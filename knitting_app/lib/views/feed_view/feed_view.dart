import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:knitting_app/controllers/providers/auth_provider.dart';
import 'package:knitting_app/controllers/providers/knitting_cafe_provider.dart';
import 'package:knitting_app/controllers/providers/product_provider.dart';
import 'package:knitting_app/controllers/providers/shared_preferences_provider.dart';
import 'package:knitting_app/controllers/widgets/content_card.dart';
import 'package:knitting_app/controllers/widgets/generic_search_anchor_bar.dart';
import 'package:knitting_app/controllers/widgets/horizontal_card_list.dart';
import 'package:knitting_app/controllers/widgets/info_card.dart';
import 'package:knitting_app/models/product_model.dart';
import 'package:knitting_app/models/searchable_model.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:knitting_app/controllers/app_bar.dart';

class FeedView extends StatefulWidget {
  const FeedView({super.key});

  @override
  State<FeedView> createState() => _FeedViewState();
}

class _FeedViewState extends State<FeedView> {
  @override
  Widget build(BuildContext context) {
    final products = context.watch<ProductProvider>().products;
    final knittingCafes = context.watch<KnittingCafeProvider>().knittingCafes;
    //final auth = context.watch<AuthProviderFirebase>();
    final sp = context.read<SharedPreferencesProvider>();

    return Scaffold(
      appBar: AppBarWidget(title: 'Akış'),

      body: ListView(
        children: [
          Card(
            // margin: En dışta yatay ve dikey ne kadar boşluk olacağını ayarlar
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),

            // elevation: Kartın altındaki gölge miktarını ayarlar.
            elevation: 2,

            child: Padding(
              // padding: Kartın içinde yatay ve dikey ne kadar boşluk olacağını ayarlar.
              padding: const EdgeInsets.all(24.0),

              child: Column(
                // Elemanlar nereye yatık dizilecek
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Merhaba Koray :)",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),

                  // Elemanlar arası boşluğu ayarlar
                  const SizedBox(height: 16),

                  Row(
                    children: [
                      // Sol taraftaki profil fotoğrafı ayarları
                      const CircleAvatar(
                        // Çap büyüklüğü
                        radius: 24,
                        backgroundImage: NetworkImage(
                          'https://via.placeholder.com/150',
                        ),
                      ),

                      // Elemanlar arası boşluğu ayarlar
                      const SizedBox(width: 16),

                      // Orta kısımdaki altı çizili metin
                      const Expanded(
                        child: Text(
                          "Bugün hava patik örmek için çok güzel gözüküyor :)",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),

                      const SizedBox(width: 16),

                      // Sağ alt köşedeki ok ikonu
                      Icon(Icons.arrow_forward, color: Colors.black),
                    ],
                  ),
                ],
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text('Yeni eklenenler'), Text('Tümünü Gör')],
            ),
          ),

          HorizontalCardList(
            itemCount: 20,
            height: 260,
            cardWidthRatio: 0.6,
            itemBuilder: (context, index) {
              return FeedCard(
                title: "Bebek patiği örmek",
                subtitle: "Yeni başlayanlar",
                time: "3 gün önce",
                onTap: () {},
              );
            },
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text('Bilgi Köşesi'), Text('Tümünü Gör')],
            ),
          ),

          HorizontalCardList(
            itemCount: 20,
            height: 260,
            cardWidthRatio: 0.66,
            itemBuilder: (context, index) {
              return FeedCard(
                title: "Bilgi Köşesi",
                subtitle: "Örgü ipuçları",
                time: "1 hafta önce",
              );
            },
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text('Haftanın Enleri'), Text('Tümünü Gör')],
            ),
          ),

          HorizontalCardList(
            itemCount: 20,
            height: 260,
            cardWidthRatio: 0.6,
            itemBuilder: (context, index) {
              return FeedCard(
                title: "Bebek patiği örmek",
                subtitle: "Yeni başlayanlar",
                time: "3 gün önce",
                onTap: () {},
              );
            },
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Haftanın Yarışması',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 12),

              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// ÜST SATIR
                      Row(
                        children: [
                          const CircleAvatar(radius: 20, child: Text('F')),
                          const SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                'Bebek Patiği',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 2),
                              Text('Orta', style: TextStyle(fontSize: 12)),
                            ],
                          ),
                        ],
                      ),

                      const SizedBox(height: 16),

                      /// GÖRSEL ALAN
                      Container(
                        height: 160,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.image,
                          size: 60,
                          color: Colors.grey,
                        ),
                      ),

                      const SizedBox(height: 16),

                      /// ÖDÜL
                      const Text(
                        '500 tığcık puanı ödüllü',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      const SizedBox(height: 4),

                      const Text(
                        'Subtitle',
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),

                      const SizedBox(height: 12),

                      /// AÇIKLAMA
                      const Text(
                        'Yeni doğmuş bebeğinize giydirebileceğiniz doğal ve sağlıklı bu patiklerle çocuğunuzun sağlığını koruyabilirsiniz',
                        style: TextStyle(fontSize: 13),
                      ),

                      const SizedBox(height: 20),

                      /// BUTONLAR
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          OutlinedButton(
                            onPressed: () {},
                            child: const Text('Kaydet'),
                          ),
                          const SizedBox(width: 12),
                          ElevatedButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.star, size: 18),
                            label: const Text('Ayrıntılar'),
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text('İletişim'),
          ),

          InfoCard(
            imageUrl: 'https://via.placeholder.com/150',
            text: 'Bugün hava patik örmek için çok güzel gözüküyor :)',
          ),
        ],
      ),
    );
  }
}
