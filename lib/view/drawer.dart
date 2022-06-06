import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:inventory_manager/cubit/currentUserCubit.dart';
import 'package:inventory_manager/cubit/currentUserState.dart';
import 'package:inventory_manager/cubit/inwardingPackageCubit.dart';
import 'package:inventory_manager/cubit/inwardingPackageState.dart';
import 'package:inventory_manager/cubit/onHoldCubit.dart';
import 'package:inventory_manager/cubit/onHoldState.dart';
import 'package:inventory_manager/models/currentUserModel.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'package:inventory_manager/provider/drawerItems.dart';
import 'package:inventory_manager/view/profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'loginPage.dart';

class drawerWidget extends StatefulWidget {
  @override
  _drawerWidgetState createState() => _drawerWidgetState();
}

class _drawerWidgetState extends State<drawerWidget> {
  String user = "", phone = "", email = "";
  String photo = "", aadhar = "", document = "";

  @override
  void initState() {
    super.initState();
    greetText = greetingMessage();
    init();
  }

  init() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? name = await pref.getString('name');
    String? pho = await pref.getString('photo');
    String? mail = await pref.getString('demail');
    String? phoneNo = await pref.getString('phone');
    String? adhar = await pref.getString('aadhar');
    String? doc = await pref.getString('document');
    if (name == null) {
      BlocProvider.of<currentUserCubit>(context).getUser();
    } else {
      print("auto");
      setState(() {
        user = name.toString();
        photo = pho.toString();
        email = mail.toString();
        phone = phoneNo.toString();
        aadhar = adhar.toString();
        document = doc.toString();
      });
    }
  }

  String greetText = "";
  String greetingMessage() {
    var timeNow = DateTime.now().hour;
    if (timeNow < 12) {
      return 'Good Morning.';
    } else if ((timeNow >= 12) && (timeNow < 16)) {
      return 'Good Afternoon.';
    } else if ((timeNow >= 16) && (timeNow < 20)) {
      return 'Good Evening.';
    } else {
      return 'Good Night.';
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<inwardingPackageCubit, inwardingPackageState>(
          listener: (context, state) {
            // TODO: implement listener
            if (state.code == "00") {
            } else {
              if (state.message == "Invalid Access Token") {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return loginPage();
                }));
                showDialog(
                    context: context,
                    builder: (context) {
                      Future.delayed(Duration(seconds: 3), () {
                        Navigator.pop(context);
                      });
                      return AlertDialog(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Logged Out"),
                          ],
                        ),
                      );
                    });
              }
            }
          },
        ),
        BlocListener<currentUserCubit, currentUserState>(
          listener: (context, state) async {
            // TODO: implement listener
            SharedPreferences pref = await SharedPreferences.getInstance();
            if (state.code == "00") {
              setState(() {
                user = state.user!.name.toString();
                photo = state.user!.profilePicDocumentId.toString();
                email = state.user!.email.toString();
                phone = state.user!.phoneNo.toString();
                aadhar = state.user!.aadharDocumentId.toString();
                document = state.user!.contractDocumentId.toString();
              });
              pref.setString(
                  'photo', state.user!.profilePicDocumentId.toString());
              pref.setString('name', state.user!.name.toString());
              pref.setString('demail', state.user!.email.toString());
              pref.setString('phone', state.user!.phoneNo.toString());
              pref.setString('aadhar', state.user!.aadharDocumentId.toString());
              pref.setString(
                  'document', state.user!.contractDocumentId.toString());
            } else {}
          },
        ),
      ],
      child: Stack(children: [
        Container(
          padding: EdgeInsets.fromLTRB(16, 32, 16, 0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(color: Colors.black54, blurRadius: 10.0),
                      ],
                      borderRadius: BorderRadius.circular(65.0)),
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: photo == ""
                        ? CircleAvatar(
                            radius: 50,
                            backgroundImage: AssetImage("assets/2.png"),
                          )
                        : CircleAvatar(
                            radius: 50,
                            backgroundImage: NetworkImage(
                              "https://api.sfcmanagement.in/api/docs/download/${photo}",
                            ),
                          ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 8.0, left: 26.0, bottom: 10),
                  child: Text(
                    "Welcome ${user},",
                    style: TextStyle(
                      fontSize: 25,
                      fontFamily: 'League',
                      color: Color(0xfffec260),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: Text(
                    greetText,
                    style: TextStyle(
                        fontSize: 20, fontFamily: 'League', color: Colors.grey),
                  ),
                ),
                buildDrawerItems(context),
                ListTile(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                  leading: Icon(FontAwesomeIcons.userAlt),
                  title: Text("Profile"),
                  onTap: () async {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return profile(
                          email: email,
                          phoneNo: phone,
                          name: user,
                          aadhar: aadhar,
                          document: document);
                    })).then((value) {
                      BlocProvider.of<currentUserCubit>(context).getUser();
                      setState(() {});
                    });
                  },
                ),
                ListTile(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                  leading: Icon(Icons.logout),
                  title: Text("Logout"),
                  onTap: () async {
                    final SharedPreferences sharedPreferences =
                        await SharedPreferences.getInstance();
                    sharedPreferences.remove('email');
                    sharedPreferences.remove('name');
                    sharedPreferences.remove('photo');
                    sharedPreferences.remove('demail');
                    sharedPreferences.remove('phone');
                    sharedPreferences.remove('aadhar');
                    sharedPreferences.remove('document');
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return loginPage();
                    }));
                  },
                ),
              ],
            ),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [],
        ),
      ]),
    );
  }

  Widget buildDrawerItems(BuildContext context) => Column(
        children: drawerItems.all
            .map((item) => ListTile(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                  leading: Icon(
                    item.icon,
                  ),
                  title: Text(
                    item.title,
                  ),
                  onTap: () {},
                ))
            .toList(),
      );
}

class drawerMenuWidget extends StatelessWidget {
  final VoidCallback onClicked;
  drawerMenuWidget({required this.onClicked});
  @override
  Widget build(BuildContext context) => IconButton(
        icon: FaIcon(FontAwesomeIcons.alignLeft),
        onPressed: onClicked,
      );
}
