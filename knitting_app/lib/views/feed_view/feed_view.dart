import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:knitting_app/controllers/providers/product_provider.dart';
import 'package:knitting_app/models/product_model.dart';
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
    // buradaki build loadProducts içindeki notiftyListeners yüzünden yeniden tetiklendi
    final productProvider = Provider.of<ProductProvider>(context);
    final products = productProvider.products;

    return Scaffold(
      appBar: AppBarWidget(title: 'Akış'),

      body: Center(
        child: Column(
          children: [
            // ŞİMDİLİK UYGULAMADA SADECE FİDAN VE ÖRGÜLERİ OLUCAK. TOPLULUĞA AÇIK HALE DAHA SONRA GETİRİCEM
            // Yana kaydırmalık ya da aşağı kaydırmalık dediklerim var ya, oralara ok ekleyelim
            // PRODUCTS LİSTESİNİ EXPLORE KISMINA TAŞI. ARAMA FONKSİYONUNU ORTAK KULLANIMA AÇ
            // 6 UNSUR OLUCAK

            // MERHABA KORAY, 10 GÜNDÜR BİZİMLESİN,  SP içine ekle ve

            //_SearchAnchorBar(products),

            // FİDAN ÖĞRETMEN'DEN ÖDEVLER SERİSİ, YAPILAN ÖDEV SAYISI 7/22 ( Yana kaydırmalık ) başlangıça seçilen diffuculty'ye göre sırasıyla product önerelim sırasıyla, ürünü bitir, fotoğrafını bize yolla. onaylarsak olsun.düzeye göre bu herkese atansın, örneğin df 1 düzeyinde 15 tane, df 2 düzeyinde 7 tane, herkese toplam 22
                    
            // YENİ EKLENENLER ( Yana kaydırmalık)

            // KNİTTİNG CAFELERİ KEŞFET ( Yana kaydırmalık )

            // EN ÇOK BEĞENİLEN/FAVORİLENEN PRODUCTS KISMI OLSUN, AKIŞ GİBİ( Aşağı kaydırmalık 4'lü grid), BURAYI EKLE, ANALYTİCS, 




            Expanded(
              child: ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final p = products[index];

                  return Card(
                    child: ListTile(
                      onTap: () {
                        context.go('/product', extra: p);
                      },

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
          ],
        ),
      ),
    );
  }

  SearchAnchor _SearchAnchorBar(List<ProductModel> products) {
    return SearchAnchor.bar(
            suggestionsBuilder:
                (BuildContext context, SearchController controller) {
                  final String input = controller.text.toLowerCase();

                  return products
                      .where(
                        (item) => item.title.toLowerCase().contains(input),
                      )
                      .map(
                        (filteredItem) => ListTile(
                          title: Text(filteredItem.title),
                          onTap: () {
                            controller.closeView(filteredItem.title);
                            context.go('/product', extra: filteredItem);
                          },
                        ),
                      )
                      .toList();
                },
          );
  }
}
