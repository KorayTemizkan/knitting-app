/*
Google, Pinterest gibi seçeneklerle giriş yapma seçeneklerini daha sonra ekleyeceğim. Şu anda standart olarak Supabase'nin mail ve şifre servisi
Lazy Loading yüklemeye geçmeye gerek var mı? .
Provider ile devam edecek miyiz?

Çevrimdışı mantığını nasıl yapalım? Uygulama Play Store'den indirildikten sonra verileri Supabase'den telefona indirelim. Bundan sonra ise internet bağlantısı
ile giriş yapıldığında versiyon kontrolüyle güncel kalınacak. Eğer yeni versiyon varsa sadece değişenler indirilecek.(Videolar internet bağlantısı olmadığında çalışmasın)

Acil Olanlar:

Modellerin özelliklerini filan yeniden gözden geçir
Page View kullanarak eğitim kısmını yap.
MusicController, İmageController, VideoController yap
Gönderiler, yapay zekadaki listeler filan, bunları da vertical list yeni fonksiyonlar
Bonusları aktif et
Groupby ile keşfete en çok beğenilenden en az beğenilene doğru veri çek

Acil Olmayanlar:

Giriş yap ve Kaydol kısımlarına arka plan logosunu yap. şirket ve uygulama logosunu belirle
Onboarding aktif et
Uygulama açılışına logo ve açılış
Sıralama fonksiyonu çalışmıyor
Posman kullanmaya gerek var mı?
*/

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:knitting_app/controllers/providers/ai_response_provider.dart';
import 'package:knitting_app/controllers/providers/contest_provider.dart';
import 'package:knitting_app/controllers/providers/like_provider.dart';
import 'package:knitting_app/controllers/providers/save_provider.dart';
import 'package:knitting_app/controllers/providers/tutorial_provider.dart';
import 'package:knitting_app/controllers/providers/knitting_cafe_provider.dart';
import 'package:knitting_app/controllers/providers/notes_provider.dart';
import 'package:knitting_app/controllers/providers/policies_provider.dart';
import 'package:knitting_app/controllers/providers/pattern_provider.dart';
import 'package:knitting_app/controllers/providers/release_notes_provider.dart';
import 'package:knitting_app/controllers/providers/supabase_provider.dart';
import 'package:knitting_app/controllers/providers/theme_provider.dart';
import 'package:knitting_app/controllers/router.dart';
import 'package:knitting_app/models/design_model.dart';
import 'package:knitting_app/models/pattern_model.dart';
import 'package:knitting_app/models/tutorial_model.dart';
import 'package:provider/provider.dart';
import 'package:knitting_app/controllers/providers/shared_preferences_provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // RunApp'ten önce yapılması gereken işler varsa kullanılır
  // GİZLİ DOSYA AYARLARI
  await dotenv.load(
    fileName: ".env",
  ); // Github'a atılmaması gereken bilgiler burada saklanılır

  // SHARED PREFERENCES AYARLARI
  // Shared preferences diskten her çağrıda okuma yapmaz, uygulama açılırken diskteki XML/JSON dosyasını bir kere okur ve belleğe yükler
  final spProvider = SharedPreferencesProvider();
  await spProvider.init();

  // HİVE AYARLARI
  await Hive.initFlutter(); // Başlat
  Hive.registerAdapter(PatternModelAdapter()); // Kendi veri yapımızı kaydet
  // 1. Önce Adapter'lar
  // Kutuları açarken isim-tip eşleşmesine dikkat
  await Hive.openBox<PatternModel>('patternBox');

  await Hive.openBox<PatternModel>('likedPatternsBox');

  await Hive.openBox<PatternModel>('savedPatternsBox');

  // SUPABASE AYARLARI, sunucuyla iletişimin başladığı yer
  final supabaseUrl = dotenv
      .env['SUPABASE_URL']!; // buraya koyulan ! null olmayacağını garantiler
  final supabaseAnonKey = dotenv.env['SUPABASE_ANON_KEY']!;
  await Supabase.initialize(url: supabaseUrl, anonKey: supabaseAnonKey);

  // final musicController = MusicController();
  // await musicController.init();

  runApp(
    /*
    Verilerin tüm sayfalara dağılmasının sağlandığı yer burasıdır.
    Kullanacağımız tüm tarifleri, notları vb. için bellekte yer ayırır. Uygulama açılırken etkin olurlar kapanırken etkisiz.
    */
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: spProvider),

        ChangeNotifierProvider(
          create: (context) => SupabaseProvider(
            sharedPreferencesProvider: context
                .read<SharedPreferencesProvider>(),
          ),
        ),

        ChangeNotifierProvider(create: (_) => PatternProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => TutorialProvider()),
        ChangeNotifierProvider(
          create: (_) => NotesProvider()..init(),
        ), // SQFlite ile olan bu ikisinini böyle çektim
        ChangeNotifierProvider(create: (_) => AiAnswersProvider()..init()),
        ChangeNotifierProvider(create: (_) => KnittingCafeProvider()),
        //ChangeNotifierProvider(create: (_) => ReleaseNotesProvider()),
        ChangeNotifierProvider(create: (_) => ContestProvider()),
        //ChangeNotifierProvider(create: (_) => PoliciesProvider()),
        ChangeNotifierProvider(create: (_) => LikeProvider()),
        ChangeNotifierProvider(create: (_) => SaveProvider()),
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

    // GEREKSİZ İSTEKLERİ SAYFA AÇILIŞLARINA TAŞI

    // Uygulama açılıp ekran geldikten sonra api istekleri atılıyor.
    // Böylece açılış sürecini daha da uzatmıyoruz
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final sp = context.read<SharedPreferencesProvider>();

      context.read<PatternProvider>().loadProducts(
        sp,
      ); // widget ağacı oluşturulduğunda sadece tek bir kere verileri internetten çekiyoruz ve yetiyor

      context.read<TutorialProvider>().loadHowTos();
      context.read<KnittingCafeProvider>().loadKnittingCafes();
      //context.read<ReleaseNotesProvider>().loadReleaseNotes();
      context.read<SupabaseProvider>().fetchProfiles();
      context.read<ContestProvider>().loadContests();
      //context.read<PoliciesProvider>().loadPrivacyPolicy();

      // Uygulama açılışında zaten beğenilmiş ve kaydedilmişleri çek
      context.read<LikeProvider>().loadLikeds();
      context.read<SaveProvider>().loadSaveds();
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();

    return MaterialApp.router(
      routerConfig: router,
      theme: themeProvider.currentTheme,
      themeMode: themeProvider.themeMode,
      debugShowCheckedModeBanner: true,
    );
  }
}
