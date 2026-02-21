import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(body: Home()),
    ),
  );
}

enum ColorType {
  red("red", Colors.red),
  blue("blue", Colors.blue);

  final String label;
  final Color color;

  const ColorType(this.label, this.color);
}

class ChangeColorService extends ChangeNotifier {
  final Map<ColorType, int> _colorMap = {
    for (ColorType color in ColorType.values) color: 1,
  };

  Map<ColorType, int> get colorMap => _colorMap;

  void increment(ColorType color) {
    for (ColorType c in _colorMap.keys) {
      if (color == c) {
        _colorMap[c] = (_colorMap[c] ?? 0) + 1;
      }
    }
    notifyListeners();
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  final colorService = ChangeColorService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _currentIndex == 0
          ? ColorTapsScreen(changeColorService: colorService)
          : StatisticsScreen(changeColorService: colorService),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.tap_and_play),
            label: 'Taps',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Statistics',
          ),
        ],
      ),
    );
  }
}

class ColorTapsScreen extends StatelessWidget {
  final ChangeColorService changeColorService;
  const ColorTapsScreen({super.key, required this.changeColorService});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Color Taps')),
      body: ListenableBuilder(
        listenable: changeColorService,
        builder: (context, child) {
          final colorTapList = [
            for (var entry in changeColorService.colorMap.entries)
              ColorTap(
                type: entry.key,
                tapCount: entry.value,
                onTap: changeColorService.increment,
              ),
          ];

          return Column(children: colorTapList);
        },
      ),
    );
  }
}

class ColorTap extends StatelessWidget {
  final ColorType type;
  final int tapCount;
  final Function(ColorType) onTap;

  const ColorTap({
    super.key,
    required this.type,
    required this.tapCount,
    required this.onTap,
  });

  Color get backgroundColor => type.color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(type),
      child: Container(
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(10),
        ),
        width: double.infinity,
        height: 100,
        child: Center(
          child: Text(
            'Taps: $tapCount',
            style: TextStyle(fontSize: 24, color: Colors.white),
          ),
        ),
      ),
    );
  }
}

class StatisticsScreen extends StatelessWidget {
  final ChangeColorService changeColorService;
  const StatisticsScreen({super.key, required this.changeColorService});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Statistics')),
      body: ListenableBuilder(
        listenable: changeColorService,
        builder: (context, child) {
          final colors = changeColorService._colorMap;
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (var c in colors.entries)
                  Text(
                    '${c.key.label} Taps: ${c.value}',
                    style: TextStyle(fontSize: 24),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
