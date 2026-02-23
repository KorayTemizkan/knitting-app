import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:knitting_app/controllers/app_bar.dart';
import 'package:knitting_app/controllers/providers/shared_preferences_provider.dart';
import 'package:knitting_app/controllers/providers/supabase_provider.dart';
import 'package:knitting_app/controllers/widgets/lists/card_list.dart';
import 'package:knitting_app/controllers/widgets/cards/edit_profile_card.dart';
import 'package:knitting_app/controllers/widgets/my_gesture_button.dart';
import 'package:knitting_app/controllers/widgets/titles/title_text.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfileView extends StatefulWidget {
  const EditProfileView({super.key});

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _instagramController = TextEditingController();
  final TextEditingController _youtubeController = TextEditingController();
  final TextEditingController _facebookController = TextEditingController();
  final TextEditingController _xController = TextEditingController();
  final TextEditingController _pinterestController = TextEditingController();
  final TextEditingController _shopifyController = TextEditingController();
  final TextEditingController _webSiteController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: 'Profil Güncelleme'),
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Stack(
                alignment: Alignment.bottomCenter,
                clipBehavior: Clip.none,
                children: [
                  Container(
                    height: 120,
                    decoration: BoxDecoration(
                      color: Color(0xFFFF5722),
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(25),
                      ),
                    ),
                  ),

                  Positioned(
                    bottom: -40,
                    child: InkWell(
                      child: CircleAvatar(
                        radius: 50,
                        backgroundColor: const Color.fromARGB(
                          255,
                          230,
                          216,
                          216,
                        ),
                        child: Icon(
                          Icons.person_outline,
                          size: 60,
                          color: Color(0xFFFF5722),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: -40,
                    child: InkWell(
                      child: CircleAvatar(
                        radius: 50,
                        backgroundColor: const Color.fromARGB(
                          255,
                          230,
                          216,
                          216,
                        ),
                        child: Icon(
                          Icons.person_outline,
                          size: 60,
                          color: Color(0xFFFF5722),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.edit),
                      label: const Text('Profil'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFFF5722),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ),
                  Spacer(),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.edit),
                      label: const Text('Kapak'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFFF5722),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            TitleText(text: 'Kullanıcı Bilgileri'),

            EditProfile(
              controller: _firstNameController,
              labelText: 'Ad',
              icon: Icons.person_outline,
            ),
            EditProfile(
              controller: _lastNameController,
              labelText: 'Soyad',
              icon: Icons.badge_outlined,
            ),
            EditProfile(
              controller: _userNameController,
              labelText: 'Kullanıcı Adı',
              icon: Icons.alternate_email,
            ),
            EditProfile(
              controller: _phoneController,
              labelText: 'Telefon Numarası',
              icon: Icons.phone_android_outlined,
            ),

            // --- Sosyal Medya ---
            TitleText(text: 'Sosyal Medya'),

            EditProfile(
              controller:
                  _instagramController, // Buradaki controller'ları düzeltmeyi unutma!
              labelText: 'Instagram',
              icon: Icons.camera_alt_outlined,
            ),
            EditProfile(
              controller: _youtubeController,
              labelText: 'YouTube',
              icon: Icons.play_circle_outline,
            ),
            EditProfile(
              controller: _facebookController,
              labelText: 'Facebook',
              icon: Icons.facebook_outlined,
            ),
            EditProfile(
              controller: _xController,
              labelText: 'X',
              icon: Icons.close, // X için en yakın standart ikon budur
            ),
            EditProfile(
              controller: _pinterestController,
              labelText: 'Pinterest',
              icon: Icons.push_pin_outlined,
            ),
            EditProfile(
              controller: _shopifyController,
              labelText: 'Shopify',
              icon: Icons.shopping_bag_outlined,
            ),
            EditProfile(
              controller: _webSiteController,
              labelText: 'Web Sitesi',
              icon: Icons.language_outlined,
            ),
            EditProfile(
              controller: _webSiteController,
              labelText: 'DENEME',
              icon: Icons.language_outlined,
            ),

            Padding(
              padding: const EdgeInsets.all(16),
              child: SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton.icon(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      context.read<SupabaseProvider>().updateProfile(
                        firstName: _firstNameController.text,
                        lastName: _lastNameController.text,
                        userName: _userNameController.text,
                      );

                      context.read<SharedPreferencesProvider>().setUserName(
                        _userNameController.text,
                      );
                      context.read<SharedPreferencesProvider>().setFirstName(
                        _firstNameController.text,
                      );
                       context.read<SharedPreferencesProvider>().setLastName(
                        _lastNameController.text,
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF5722),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  icon: const Icon(
                    Icons.edit_document,
                    color: Colors.white,
                    size: 20,
                  ),
                  label: Text(
                    'Güncelle',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
