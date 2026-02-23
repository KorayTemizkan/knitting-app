import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:knitting_app/controllers/providers/pattern_provider.dart';
import 'package:knitting_app/controllers/providers/shared_preferences_provider.dart';
import 'package:knitting_app/controllers/widgets/cards/bonus_card.dart';
import 'package:knitting_app/controllers/widgets/cards/weekly_progress_card.dart';
import 'package:knitting_app/controllers/widgets/lists/card_list.dart';
import 'package:knitting_app/controllers/widgets/cards/content_card.dart';
import 'package:knitting_app/controllers/widgets/cards/contest_card.dart';
import 'package:knitting_app/controllers/widgets/cards/hero_section_card.dart';
import 'package:knitting_app/controllers/widgets/lists/horizontal_card_list.dart';
import 'package:knitting_app/controllers/widgets/cards/info_card.dart';
import 'package:knitting_app/controllers/widgets/titles/title_text.dart';
import 'package:knitting_app/controllers/widgets/titles/title_text_with_see_all.dart';
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
    // Böyle yaparak sadece products listesini izle gerisiyle ilgilenme diyoruz
    final products = context.select((PatternProvider p) => p.products);
    // DİKKAT! const kullanarak o widgetin bir kere çizilmesini sağlarsın
    // Başında const varsa setstate'den etkilenmezler

    return Scaffold(
      appBar: AppBarWidget(title: 'Ana Sayfa'),

      body: ListView(
        children: [
          HeroSectionCard(),

          TitleText(text: 'Ödüller'),

          // Haftalık İlerleme Kartı Tasarımı
          const WeeklyProgressCard(),

          HorizontalCardList(
            itemCount: 2,
            height: 160, // yükseklik
            cardWidthRatio: 0.6, // sağdan solal yüzde kaç oranı
            itemBuilder: (context, index) {
              return BonusCard(
                bonusType: 'Çark Çevir',
                bonus: 'Hemen Çevir',
              );
            },
          ),

          TitleWithSeeAll(text: 'Yeni Eklenenler'),

          HorizontalCardList(
            itemCount: products.length < 20 ? products.length : 20,
            height: 240, // yükseklik
            cardWidthRatio: 0.6, // sağdan solal yüzde kaç oranı
            itemBuilder: (context, index) {
              final product = products[index];

              return ContentCard(
                title: product.title,
                difficulty: product.difficulty,
                estimatedHour: product.estimatedHour,
                imageUrl: product.imageUrl,
                onTap: () {
                  context.go('/product', extra: product);
                },
              );
            },
          ),

          TitleWithSeeAll(text: 'Bilgi Köşesi'),

          HorizontalCardList(
            itemCount: products.length < 20 ? products.length : 20,
            height: 260, // yükseklik
            cardWidthRatio: 0.6, // sağdan solal yüzde kaç oranı
            itemBuilder: (context, index) {
              final product = products[index];

              return ContentCard(
                title: product.title,
                difficulty: product.difficulty,
                estimatedHour: product.estimatedHour,
                imageUrl: product.imageUrl,
                onTap: () {},
              );
            },
          ),

          TitleWithSeeAll(text: 'Haftanın Favorileri'),

          HorizontalCardList(
            itemCount: products.length < 20 ? products.length : 20,
            height: 260, // yükseklik
            cardWidthRatio: 0.6, // sağdan solal yüzde kaç oranı
            itemBuilder: (context, index) {
              final product = products[index];

              return ContentCard(
                title: product.title,
                difficulty: product.difficulty,
                estimatedHour: product.estimatedHour,
                imageUrl: product.imageUrl,
                onTap: () {},
              );
            },
          ),

          TitleText(text: 'Haftanın Yarışması'),

          ContestCard(
            teacher: 'Fidan',
            name: 'Bebek Patiği',
            difficulty: 'Normal',
            header: '500 tığcık puanı ödüllü yarışma',
            content:
                'YEni doğmuş bebeğinize gönül rahatlığıyla giydirebilirsiniz',
          ),

          TitleText(text: 'Biz Kimiz?'),

          CardList(
            widgets: [
              InfoCard(
                icon: Icon(Icons.abc_outlined, color: Color(0xFFFF5722)),
                text: 'Biz kimiz? :)',
              ),
            ],
          ),

          SizedBox(height: 15),
        ],
      ),
    );
  }
}
