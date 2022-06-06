import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_manager/cubit/approvedCubit.dart';
import 'package:inventory_manager/cubit/approvedState.dart';
import 'package:inventory_manager/cubit/notificationCubit.dart';
import 'package:inventory_manager/cubit/notificationState.dart';
import 'package:inventory_manager/models/NotificationModel.dart';
import 'package:inventory_manager/models/inwardingPackageModel.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:inventory_manager/provider/constants.dart';
import 'package:inventory_manager/widgets/shimmerWidget.dart';
import 'package:path_provider/path_provider.dart';
import 'approvedQrPage.dart';
import 'drawer.dart';
import 'package:inventory_manager/utlis/securestorage.dart';

import 'notificationsDetail.dart';

class approvedPackages extends StatefulWidget {
  final VoidCallback openDrawer;
  approvedPackages({required this.openDrawer});
  @override
  _approvedPackagesState createState() => _approvedPackagesState();
}

class _approvedPackagesState extends State<approvedPackages> {
  int franchise = 0,
      distributor = 0,
      branch = 0,
      hub = 0,
      warehouse = 0,
      deliveryBoys = 0;
  bool loadingList = true;
  List<InwardingPackagesModel> approvedList = [];
  int noOfNotifications = 0;
  List<NotificationsModel> notifications = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCount();
    BlocProvider.of<approvedCubit>(context).getList();
    BlocProvider.of<notificationCubit>(context).getNotifications();
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
        title: FittedBox(child: Text("Approved")),
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
          BlocProvider.of<approvedCubit>(context).getList();
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
        child: BlocListener<approvedCubit, approvedState>(
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
                approvedList = state.approvedPackages;
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
                        for (int i = 0; i < approvedList.length; i++)
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
                                                  approvedList[i]
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
                                                  approvedList[i]
                                                          .sourceAddress!
                                                          .city
                                                          .toString() +
                                                      "," +
                                                      approvedList[i]
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
                                                  approvedList[i]
                                                          .deliveryAddress!
                                                          .city
                                                          .toString() +
                                                      "," +
                                                      approvedList[i]
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
                                            return approvedQrPage(
                                              approvedPackage: approvedList[i],
                                              franchise: franchise,
                                              distributor: distributor,
                                              branch: branch,
                                              hub: hub,
                                              warehouse: warehouse,
                                              deliveryBoyCount: deliveryBoys,
                                            );
                                          })).then((value) {
                                            getCount();
                                            BlocProvider.of<approvedCubit>(
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
                        ),
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
