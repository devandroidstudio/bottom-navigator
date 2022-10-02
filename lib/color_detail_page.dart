import 'package:flutter/material.dart';

class ColorsListPage extends StatelessWidget {
  ColorsListPage(
      {Key? key,
      required this.color,
      required this.title,
      required this.onPush})
      : super(key: key);
  final MaterialColor? color;
  final String? title;
  final ValueChanged<int> onPush;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            title!,
          ),
          backgroundColor: color,
        ),
        body: Container(
          color: Colors.white,
          child: _buildList(),
        ));
  }

  final List<int> materialIndices = [
    900,
    800,
    700,
    600,
    500,
    400,
    300,
    200,
    100,
    50
  ];

  Widget _buildList() {
    return ListView.builder(
        itemCount: materialIndices.length,
        itemBuilder: (BuildContext content, int index) {
          int materialIndex = materialIndices[index];
          return Container(
            color: color![materialIndex],
            child: ListTile(
              title: Text('$materialIndex', style: TextStyle(fontSize: 24.0)),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => onPush(materialIndex),
            ),
          );
        });
  }
}

class ColorDetailPage extends StatelessWidget {
  const ColorDetailPage(
      {Key? key,
      required this.color,
      required this.title,
      required this.materialIndex})
      : super(key: key);
  final MaterialColor? color;
  final String? title;
  final int materialIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color![materialIndex],
      appBar: AppBar(
        backgroundColor: color![materialIndex],
        title: Text('$title[$materialIndex]'),
      ),
      body: Container(color: color![materialIndex]),
    );
  }
}
