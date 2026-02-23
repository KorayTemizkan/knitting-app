import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:knitting_app/controllers/app_bar.dart';
import 'package:knitting_app/controllers/providers/knitting_cafe_provider.dart';
import 'package:knitting_app/controllers/widgets/cards/comment_card.dart';
import 'package:knitting_app/controllers/widgets/cards/profile_card.dart';
import 'package:knitting_app/controllers/widgets/cards/subtitled_info_card_with_image.dart';
import 'package:knitting_app/controllers/widgets/cards/success_card.dart';
import 'package:knitting_app/controllers/widgets/generic_search_anchor_bar.dart';
import 'package:knitting_app/controllers/widgets/lists/card_list.dart';
import 'package:knitting_app/controllers/widgets/segmented_tab.dart';
import 'package:knitting_app/controllers/widgets/titles/title_text.dart';
import 'package:provider/provider.dart';

class UserProfileView extends StatefulWidget {
  const UserProfileView({super.key});

  @override
  State<UserProfileView> createState() => _UserProfileViewState();
}

class _UserProfileViewState extends State<UserProfileView> {
  int selectedIndex = 0;
  
  @override
  Widget build(BuildContext context) {
    final knittingCafes = context.watch<KnittingCafeProvider>().knittingCafes;

    return Scaffold(
      appBar: AppBarWidget(title: 'Kullanıcı Profili'),

      body: ListView(
        children: [
          ProfileCard(), // Takip et yapmadık

          TitleText(text: 'Hesaplar'),

          Card(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.camera_alt_outlined),
                      color: const Color(0xFFFF5722),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: const Icon(Icons.play_circle_outline),
                      color: const Color(0xFFFF5722),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: const Icon(Icons.facebook_outlined),
                      color: const Color(0xFFFF5722),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: const Icon(Icons.close_rounded),
                      color: const Color(0xFFFF5722),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: const Icon(Icons.camera_alt_outlined),
                      color: const Color(0xFFFF5722),
                      onPressed: () {},
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.attach_money_outlined),
                      color: const Color(0xFFFF5722),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: const Icon(Icons.push_pin_outlined),
                      color: const Color(0xFF1E1E1E),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: const Icon(Icons.shopping_bag_outlined),
                      color: const Color(0xFF1E1E1E),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: const Icon(Icons.language_rounded),
                      color: const Color(0xFF1E1E1E),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: const Icon(Icons.camera_alt_outlined),
                      color: const Color(0xFFFF5722),
                      onPressed: () {},
                    ),
                  ],
                ),
              ],
            ),
          ),

          TitleText(text: 'Başarılar'),
          Card(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: SuccessCard(),
          ),

          TitleText(text: 'Paylaşımlar'),

          GenericSearchAnchorBar(
            items: [...knittingCafes],
            onItemSelected: (item) {
              context.go('knittingCafes', extra: item);
            },
          ),


          SizedBox(height: 16),

          GridView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 2,
              mainAxisSpacing: 2,
            ),
            itemCount: 30,
            itemBuilder: (context, index) {
              return Container(color: Color(0xFFFF5722));
            },
          ),
        ],
      ),
    );
  }
}
