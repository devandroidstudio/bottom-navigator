import 'dart:math';

import 'package:flutter/material.dart';

class TestKey extends StatefulWidget {
  const TestKey({Key? key}) : super(key: key);

  @override
  State<TestKey> createState() => _TestKeyState();
}

class _TestKeyState extends State<TestKey> {
  late List<Widget> children = [
    ContainerBox(
      key: Key("1"),
    ),
    ContainerBox(
      key: UniqueKey(),
    ),
  ];

  @override
  void initState() {
    super.initState();
  }

  void swapTwoWidget() {
    setState(() {
      children.insert(1, children.removeAt(0));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          children: children,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: swapTwoWidget,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class ContainerBox extends StatelessWidget {
  const ContainerBox({Key? key}) : super(key: key);
  Color generateRandomColor() {
    // biến random sẽ giúp ta tạo ra 1 số ngẫu nhiên
    final Random random = Random();

    // Màu sắc được tạo nên từ RGB, là một số ngẫu nhiên từ 0 -> 255 và opacity = 1
    return Color.fromRGBO(
        random.nextInt(255), random.nextInt(255), random.nextInt(255), 1);
  }

  @override
  Widget build(BuildContext context) {
    print(key);
    return Container(
      key: key,
      color: generateRandomColor(),
      width: 100,
      height: 100,
    );
  }
}
