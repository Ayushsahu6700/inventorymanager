import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_manager/cubit/markAllReadCubit.dart';
import 'package:inventory_manager/cubit/markAllReadState.dart';
import 'package:inventory_manager/cubit/markCubit.dart';
import 'package:inventory_manager/cubit/markState.dart';
import 'package:inventory_manager/cubit/notificationCubit.dart';
import 'package:inventory_manager/cubit/notificationState.dart';

import 'package:inventory_manager/models/NotificationModel.dart';

class notificationsDetail extends StatefulWidget {
  List<NotificationsModel> notification;

  notificationsDetail({required this.notification});

  @override
  _notificationsDetailState createState() => _notificationsDetailState();
}

class _notificationsDetailState extends State<notificationsDetail> {
  List<NotificationsModel> notification = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    notification = widget.notification;

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: FittedBox(child: Text("Notifications")),
        centerTitle: true,
        backgroundColor: Colors.black,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                BlocProvider.of<markAllCubit>(context).marlAll();
              },
              child: Row(
                children: [
                  Text(
                    "ClearAll",
                    style: TextStyle(
                        color: Colors.grey, fontWeight: FontWeight.bold),
                  ),
                  Icon(
                    Icons.clear,
                    color: Colors.grey,
                  )
                ],
              ),
            ),
          )
        ],
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<markAllCubit, markAllState>(
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
                BlocProvider.of<notificationCubit>(context).getNotifications();
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
          BlocListener<markCubit, markState>(
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
                BlocProvider.of<notificationCubit>(context).getNotifications();
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
                  notification = state.notifications;
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: notification.length,
                  itemBuilder: (context, i) {
                    final item = notification[i].id;
                    return notification[i].read != true
                        ? Dismissible(
                            key: Key(item.toString()),
                            onDismissed: (direction) {
                              BlocProvider.of<markCubit>(context)
                                  .mark(notification[i].id.toString());
                              setState(() {
                                notification.removeAt(i);
                              });
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                      backgroundColor: Colors.black,
                                      content: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text("Notification Deleted",
                                              style: TextStyle(
                                                  color: Color(0xfffec260),
                                                  fontSize: 18)),
                                        ],
                                      )));
                            },
                            child: Padding(
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
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        child: Text(
                                          notification[i]
                                              .title
                                              .toString()
                                              .toUpperCase(),
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w900,
                                              color: Color(0xfffec260)),
                                        ),
                                      ),
                                      Container(
                                        child: Text(
                                          notification[i].text.toString(),
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )
                        : SizedBox();
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
