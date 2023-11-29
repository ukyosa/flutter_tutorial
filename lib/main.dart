import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

// Flutterのレイアウト構築の方法をを学ぶためのサンプルアプリです。
// Flutter公式ドキュメントのBuilding layoutsに沿った実装を行っています。
// ref. https://docs.flutter.dev/ui/layout/tutorial#step-3-implement-the-button-row
class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Step2: Implement the title row
    //
    // テキストやスターアイコンを横に並べた塊をTitleSectionという塊で表現します。
    // buildメソッドの中にこのように記述します。Container配下に複雑なWidgetがネストされていますが、
    // それらを`titleSection`という変数に代入しているのがこちらの記述です。
    // このように記述することで、buildメソッドの中身がすっきりと見やすくなります。
    // ref. https://docs.flutter.dev/ui/layout/tutorial#step-2-implement-the-title-row
    Widget titleSection = Container(
      padding: const EdgeInsets.all(32),
      child: Row(
        children: [
          Expanded(
            /*1*/
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /*2*/
                Container(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: const Text(
                    'Oeschinen Lake Campground',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  'Kandersteg, Switzerland',
                  style: TextStyle(
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          ),
          /*3*/
          Icon(
            Icons.star,
            color: Colors.red[500],
          ),
          const Text('41'),
        ],
      ),
    );

    // Step3: Implement the button row
    //
    // アイコンとテキストを縦に並べた塊をButtonSectionという塊で表現します。
    // Step2とは違い`=`で代入した変数形式とは異なり、`buildButtonColumn`というメソッドで実装されています。
    // メソッドにしている理由は外から（呼び出す側）からカラーやアイコン、テキストを柔軟に変更できるようにするためです。
    // このようにメソッドにしておき呼び出し側で引数を定義しておくことで、同じようなレイアウトを複数箇所で使い回すことができます。
    // ボタンの色、アイコン、テキストが引数で指定されていることで、これらを自由に変更したレイアウトをすぐに使うことができます。
    // ref. https://docs.flutter.dev/ui/layout/tutorial#step-3-implement-the-button-row
    Column buildButtonColumn(Color color, IconData icon, String label) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color),
          Container(
            margin: const EdgeInsets.only(top: 8),
            child: Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: color,
              ),
            ),
          ),
        ],
      );
    }

    // 一旦スルーで大丈夫です。[Colors.blue]など、お好きなカラーを指定しても構いません。
    Color color = Theme.of(context).primaryColor;

    // Step3: Implement the button row
    //
    // 上記で定義した`buildButtonColumn`を呼び出して、`buildButtonColumn`を並べた塊をButtonSectionという塊で表現します。
    Widget buttonSection = Row(
      // 水平方向（RowのMain Axis）に均等にスペースを空けます。
      // 以下の記事がMainAxisAlignmentの各挙動について解説されていますのでご一読推奨です。
      // ref. https://qiita.com/ikemura23/items/67af19b6cbf16fb0251a
      mainAxisAlignment: MainAxisAlignment.spaceEvenly, //
      children: [
        // アイコンとテキストを立てに並べるというレイアウト構造は3つとも一緒なので、`buildButtonColumn`を呼び出すだけで簡単にレイアウトを構築することができます。
        // また、関数の引数にカラー/アイコン/テキストを指定することで、中身だけ差し替えて同じレイアウトを使い回すことができます。
        buildButtonColumn(color, Icons.call, 'CALL'),
        buildButtonColumn(color, Icons.near_me, 'ROUTE'),
        buildButtonColumn(color, Icons.share, 'SHARE'),
      ],
    );

    // Step4: Implement the text section
    //
    // テキストを縦に並べた塊をTextSectionという塊で表現します。
    // ref. https://docs.flutter.dev/ui/layout/tutorial#step-4-implement-the-text-section
    Widget textSection = Container(
      padding: const EdgeInsets.all(32),
      child: const Text(
        'Lake Oeschinen lies at the foot of the Blüemlisalp in the Bernese '
        'Alps. Situated 1,578 meters above sea level, it is one of the '
        'larger Alpine Lakes. A gondola ride from Kandersteg, followed by a '
        'half-hour walk through pastures and pine forest, leads you to the '
        'lake, which warms to 20 degrees Celsius in the summer. Activities '
        'enjoyed here include rowing, and riding the summer toboggan run.',
        softWrap: true,
      ),
    );

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter layout demo'),
        ),
        // Step6: Final touch
        //
        // 画面全体をスクロールできるようにするために、ColumnではなくListViewに変更します。
        // ref. https://docs.flutter.dev/ui/layout/tutorial#step-6-final-touch
        // body: Column(
        body: ListView(
          // Step2~4で定義したWidgetを並べていきます。
          // Column要素のchildrenにWidgetを並べることで、縦に並べることができます。
          // 上から順番に配置されるため、順番を入れ替えると配置も入れ替わります。
          children: [
            // Step5: 画像を読み込んで一番上に配置します。
            // ref. https://docs.flutter.dev/ui/layout/tutorial#step-5-implement-the-image-section
            Image.asset(
              'images/lake.jpg',
              width: 600,
              height: 240,
              fit: BoxFit.cover,
            ),
            titleSection,
            buttonSection,
            textSection,
          ],
        ),
      ),
    );
  }
}
