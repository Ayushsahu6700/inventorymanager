import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_manager/cubit/inwardingPackageCubit.dart';
import 'package:inventory_manager/cubit/inwardingPackageState.dart';
import 'package:inventory_manager/cubit/notificationCubit.dart';
import 'package:inventory_manager/cubit/notificationState.dart';
import 'package:inventory_manager/models/NotificationModel.dart';
import 'package:inventory_manager/models/inwardingPackageModel.dart';
import 'package:inventory_manager/view/inwardLoadDetails.dart';
import 'package:inventory_manager/view/qrPage.dart';
import 'package:inventory_manager/widgets/shimmerWidget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'drawer.dart';
import 'notificationsDetail.dart';

class inwardLoad extends StatefulWidget {
  final VoidCallback openDrawer;
  inwardLoad({required this.openDrawer});
  @override
  _inwardLoadState createState() => _inwardLoadState();
}

class _inwardLoadState extends State<inwardLoad> {
  bool loadingList = true;
  List<InwardingPackagesModel> inwardingList = [];
  int noOfNotifications = 0;
  List<NotificationsModel> notifications = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<notificationCubit>(context).getNotifications();
    BlocProvider.of<inwardingPackageCubit>(context).getList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: drawerMenuWidget(
          onClicked: widget.openDrawer,
        ),
        title: FittedBox(child: Text("Inward Load")),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return notificationsDetail(
                    notification: notifications,
                  );
                })).then((value) {
                  BlocProvider.of<notificationCubit>(context)
                      .getNotifications();
                  setState(() {
                    // loadingList = true;
                  });
                });
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (noOfNotifications.toString() != "0")
                    Container(
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadiusDirectional.all(
                                Radius.circular(50))),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 1),
                          child: Text(
                            noOfNotifications.toString(),
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        )),
                  Icon(Icons.notifications)
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.small(
        child: Icon(Icons.refresh),
        onPressed: () {
          BlocProvider.of<inwardingPackageCubit>(context).getList();
          setState(() {
            // loadingList = true;
          });
        },
      ),
      body: BlocListener<notificationCubit, notificationState>(
        listener: (context, state) {
          // TODO: implement listener
          if (state.code == "00") {
            Scaffold.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.black,
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Success",
                      style: TextStyle(color: Color(0xfffec260), fontSize: 18),
                    ),
                  ],
                ),
                duration: Duration(milliseconds: 1000),
              ),
            );

            setState(() {
              notifications = state.notifications;
              int x = 0;
              state.notifications.forEach((element) {
                if (element.read == false) x++;
              });
              noOfNotifications = x;
            });
          } else {
            Scaffold.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.black,
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      state.message,
                      style: TextStyle(color: Color(0xfffec260), fontSize: 18),
                    ),
                  ],
                ),
                duration: Duration(milliseconds: 1000),
              ),
            );
          }
        },
        child: BlocListener<inwardingPackageCubit, inwardingPackageState>(
          listener: (context, state) {
            // TODO: implement listener
            if (state.code == "00") {
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Colors.black,
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Success",
                        style:
                            TextStyle(color: Color(0xfffec260), fontSize: 18),
                      ),
                    ],
                  ),
                  duration: Duration(milliseconds: 1000),
                ),
              );
              setState(() {
                inwardingList = state.inwardingPackages;
                loadingList = false;
              });
            } else {
              setState(() {
                loadingList = false;
              });
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Colors.black,
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        state.message,
                        style:
                            TextStyle(color: Color(0xfffec260), fontSize: 18),
                      ),
                    ],
                  ),
                  duration: Duration(milliseconds: 1000),
                ),
              );
            }
          },
          child: loadingList
              ? shimmerBox()
              : RawScrollbar(
                  thumbColor: Color(0xfffec260),
                  thickness: 3,
                  isAlwaysShown: true,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        for (int i = 0; i < inwardingList.length; i++)
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 3),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5),
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
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Pckage ID : ",
                                                style: TextStyle(
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.w900,
                                                    color: Colors.black),
                                              ),
                                              Expanded(
                                                child: Text(
                                                  inwardingList[i]
                                                      .packageId
                                                      .toString(),
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 17,
                                                      color: Colors.black),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Source : ",
                                                style: TextStyle(
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.w900,
                                                    color: Colors.black),
                                              ),
                                              Expanded(
                                                child: Text(
                                                  inwardingList[i]
                                                          .sourceAddress!
                                                          .city
                                                          .toString() +
                                                      "," +
                                                      inwardingList[i]
                                                          .sourceAddress!
                                                          .state
                                                          .toString(),
                                                  style: TextStyle(
                                                      fontSize: 17,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Colors.black),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Destination : ",
                                                style: TextStyle(
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.w900,
                                                    color: Colors.black),
                                              ),
                                              Expanded(
                                                child: Text(
                                                  inwardingList[i]
                                                          .deliveryAddress!
                                                          .city
                                                          .toString() +
                                                      "," +
                                                      inwardingList[i]
                                                          .deliveryAddress!
                                                          .state
                                                          .toString(),
                                                  style: TextStyle(
                                                      fontSize: 17,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Colors.black),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 5),
                                      child: ElevatedButton(
                                        onPressed: () {
                                          Navigator.push(context,
                                              MaterialPageRoute(
                                                  builder: (context) {
                                            return qrPage(
                                                inwardingPackage:
                                                    inwardingList[i]);
                                          })).then((value) {
                                            BlocProvider.of<
                                                        inwardingPackageCubit>(
                                                    context)
                                                .getList();
                                            setState(() {
                                              // loadingList = true;
                                            });
                                          });
                                        },
                                        child:
                                            FittedBox(child: Text("Details")),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 50,
                          child: Center(child: Text("Nothing More to load")),
                        )
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
