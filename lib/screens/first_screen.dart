import 'package:flutter/material.dart';

void main() {
  // debugPaintSizeEnabled = true;
  runApp(const FirstScreen());
}

class FirstScreen extends StatelessWidget {
  const FirstScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget titleSection = Container(
      padding: const EdgeInsets.all(15),
      child: Row(
        children: [
          Expanded(
            /*1*/
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /*2*/
                Container(
                  padding: const EdgeInsets.only(bottom: 1),
                  child: const Text(
                    'a. Amaç ve Kapsam',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
    Widget titleSection2 = Container(
      padding: const EdgeInsets.all(15),
      child: Row(
        children: [
          Expanded(
            /*1*/
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /*2*/
                Container(
                  padding: const EdgeInsets.only(bottom: 1),
                  child: const Text(
                    'b. Genel İlkeler',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
    Widget titleSection3 = Container(
      padding: const EdgeInsets.all(15),
      child: Row(
        children: [
          Expanded(
            /*1*/
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /*2*/
                Container(
                  padding: const EdgeInsets.only(bottom: 1),
                  child: const Text(
                    'b. c. Etik İlkeler',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );

    Widget textSection = const Padding(
      padding: EdgeInsets.all(1),
      child: Text(
        'Harita Dergisi, Haritacılık bilim ve tekniğiyle ilgili konularda, Harita Genel Müdürlüğü çalışanları ile üniversite öğretim elemanlarının ve konularında uzman meslek bireylerinin makalelerini yayımlayarak literatüre katkı sağlamayı, ayrıca dünya ve ülkemizdeki bilimsel gelişmelerin ilgililere duyurulmasını amaçlamaktadır.\n\n'
            'Haritacılık ana bilim dalları (jeodezi ve jeofizik, fotogrametri ve uzaktan algılama, coğrafi bilgi sistemleri, kartografya, kamu ölçmeleri) ve haritacılık ile ilgili diğer disiplinlerde (yerbilimleri, uzay teknolojileri, temel bilimler vb.) olmak üzere; bir araştırma çalışmasını bulgu ve sonuçlarıyla yansıtan orijinal bilimsel makaleler, yeterli sayıda bilimsel makaleyi tarayarak, konuyu bugünkü bilgi düzeyinde özetleyen, değerlendiren, bulguları karşılaştırarak eleştiren bilimsel derleme yazılar, orijinalliği ve bilimsel değeri bakımından çok önemli yabancı dilden çeviri bilimsel makaleler Harita Dergisi’nde yayımlanabilir.',
        style: TextStyle(
          color: Colors.black,
          fontSize: 16,
        ),
        softWrap: true,
      ),
    );
    Widget textSection2 = const Padding(
      padding: EdgeInsets.all(1),
      child: Text(
        '(1) Harita dergisi Harita Genel Müdürlüğü tarafından 29 Ekim 1933 tarihinden itibaren yılda iki kez (Ocak-Temmuz), basılı ve online yayımlanan, üniversite kütüphanelerinden erişilebilir olan, ulusal hakemli bilimsel bir dergidir.\n\n'
            '(2) Harita Dergisinde yazılar Türkçe veya İngilizce olarak yayımlanabilmektedir.\n\n'
        '(3) Harita Dergisi’nin editörü ve beş değişik üniversitenin öğretim üyelerinden oluşmuş Bilim Kurulu bulunmakta ve bilimsel özgün araştırma makaleleri için iki hakemin olumlu görüşü alınmaktadır.\n\n'
        '(4) Dergide çift taraflı kör hakemlik uygulanmaktadır.\n\n'
        '(5) Dergide yayımlanacak makalelerin incelenmesi için, en az doktora derecesinde akademik unvana sahip hakemler görevlendirilmekte, yayımlanacak makale sayısında kota bulunmamakta ve hakemler tarafından incelenmesi tamamlanan makaleler derginin sıradaki ilk sayısında yayımlanmaktadır.\n\n'
        '(6) Yayımlanan yazılardaki fikirler yazarlarına aittir. Harita Genel Müdürlüğünü ve dergiyi sorumlu kılmaz. Dergideki yazı ve resimlerin her hakkı saklıdır.\n\n'
        'Harita Dergisi ayrıca;\n\n(1) Bilimsel ve teknik konularda hazırlanmış ancak hacmi ve özelliği nedeniyle makale şeklinde yayımlanamayan yazılar, bilimsel konferanslar, teknik raporlar, haritacılık yönünden önemli olaylarla ilgili yazılar da olması halinde, Ocak ve Temmuz aylarına ilave özel sayılar şeklinde de yayımlanmakta,\n\n (2)TÜBİTAK-ULAKBİM Mühendislik ve Temel Bilimler Veri Tabanında taranmaktadır.',
        style: TextStyle(
          color: Colors.black,
          fontSize: 16,
        ),
        softWrap: true,
      ),
    );
    Widget textSection3 = const Padding(
      padding: EdgeInsets.all(1),
      child: Text(
        'Harita Dergisi, gönderilen bilimsel yazılarda Yayın Etiği Kurulu COPE (Committee on Publication Ethics)’un Editör ve Yazarlar için Uluslararası Standartları ile ICMJE (International Committee of Medical Journal Editors) tavsiyeleri dikkate almaktadır.\n\n'
            'Harita Dergisi’ne online erişim ücretsiz olup, yayımlanmasıyla birlikte web sayfasından erişilebilir. Ayrıca Harita Dergisi basılı olarak belli miktarlarda ilgili yerlere (Bölümün bulunduğu Üniversite Kütüphanelerine, Yüksekokullara vb.) ücretsiz dağıtılmaktadır. Yayımlanacak makaleler için telif ve işlenme ücreti ödenmemektedir.\n\n',
        style: TextStyle(
          color: Colors.black,
          fontSize: 16,
        ),
        softWrap: true,
      ),
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text('Yayın İlkeleri',style: TextStyle(fontSize: 18,),),
        backgroundColor: Colors.grey,
      ),
        body: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            titleSection,
            textSection,
            titleSection2,
            textSection2,
            titleSection3,
            textSection3,
          ],
        ),
    );
  }
}