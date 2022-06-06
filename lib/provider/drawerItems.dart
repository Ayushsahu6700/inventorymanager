import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'drawerItem.dart';

class drawerItems {
  static const home = drawerItem(title: 'Home', icon: FontAwesomeIcons.home);
  static const explore = drawerItem(title: 'Explore', icon: Icons.explore);
  static const favorites = drawerItem(title: 'Favorites', icon: Icons.favorite);
  static const message = drawerItem(title: 'Meassage', icon: Icons.mail);
  static const profile =
      drawerItem(title: 'Profile', icon: FontAwesomeIcons.userAlt);
  static const settings = drawerItem(title: 'Settings', icon: Icons.settings);

  static final List<drawerItem> all = [
    home,
    explore,
    favorites,
    message,
    settings,
  ];
}
