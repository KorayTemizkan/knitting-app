import 'package:flutter/material.dart';
import 'package:knitting_app/controllers/app_bar.dart';
import 'package:knitting_app/controllers/providers/knitting_cafe_provider.dart';
import 'package:knitting_app/controllers/providers/notes_provider.dart';
import 'package:knitting_app/controllers/providers/pattern_provider.dart';
import 'package:knitting_app/controllers/providers/shared_preferences_provider.dart';
import 'package:knitting_app/controllers/providers/tutorial_provider.dart';
import 'package:knitting_app/controllers/widgets/lists/card_list.dart';
import 'package:knitting_app/controllers/widgets/my_gesture_button.dart';
import 'package:knitting_app/controllers/widgets/cards/profile_card.dart';
import 'package:knitting_app/controllers/widgets/cards/success_card.dart';
import 'package:knitting_app/controllers/widgets/titles/title_text.dart';
import 'package:knitting_app/models/tutorial_model.dart';
import 'package:knitting_app/models/knitting_cafe_model.dart';
import 'package:knitting_app/models/note_model.dart';
import 'package:knitting_app/models/pattern_model.dart';
import 'package:provider/provider.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  String? photoPath;

  List<Note> notes = [];

  final TextEditingController _noteTitleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: 'Profil'),
      body: ListView(
        children: [
          ProfileCard(), // Yukarıdaki widget'ı burada çağırıyorsun

          TitleText(text: 'Hesaplarım'),

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

          TitleText(text: 'Başarılarım'),
          Card(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: SuccessCard(),
          ),

          TitleText(text: 'Listelerim'),
          CardList(
            widgets: [
              MyGestureButton(
                upperRoute: 'profile',
                route: 'unfinisheds',
                text: 'Yarım Bıraktıklarım',
                icon: Icons.play_circle_outline,
              ),
              MyGestureButton(
                upperRoute: 'profile',
                route: 'finisheds',
                text: 'Bitirilenler',
                icon: Icons.check_circle_outline,
              ),
              MyGestureButton(
                upperRoute: 'profile',
                route: 'likeds',
                text: 'Beğenilenler',
                icon: Icons.favorite_outline,
              ),
              MyGestureButton(
                upperRoute: 'profile',
                route: 'saveds',
                text: 'Kaydedilenler',
                icon: Icons.bookmark_outline,
              ),
              MyGestureButton(
                upperRoute: 'profile',
                route: 'posts',
                text: 'Gönderilerim',
                icon: Icons.list_alt,
              ),
              MyGestureButton(
                upperRoute: 'profile',
                route: 'notes',
                text: 'Notlarım',
                icon: Icons.notes,
              ),
            ],
          ),

          SizedBox(height: 15),

          /*
            Expanded(
              child: GridView.count(
                crossAxisCount: 4,
                children: <Widget>[
                  Text('KULLANICI BILGILERI'),

                  //Text(authProvider.email ?? 'Giris yapilmadi'),
                  //Text(authProvider.uid ?? 'ID yok'),
                  Text('Ad: ${sp.firstName}'),
                  Text('Soyad: ${sp.lastName}'),
                  Text('Telefon: ${sp.phone}'),

                  ElevatedButton(
                    onPressed: () {
                      context.go('/profile/editProfile');
                    },
                    child: Text('Profilimi düzenle'),
                  ),

                  photoPath != null
                      ? Image.file(
                          File(photoPath!),
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                        )
                      : const CircleAvatar(
                          radius: 60,
                          child: Icon(Icons.person),
                        ),

                  ElevatedButton(
                    onPressed: () async {
                      await context
                          .read<SharedPreferencesProvider>()
                          .pickProfileImage();

                      setState(() {
                        photoPath = context
                            .read<SharedPreferencesProvider>()
                            .profilePhoto;
                      });
                    },
                    child: const Text("Profil fotografi koy!"),
                  ),

                  ElevatedButton(
                    onPressed: () async {
                      await context
                          .read<SharedPreferencesProvider>()
                          .setFirstOpening();

                      setState(() {});
                    },
                    child: const Text("İlk girisi ac!"),
                  ),

                  /*
                  ElevatedButton(
                    onPressed: () async {
                      authProvider.signOut();
                    },
                    child: Text('Cikis yap!'),
                  ),
                  */
                ],
              ),
            ),

            Divider(height: 50, thickness: 15, color: Colors.amber),
            /*
            Text('Kaydedilen Tarifler'),

            Expanded(
              child: ListView.builder(
                itemCount: savedRecipes.length,
                itemBuilder: (context, index) {
                  final recipe = savedRecipes[index];

                  return Card(
                    child: ListTile(
                      leading: Image.network(
                        recipe.imageUrl,
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                      ),

                      title: Text(recipe.title),
                      subtitle: Text(
                        "${recipe.difficulty}, ${recipe.estimatedHour}",
                      ),
                    ),
                  );
                },
              ),
            ),

            Divider(height: 50, thickness: 15, color: Colors.amber),

            Text('Beğenilen Tarifler'),

            Expanded(
              child: ListView.builder(
                itemCount: likedRecipes.length,
                itemBuilder: (context, index) {
                  final p = likedRecipes[index];

                  return Card(
                    child: ListTile(
                      leading: Image.network(
                        p.imageUrl,
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                      ),

                      title: Text(p.title),
                      subtitle: Text("${p.difficulty}, ${p.estimatedHour}"),
                    ),
                  );
                },
              ),
            ),

            Divider(height: 50, thickness: 15, color: Colors.amber),
*/
            TextField(
              controller: _noteTitleController,
              decoration: InputDecoration(
                labelText: 'Başlık',
                border: OutlineInputBorder(),
              ),
              maxLines: null,
            ),

            TextField(
              controller: _noteController,
              decoration: InputDecoration(
                labelText: 'Not',
                border: OutlineInputBorder(),
              ),
              maxLines: null,
            ),

            ElevatedButton(
              onPressed: () async {
                await notesProvider.addNote(
                  _noteTitleController.text,
                  _noteController.text,
                );

                await context.read<SupabaseProvider>().insertNote(
                  title: _noteTitleController.text,
                  note: _noteController.text,
                );
              },

              child: const Text('Not ekle'),
            ),

            Expanded(
              child: ListView.builder(
                itemCount: notes.length,
                itemBuilder: (context, index) {
                  final n = notes[index];

                  return Card(
                    child: ExpansionTile(
                      title: Text(n.title),
                      subtitle: Text('${n.time}'),
                      children: [
                        Text(n.note),
                        ElevatedButton(
                          onPressed: () async {
                            await notesProvider.deleteNote(n.id);
                          },
                          child: Text('Sil'),
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            await notesProvider.updateNote(
                              _noteTitleController.text,
                              _noteController.text,
                              n.id,
                            );
                          },
                          child: Text('Düzenle'),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            */
        ],
      ),
    );
  }
}
