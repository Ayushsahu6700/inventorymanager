import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'drawer.dart';
import 'homeScreen.dart';

class mainPage extends StatefulWidget {
  @override
  _mainPageState createState() => _mainPageState();
}

class _mainPageState extends State<mainPage> {
  late double xOffset;
  late double yOffset;
  late double scaleFactor;
  bool isDragging = false;
  late bool isDrawerOpen = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    closeDrawer();
  }

  void openDrawer() => setState(() {
        xOffset = 230;
        yOffset = 150;
        scaleFactor = 0.6;
        isDrawerOpen = true;
      });
  void closeDrawer() => setState(() {
        xOffset = 0;
        yOffset = 0;
        scaleFactor = 1;
        isDrawerOpen = false;
      });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color.fromRGBO(21, 30, 61, 1),
      body: Stack(
        children: [
          buildDrawer(),
          buildMainPage(),
        ],
      ),
    );
  }

  Widget buildDrawer() =>
      SafeArea(child: Container(width: xOffset, child: drawerWidget()));
  Widget buildMainPage() {
    return WillPopScope(
      onWillPop: () async {
        if (isDrawerOpen) {
          closeDrawer();
          return false;
        } else {
          return true;
        }
      },
      child: GestureDetector(
        onTap: closeDrawer,
        // onHorizontalDragStart: (details) => isDragging = true,
        // onHorizontalDragUpdate: (details) {
        //   if (!isDragging) return;
        //   const delta = 1;
        //   if (details.delta.dx > delta) {
        //     openDrawer();
        //   } else if (details.delta.dx < -delta) {
        //     closeDrawer();
        //   }
        //   isDragging = false;
        // },
        child: AnimatedContainer(
            duration: Duration(milliseconds: 250),
            transform: Matrix4.translationValues(xOffset, yOffset, 0)
              ..scale(scaleFactor),
            child: AbsorbPointer(
                absorbing: isDrawerOpen,
                child: Container(
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(isDrawerOpen ? 20 : 0),
                      border: Border.all(
                        color: MediaQuery.of(context).platformBrightness ==
                                Brightness.dark
                            ? Colors.grey
                            : Colors.black12,
                        width: isDrawerOpen ? 5 : 0,
                      ),
                    ),
                    child: ClipRRect(
                        borderRadius:
                            BorderRadius.circular(isDrawerOpen ? 20 : 0),
                        child: homeScreen(openDrawer: openDrawer))))),
      ),
    );
  }
}

class homePage extends StatefulWidget {
  final VoidCallback openDrawer;
  homePage({required this.openDrawer});
  @override
  _homePageState createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: drawerMenuWidget(
          onClicked: widget.openDrawer,
        ),
        title: Text("Inventory Manager"),
        centerTitle: true,
      ),
      // drawer: MainDrawer(),
      body: Center(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Container(
                      height: MediaQuery.of(context).size.height / 4,
                      child: Image.asset(
                        "assets/inventoryLogo.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Container(
                              height: MediaQuery.of(context).size.height / 5,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  //background color of box

                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 5.0, // soften the shadow
                                    spreadRadius: 2.0, //extend the shadow
                                    offset: Offset(
                                      3.0, // Move to right 10  horizontally
                                      3.0, // Move to bottom 10 Vertically
                                    ),
                                  )
                                ],
                              ),
                              child: Column(
                                children: [
                                  Expanded(
                                    child: ClipRRect(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Image.asset("assets/inward.png"),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    "Inward Load",
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Container(
                              height: MediaQuery.of(context).size.height / 5,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  //background color of box

                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 5.0, // soften the shadow
                                    spreadRadius: 2.0, //extend the shadow
                                    offset: Offset(
                                      3.0, // Move to right 10  horizontally
                                      3.0, // Move to bottom 10 Vertically
                                    ),
                                  )
                                ],
                              ),
                              child: Column(
                                children: [
                                  Expanded(
                                    child: ClipRRect(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child:
                                            Image.asset("assets/outward.png"),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    "Outward Load",
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Container(
                              height: MediaQuery.of(context).size.height / 5,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  //background color of box

                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 5.0, // soften the shadow
                                    spreadRadius: 2.0, //extend the shadow
                                    offset: Offset(
                                      3.0, // Move to right 10  horizontally
                                      3.0, // Move to bottom 10 Vertically
                                    ),
                                  )
                                ],
                              ),
                              child: Column(
                                children: [
                                  Expanded(
                                    child: ClipRRect(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Image.asset("assets/inward.png"),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    "Stock",
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Container(
                              height: MediaQuery.of(context).size.height / 5,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  //background color of box

                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 5.0, // soften the shadow
                                    spreadRadius: 2.0, //extend the shadow
                                    offset: Offset(
                                      3.0, // Move to right 10  horizontally
                                      3.0, // Move to bottom 10 Vertically
                                    ),
                                  )
                                ],
                              ),
                              child: Column(
                                children: [
                                  Expanded(
                                    child: ClipRRect(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Image.asset("assets/inward.png"),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    "Qr Scanner",
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildImage(String image, int index) => Container(
        decoration: BoxDecoration(
          color: Colors.amber,
          borderRadius: BorderRadius.circular(7),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(7),
          child: Image.asset(
            image,
            fit: BoxFit.fill,
          ),
        ),
      );
}
