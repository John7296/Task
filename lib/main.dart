import 'package:flutter/material.dart';
import 'package:sample1/views/category_view.dart';
import 'package:sample1/views/home_view.dart';
import 'package:sample1/views/post_view.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primarySwatch: Colors.grey
    ),
    home: Homepage(),
  ));
}
class Homepage extends StatefulWidget {
  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List<Widget> datas = [
    HomeView(),
    CategoryView(),
    PostView(),
  ];

  int selesctedindex = 0;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: IndexedStack(
          index: selesctedindex,
          children: datas,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.black26,
        unselectedItemColor: Colors.black,
        currentIndex: selesctedindex,
        onTap: selectedfromDatas,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "home"),
          BottomNavigationBarItem(icon: Icon(Icons.category), label: "category"),
          BottomNavigationBarItem(
              icon: Icon(Icons.details), label: "details"),
        ],
      ),
    );
  }

  void selectedfromDatas(int index) {
    setState(() {
      selesctedindex = index;

    });
  }
}
