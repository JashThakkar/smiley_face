import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 4,
        child: _TabsNonScrollableDemo(),
      ),
    );
  }
}

class _TabsNonScrollableDemo extends StatefulWidget {
  @override
  __TabsNonScrollableDemoState createState() => __TabsNonScrollableDemoState();
}

class __TabsNonScrollableDemoState extends State<_TabsNonScrollableDemo>
    with SingleTickerProviderStateMixin, RestorationMixin {
  late TabController _tabController;

  final RestorableInt tabIndex = RestorableInt(0);

  @override
  String get restorationId => 'tab_non_scrollable_demo';

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(tabIndex, 'tab_index');
    _tabController.index = tabIndex.value;
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      initialIndex: 0,
      length: 4,
      vsync: this,
    );
    _tabController.addListener(() {
      setState(() {
        tabIndex.value = _tabController.index;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    tabIndex.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tabs = [
      'tab1',
      'tab2',
      'tab2',
      "tab4",
    ];
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Tabs Demo',
        ),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: false,
          tabs: [
            for (final tab in tabs) Tab(text: tab),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          Center(
            child: CustomPaint(
              size: Size(200, 200),
              painter: PartyEmojiPainter(),
            ),
          ),

          // TAB 2: Red heart
          Center(
            child: CustomPaint(
              size: Size(200, 200),
              painter: HeartPainter(),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSi0zzWDQNYkMxxXfgyEUKhft5_GPdxmhCrpQ&s",
                width: 150,
                height: 150,
              ),
              SizedBox(height: 10),
              Text(
                "Volcano Eruption 54°F",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(
                "https://img.freepik.com/free-vector/hand-drawn-tornado-cartoon-illustration_52683-121089.jpg",
                width: 150,
                height: 150,
              ),
              SizedBox(height: 10),
              Text(
                "Tornado 54°F",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(),
    );
  }
}
class PartyEmojiPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final faceRadius = size.width / 2;

    // Face
    final facePaint = Paint()..color = const Color.fromARGB(255, 59, 137, 255);
    canvas.drawCircle(center, faceRadius, facePaint);

    // Eyes
    final eyePaint = Paint()..color = Colors.black;
    canvas.drawCircle(Offset(size.width * 0.35, size.height * 0.35), 10, eyePaint);
    canvas.drawCircle(Offset(size.width * 0.65, size.height * 0.35), 10, eyePaint);

    // Smile
    final smilePaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5;
    final smileRect = Rect.fromCircle(center: center, radius: size.width * 0.35);
    canvas.drawArc(smileRect, 0.1 * pi, 0.8 * pi, false, smilePaint);

    // Party hat (triangle) sitting on top-left of head
    final hatPath = Path()
      ..moveTo(size.width * 0.25, size.height * 0.10)
      ..lineTo(size.width * 0.55, size.height * 0.1)
      ..lineTo(size.width * 0.38, size.height * -0.8)
      ..close();
    final hatPaint = Paint()..color = Colors.deepPurple;
    canvas.drawPath(hatPath, hatPaint);

    final confettiColors = [
      Colors.red,
      Colors.green,
      Colors.orange,
      Colors.pink,
      Colors.blueAccent,
    ];
    final confettiPositions = [
      Offset(size.width * 0.15, size.height * 0.15),
      Offset(size.width * 0.85, size.height * 0.18),
      Offset(size.width * 0.12, size.height * 0.75),
      Offset(size.width * 0.88, size.height * 0.70),
      Offset(size.width * 0.80, size.height * 0.10),
    ];
    for (int i = 0; i < confettiPositions.length; i++) {
      final p = Paint()..color = confettiColors[i % confettiColors.length];
      canvas.drawCircle(confettiPositions[i], 6, p);
    }

    final hornBase = Offset(size.width * 0.62, size.height * 0.60);
    final hornRect = RRect.fromRectAndRadius(
      Rect.fromCenter(center: hornBase, width: 36, height: 10),
      Radius.circular(4),
    );
    final hornPaint = Paint()..color = Colors.orange;
    canvas.drawRRect(hornRect, hornPaint);

    final hornArcPaint = Paint()
      ..color = Colors.orange
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6;
    final hornArcRect = Rect.fromCircle(
      center: Offset(hornBase.dx + 26, hornBase.dy),
      radius: 14,
    );
    canvas.drawArc(hornArcRect, -pi / 4, pi / 1.2, false, hornArcPaint);

    final stripePaint = Paint()
      ..color = Colors.red
      ..strokeWidth = 3;
    canvas.drawLine(
      Offset(hornBase.dx - 16, hornBase.dy - 4),
      Offset(hornBase.dx + 16, hornBase.dy - 4),
      stripePaint,
    );
    canvas.drawLine(
      Offset(hornBase.dx - 16, hornBase.dy + 4),
      Offset(hornBase.dx + 16, hornBase.dy + 4),
      stripePaint,
    );
  }
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class HeartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.fill;

    final w = size.width;
    final h = size.height;
    final path = Path();

    path.moveTo(w * 0.5, h * 0.75);
    path.cubicTo(w * 0.2, h * 0.55, w * 0.05, h * 0.3, w * 0.25, h * 0.18);
    path.cubicTo(w * 0.40, h * 0.08, w * 0.5, h * 0.18, w * 0.5, h * 0.28);
    path.cubicTo(w * 0.5, h * 0.18, w * 0.60, h * 0.08, w * 0.75, h * 0.18);
    path.cubicTo(w * 0.95, h * 0.3, w * 0.8, h * 0.55, w * 0.5, h * 0.75);
    path.close();

    canvas.drawPath(path, paint);

    final outline = Paint()
      ..color = Colors.red.shade900
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.drawPath(path, outline);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}