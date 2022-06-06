import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:inventory_manager/cubit/notificationCubit.dart';
import 'package:inventory_manager/cubit/setTokenCubit.dart';
import 'package:inventory_manager/view/approvedPackages.dart';
import 'package:inventory_manager/view/conflictedPackages.dart';
import 'package:inventory_manager/view/inwardLoad.dart';
import 'package:inventory_manager/view/outwardLoad.dart';
import 'package:inventory_manager/view/onHold.dart';

import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    // 'This channel is used for important notifications.', // description
    importance: Importance.high,
    playSound: true);
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('A bg message just showed up :  ${message.messageId}');
}

final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

class homeScreen extends StatefulWidget {
  final VoidCallback openDrawer;
  homeScreen({required this.openDrawer});
  @override
  _homeScreenState createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    init();
  }

  init() async {
    await Firebase.initializeApp();
    token = await _firebaseMessaging.getToken();
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    BlocProvider.of<setTokenCubit>(context).setToken(token!);
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        BlocProvider.of<notificationCubit>(context)
            .getNotifications();
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                color: Colors.blue,
                playSound: true,
                icon: '@mipmap/ic_launcher',
              ),
            ));
      }
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        BlocProvider.of<notificationCubit>(context)
            .getNotifications();
        showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: Text(notification.title.toString()),
                content: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text(notification.body.toString())],
                  ),
                ),
              );
            });
      }
    });
    // showNotification();
  }

  void showNotification() {
    flutterLocalNotificationsPlugin.show(
        0,
        "Test",
        "token$token",
        NotificationDetails(
            android: AndroidNotificationDetails(channel.id, channel.name,
                importance: Importance.high,
                color: Colors.blue,
                playSound: true,
                icon: '@mipmap/ic_launcher')));
  }

  String? token = "";

  PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);
  List<Widget> _buildScreens() {
    return [
      inwardLoad(
        openDrawer: widget.openDrawer,
      ),
      outwardLoad(
        openDrawer: widget.openDrawer,
      ),
      onHold(
        openDrawer: widget.openDrawer,
      ),
      conflictedPackages(openDrawer: widget.openDrawer),
      approvedPackages(openDrawer: widget.openDrawer),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    final color = MediaQuery.of(context).platformBrightness == Brightness.dark
        ? Colors.black
        : Colors.white;
    return [
      PersistentBottomNavBarItem(
        icon: Icon(Icons.input),
        title: ("Inward Load"),
        activeColorPrimary: color == Colors.white ? Colors.black : Colors.white,
        inactiveColorPrimary: color,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.outbox),
        title: ("Outward Load"),
        activeColorPrimary: color == Colors.white ? Colors.black : Colors.white,
        inactiveColorPrimary: color,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.pause_fill),
        title: ("On Hold"),
        activeColorPrimary: color == Colors.white ? Colors.black : Colors.white,
        inactiveColorPrimary: color,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(FontAwesomeIcons.cross),
        title: ("Conflicted"),
        activeColorPrimary: color == Colors.white ? Colors.black : Colors.white,
        inactiveColorPrimary: color,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.check_circle_outline_outlined),
        title: "Approved",
        activeColorPrimary: color == Colors.white ? Colors.black : Colors.white,
        inactiveColorPrimary: color,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,

      backgroundColor: Color(0xfffec260), // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset:
          true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardShows:
          true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: ThemeData.dark().primaryColor,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: ItemAnimationProperties(
        // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: ScreenTransitionAnimation(
        // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),

      navBarStyle:
          NavBarStyle.style3, // Choose the nav bar style with this property.
    );
  }
}
