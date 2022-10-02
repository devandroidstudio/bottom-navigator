import 'package:bottom_navigator/key_test.dart';
import 'package:bottom_navigator/multiple_botom_naviagtor.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (context) => const MyHomePage(title: 'Flutter Demo Home Page'),
        'bottom': (context) => const BottomnavigatorApp(),
        'swapTowWidget': (context) => const TestKey()
      },
      initialRoute: 'bottom',
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final itemKey = GlobalKey();

  final ScrollController controller = ScrollController();

  int _currentTab = 0;
  static const List<Widget> _widgetOption = [
    Text("Index 0: Home"),
    Text("Index 1: Business"),
    Text("Index 3: School"),
    Text("Index 4: Setting"),
  ];

  Widget _listViewOption() {
    return ListView.builder(
      controller: controller,
      itemBuilder: (context, index) {
        return Text(
          '$index',
          style: TextStyle(color: Colors.black, fontSize: 100),
        );
      },
      itemCount: 4,
      scrollDirection: Axis.horizontal,
    );
  }

  Widget _listViewBody() {
    return ListView.separated(
        findChildIndexCallback: (key) {},
        controller: controller,
        itemBuilder: (context, index) {
          return Center(
            child: ListTile(
              title: Text(
                '$index',
                key: index == 25 ? itemKey : null,
                style: TextStyle(color: Colors.black),
              ),
            ),
          );
        },
        separatorBuilder: (context, index) => const Divider(),
        itemCount: 50);
  }

  Future scrollToItem() async {
    final context = itemKey.currentContext;
    await Scrollable.ensureVisible(context!,
        alignment: 0.5,
        curve: Curves.linear,
        duration: const Duration(milliseconds: 500));
  }

  void _onItemTapped(int index) {
    setState(() {
      _currentTab = index;
      if (_currentTab == index) {
        controller.animateTo(index.toDouble(),
            duration: const Duration(milliseconds: 500),
            curve: Curves.fastLinearToSlowEaseIn);
      }
    });
  }

  int count = 0;
  List<int> listint = [];
  _Increament() {
    setState(() {
      count++;
      listint.add(count);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("aksbdas")),
      body: ListWidget(items: listint),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _Increament(),
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        currentIndex: _currentTab,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Colors.red,
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.business),
              label: "Business",
              backgroundColor: Colors.redAccent),
          BottomNavigationBarItem(
              icon: Icon(Icons.school),
              label: "Schoole",
              backgroundColor: Colors.blue),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
            backgroundColor: Colors.pink,
          ),
        ],
        onTap: _onItemTapped,
        selectedItemColor: Colors.amber,
        unselectedItemColor: Colors.deepPurple,
        showSelectedLabels: true,
      ),
    );
  }
}

class ListWidget extends StatelessWidget {
  const ListWidget({Key? key, required this.items}) : super(key: key);

  final List<int> items;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        final item = items[index];
        return ItemWidget(key: ValueKey(item), item: item);
      },
      itemCount: items.length,
      findChildIndexCallback: (Key key) {
        final valueKey = key as ValueKey;
        print(valueKey);
        final index = items.indexWhere((item) => item == valueKey.value);
        print(index);
        if (index == -1) return null;
        print(index);
        return index;
      },
    );
  }
}

class ItemWidget extends StatefulWidget {
  const ItemWidget({Key? key, required this.item}) : super(key: key);

  final int item;

  @override
  State<ItemWidget> createState() => _ItemWidgetState();
}

class _ItemWidgetState extends State<ItemWidget>
    with AutomaticKeepAliveClientMixin {
  bool selected = false;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ListTile(
      selected: selected,
      title: Text('Index-${widget.item}'),
      onTap: () {
        setState(() {
          selected = !selected;
        });
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
