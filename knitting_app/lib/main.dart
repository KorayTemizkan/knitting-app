import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:knitting_app/controllers/providers/how_to_provider.dart';
import 'package:knitting_app/controllers/providers/knitting_cafe_provider.dart';
import 'package:knitting_app/controllers/providers/notes_provider.dart';
import 'package:knitting_app/controllers/providers/product_provider.dart';
import 'package:knitting_app/controllers/providers/theme_provider.dart';
import 'package:knitting_app/controllers/router.dart';
import 'package:knitting_app/firebase_options.dart';
import 'package:provider/provider.dart';
import 'package:knitting_app/controllers/shared_preferences.dart';
import 'package:knitting_app/controllers/providers/shared_preferences_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:knitting_app/controllers/providers/auth_provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

  // Firebase ayarlamaları burada yapılır
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  /*
Shared preferences diskten her çağrıda okuma yapmaz, uygulama açılırken diskteki XML/JSON dosyasını bir kere okur
Belleğe yükler
prefs.getStringList(...) gibi çağrılar yaptığında bellekteki Map'ten okur (O(1))

*/
  // dikkat ! uı tarafına daha entegre etmedik
  final sp =
      await SharedPreferences.getInstance(); //sharedpreferences sınıfından katman oluşturma
  final appPreferences = AppPreferences(
    preferences: sp,
  ); // kalıcı veri katmanı oluşturduk

  //final musicController = MusicController();
  // await musicController.init();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductProvider()),
        ChangeNotifierProvider(
          create: (_) => SharedPreferencesProvider(appPreferences),
        ),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => AuthProviderFirebase()),
        ChangeNotifierProvider(create: (_) => HowToProvider()),
        ChangeNotifierProvider(create: (_) => NotesProvider()..init()),
        ChangeNotifierProvider(create: (_) => KnittingCafeProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context
          .read<ProductProvider>()
          .loadProducts(); // widget ağacı oluşturulduğunda sadece tek bir kere verileri internetten çekiyoruz ve yetiyor

      context.read<HowToProvider>().loadHowTos();
      context.read<KnittingCafeProvider>().loadKnittingCafes();
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();

    return MaterialApp.router(
      // Dart'da named parameter = ile değil : ile verilir.
      routerConfig: router,

      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: themeProvider.themeMode,

      debugShowCheckedModeBanner: true,
    );
  }
}
