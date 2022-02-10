import 'package:flutter/material.dart';
import 'package:weather_app/pages/details_page.dart';
import 'package:weather_app/pages/home_empty_page.dart';
import 'package:weather_app/pages/home_page.dart';
import 'package:weather_app/pages/map.dart';

void main() => runApp(const MenuPage());

class MenuPage extends StatelessWidget {
  const MenuPage({Key? key}) : super(key: key);

  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: _title,
      home: MyStatefulWidget(),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    DetailsPage(),
    MapClickPage()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.cyan.shade900,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.public),
            label: 'Earth',
          ),
          BottomNavigationBarItem(
            icon: Image(
              image: AssetImage('assets/images/planeta.png'),
              width: 20,
            ),
            label: 'Planet',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_city),
            label: 'City',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        onTap: _onItemTapped,
      ),
    );
  }
}
