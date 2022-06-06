import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_manager/cubit/notificationCubit.dart';
import 'package:inventory_manager/cubit/notificationState.dart';
import 'package:inventory_manager/cubit/outwardingCubit.dart';
import 'package:inventory_manager/cubit/outwardingState.dart';
import 'package:inventory_manager/models/NotificationModel.dart';
import 'package:inventory_manager/models/outwardingPackageModel.dart';
import 'package:inventory_manager/provider/constants.dart';
import 'package:inventory_manager/view/outwardLoad2.dart';
import 'package:inventory_manager/view/outwardQrPage.dart';
import 'package:inventory_manager/widgets/shimmerWidget.dart';
import 'package:inventory_manager/utlis/securestorage.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:path_provider/path_provider.dart';
import 'drawer.dart';
import 'notificationsDetail.dart';

class outwardLoad extends StatefulWidget {
  final VoidCallback openDrawer;
  outwardLoad({required this.openDrawer});
  @override
  _outwardLoadState createState() => _outwardLoadState();
}

class _outwardLoadState extends State<outwardLoad> {
  bool loadingList = true;
  bool loadingFilter = true;
  String filter = "All cities";
  TextEditingController filterController = TextEditingController();
  List<OutwardingPackageModel> outwardingList = [];
  List<String> filterList = [];
  int noOfNotifications = 0;
  List<NotificationsModel> notifications = [];
  int franchise = 0,
      distributor = 0,
      branch = 0,
      hub = 0,
      warehouse = 0,
      deliveryBoys = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCount();
    BlocProvider.of<notificationCubit>(context).getNotifications();
    BlocProvider.of<outwardingPackageCubit>(context).getList();
  }

  getCount() async {
    final dio = Dio();
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;

    var cj = PersistCookieJar(
        ignoreExpires: true, storage: FileStorage(appDocPath + "/.cookies/"));
    dio.interceptors.add(CookieManager(cj));
    // final dio = Dio();
    // var cookieJar = CookieJar();
    // dio.interceptors.add(CookieManager(cookieJar));
    // final email = await userSecureStorage2.getEmail();
    // final password = await userSecureStorage2.getPaassword();
    // await dio.request(
    //   "https://api.sfcmanagement.in/api/inventoryManager/auth/login",
    //   data: {"email": email, "password": password},
    //   options: Options(
    //     method: 'POST',
    //     headers: {'content-Type': 'application/json'},
    //   ),
    // );
    Response<Map> responsecount = await dio.request(
      countApi,
      options: Options(
        method: 'GET',
        headers: {'content-Type': 'application/json'},
      ),
    );
    Map? responsecountBody1 = responsecount.data;
    print(responsecountBody1.toString());
    franchise = responsecountBody1!["stats"]["franchises"];
    distributor = responsecountBody1["stats"]["distributors"];
    branch = responsecountBody1["stats"]["branches"];
    hub = responsecountBody1["stats"]["hubs"];
    warehouse = responsecountBody1["stats"]["warehouses"];
    deliveryBoys = responsecountBody1["stats"]["deliveryBoys"];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: drawerMenuWidget(
          onClicked: widget.openDrawer,
        ),
        title: Text("Outward Load"),
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
          getCount();
          BlocProvider.of<outwardingPackageCubit>(context).getList();
          setState(() {
            // loadingList = true;
          });
        },
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<outwardingPackageCubit, outwardingPackageState>(
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
                  outwardingList = state.outwardingPackages;
                  filterList = state.filterList;
                  loadingList = false;
                  loadingFilter = false;
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
          ),
          BlocListener<notificationCubit, notificationState>(
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
          ),
        ],
        child: Stack(
          children: [
            loadingList
                ? shimmerBox()
                : RawScrollbar(
                    thumbColor: Color(0xfffec260),
                    thickness: 3,
                    isAlwaysShown: true,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SizedBox(
                            height: 68,
                          ),
                          for (int i = 0; i < outwardingList.length; i++)
                            if (filter == "All cities")
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
                                                        fontWeight:
                                                            FontWeight.w900,
                                                        color: Colors.black),
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                      outwardingList[i]
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
                                                        fontWeight:
                                                            FontWeight.w900,
                                                        color: Colors.black),
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                      outwardingList[i]
                                                              .sourceAddress!
                                                              .city
                                                              .toString() +
                                                          "," +
                                                          outwardingList[i]
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
                                                        fontWeight:
                                                            FontWeight.w900,
                                                        color: Colors.black),
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                      outwardingList[i]
                                                              .deliveryAddress!
                                                              .city
                                                              .toString() +
                                                          "," +
                                                          outwardingList[i]
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
                                          padding:
                                              const EdgeInsets.only(left: 5),
                                          child: ElevatedButton(
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) {
                                                  return outwardQrPage(
                                                    outwardingPackage:
                                                        outwardingList[i],
                                                    franchise: franchise,
                                                    distributor: distributor,
                                                    branch: branch,
                                                    hub: hub,
                                                    warehouse: warehouse,
                                                    deliveryBoyCount:
                                                        deliveryBoys,
                                                  );
                                                }),
                                              ).then((value) {
                                                getCount();
                                                BlocProvider.of<
                                                            outwardingPackageCubit>(
                                                        context)
                                                    .getList();
                                                setState(() {
                                                  // loadingList = true;
                                                });
                                              });
                                            },
                                            child: Text("Outward"),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            else if (filter.toLowerCase() ==
                                outwardingList[i]
                                    .deliveryAddress!
                                    .city
                                    .toString()
                                    .toLowerCase())
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
                                                        fontWeight:
                                                            FontWeight.w900,
                                                        color: Colors.black),
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                      outwardingList[i]
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
                                                        fontWeight:
                                                            FontWeight.w900,
                                                        color: Colors.black),
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                      outwardingList[i]
                                                              .sourceAddress!
                                                              .city
                                                              .toString() +
                                                          "," +
                                                          outwardingList[i]
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
                                                        fontWeight:
                                                            FontWeight.w900,
                                                        color: Colors.black),
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                      outwardingList[i]
                                                              .deliveryAddress!
                                                              .city
                                                              .toString() +
                                                          "," +
                                                          outwardingList[i]
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
                                          padding:
                                              const EdgeInsets.only(left: 5),
                                          child: ElevatedButton(
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) {
                                                  return outwardQrPage(
                                                    outwardingPackage:
                                                        outwardingList[i],
                                                    franchise: franchise,
                                                    distributor: distributor,
                                                    branch: branch,
                                                    hub: hub,
                                                    warehouse: warehouse,
                                                    deliveryBoyCount:
                                                        deliveryBoys,
                                                  );
                                                }),
                                              ).then((value) {
                                                getCount();
                                                BlocProvider.of<
                                                            outwardingPackageCubit>(
                                                        context)
                                                    .getList();
                                                setState(() {
                                                  // loadingList = true;
                                                });
                                              });
                                            },
                                            child: FittedBox(
                                                child: Text("Outward")),
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
                          ),
                        ],
                      ),
                    ),
                  ),
            loadingFilter
                ? SizedBox()
                : Container(
                    color: Colors.black,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      child: Container(
                        height: 50,
                        color: Colors.black,
                        child: DropdownButton(
                            isExpanded: true,
                            underline: SizedBox(
                              child: Divider(
                                thickness: 2,
                                color: Color(0xfffec260),
                              ),
                            ),
                            items: filterList.map((val) {
                              return DropdownMenuItem<String>(
                                value: val,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Text(val,
                                      style: TextStyle(color: Colors.grey)),
                                ),
                              );
                            }).toList(),
                            icon: Icon(
                              // Add this

                              Icons.arrow_drop_down, // Add this
                              color: Color(0xfffec260),
                              size: 30, // Add this
                            ),
                            value: filter,
                            onChanged: (String? newvalue) {
                              setState(() {
                                loadingList = true;
                                filter = newvalue.toString();
                                BlocProvider.of<outwardingPackageCubit>(context)
                                    .getList();
                              });
                            }),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
