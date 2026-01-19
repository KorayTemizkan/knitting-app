import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:knitting_app/controllers/app_bar.dart';
import 'package:knitting_app/controllers/providers/how_to_provider.dart';
import 'package:knitting_app/controllers/providers/knitting_cafe_provider.dart';
import 'package:knitting_app/controllers/providers/notes_provider.dart';
import 'package:knitting_app/controllers/providers/product_provider.dart';
import 'package:knitting_app/controllers/providers/shared_preferences_provider.dart';
import 'package:knitting_app/controllers/providers/supabase_provider.dart';
import 'package:knitting_app/models/how_to_model.dart';
import 'package:knitting_app/models/knitting_cafe_model.dart';
import 'package:knitting_app/models/note_model.dart';
import 'package:knitting_app/models/product_model.dart';
import 'package:provider/provider.dart';
import 'package:knitting_app/controllers/providers/auth_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  List<ProductModel> savedRecipes = [];
  List<ProductModel> likedRecipes = [];

  List<HowToModel> savedHowTos = [];
  List<HowToModel> likedHowTos = [];

  List<KnittingCafeModel> savedKnittingCafes = [];
  List<KnittingCafeModel> likedKnittingCafes = [];

  String? photoPath;

  List<Note> notes = [];

  final TextEditingController _noteTitleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadAllSavedAndLiked();
  }

  void _loadAllSavedAndLiked() async {
    final sp = context.read<SharedPreferencesProvider>();

    // Recipes
    List<int> savedRecipesIds = sp.savedRecipes
        .map((e) => int.tryParse(e))
        .whereType<int>()
        .toList();
    List<int> likedRecipesIds = sp.likedRecipes
        .map((e) => int.tryParse(e))
        .whereType<int>()
        .toList();

    savedRecipes = await context.read<ProductProvider>().loadWantedProducts(
      savedRecipesIds,
    );
    likedRecipes = await context.read<ProductProvider>().loadWantedProducts(
      likedRecipesIds,
    );

    // HowTos
    List<int> savedHowTosIds = sp.savedHowTos
        .map((e) => int.tryParse(e))
        .whereType<int>()
        .toList();
    List<int> likedHowTosIds = sp.likedHowTos
        .map((e) => int.tryParse(e))
        .whereType<int>()
        .toList();

    savedHowTos = await context.read<HowToProvider>().loadWantedHowTos(
      savedHowTosIds,
    );
    likedHowTos = await context.read<HowToProvider>().loadWantedHowTos(
      likedHowTosIds,
    );

    // Knitting Cafes
    List<int> savedKnittingCafesIds = sp.savedKnittingCafes
        .map((e) => int.tryParse(e))
        .whereType<int>()
        .toList();
    List<int> likedKnittingCafesIds = sp.likedKnittingCafes
        .map((e) => int.tryParse(e))
        .whereType<int>()
        .toList();

    savedKnittingCafes = await context
        .read<KnittingCafeProvider>()
        .loadWantedKnittingCafes(savedKnittingCafesIds);
    likedKnittingCafes = await context
        .read<KnittingCafeProvider>()
        .loadWantedKnittingCafes(likedKnittingCafesIds);

    // Profil fotoğrafı
    photoPath = sp.profilePhoto;

    // rebuild için setState
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final notesProvider = context.watch<NotesProvider>();
    notes = notesProvider.notes;

    final recipesProvider = context.watch<ProductProvider>();
    List<ProductModel> recipes = recipesProvider.products;

    final sp = context.watch<SharedPreferencesProvider>();

    return Scaffold(
      appBar: AppBarWidget(title: 'Profil'),
      body: Center(
        child: Column(
          children: [
            // 4 UNSUR OLUCAK

            // PROFİL
            // KAYDEDİLENLER ( Yana kaydırmalık + yine tam ekrana alma seçeneği olabilir)
            // BEĞENİLENLER ( Yana kaydırmalık +)
            // NOTLARIM ( Yana kaydırmalık +)
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
          ],
        ),
      ),
    );
  }
}
