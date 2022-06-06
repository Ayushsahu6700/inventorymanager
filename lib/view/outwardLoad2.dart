import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:inventory_manager/cubit/deliveryBoyCubit.dart';
import 'package:inventory_manager/cubit/deliveryBoyState.dart';
import 'package:inventory_manager/cubit/destinationState.dart';
import 'package:inventory_manager/cubit/destinationsCubit.dart';
import 'package:inventory_manager/cubit/outwardCubit.dart';
import 'package:inventory_manager/cubit/outwardForDeliveryCubit.dart';
import 'package:inventory_manager/cubit/outwardForDeliveryState.dart';
import 'package:inventory_manager/cubit/outwardState.dart';
import 'package:inventory_manager/cubit/outwardingCubit.dart';
import 'package:inventory_manager/models/branchModel.dart';
import 'package:inventory_manager/models/distributorModel.dart';
import 'package:inventory_manager/models/franchiseModel.dart';
import 'package:inventory_manager/models/hubModel.dart';
import 'package:inventory_manager/models/outwardingPackageModel.dart';
import 'package:inventory_manager/models/retailerModel.dart';
import 'package:inventory_manager/models/warehouseModel.dart';
import 'package:inventory_manager/widgets/nextButton.dart';
import 'package:inventory_manager/utlis/securestorage.dart';
import 'package:lottie/lottie.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'outwardLoad.dart';

class outwardLoad2 extends StatefulWidget {
  OutwardingPackageModel outwardingPackage;
  int franchise, distributor, branch, hub, warehouse, deliveryBoyCount;
  outwardLoad2({
    required this.outwardingPackage,
    required this.franchise,
    required this.warehouse,
    required this.branch,
    required this.distributor,
    required this.hub,
    required this.deliveryBoyCount,
  });
  @override
  _outwardLoad2State createState() => _outwardLoad2State();
}

class _outwardLoad2State extends State<outwardLoad2> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: FittedBox(child: Text("Details")),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_rounded,
              size: 40,
              color: Colors.grey,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          backgroundColor: Colors.black,
          bottom: widget.outwardingPackage.isFinalStation == true
              ? TabBar(
                  indicatorColor: Color(0xfffec260),
                  tabs: [
                    Tab(
                      text: 'Out For Delivery',
                    ),
                    Tab(
                      text: 'Internal Outwarding',
                    ),
                  ],
                )
              : TabBar(
                  indicatorColor: Color(0xfffec260),
                  tabs: [
                    Tab(
                      text: 'Internal Outwarding',
                    ),
                    Tab(
                      text: 'Out For Delivery',
                    ),
                  ],
                ),
        ),
        body: widget.outwardingPackage.isFinalStation == true
            ? TabBarView(
                children: [
                  outForDelivery(
                    deliveryBoyCount: widget.deliveryBoyCount,
                    outwardingPackage: widget.outwardingPackage,
                  ),
                  internalOutwarding(
                      outwardingPackage: widget.outwardingPackage,
                      franchise: widget.franchise,
                      warehouse: widget.warehouse,
                      branch: widget.branch,
                      distributor: widget.distributor,
                      hub: widget.hub),
                ],
              )
            : TabBarView(
                children: [
                  internalOutwarding(
                      outwardingPackage: widget.outwardingPackage,
                      franchise: widget.franchise,
                      warehouse: widget.warehouse,
                      branch: widget.branch,
                      distributor: widget.distributor,
                      hub: widget.hub),
                  outForDelivery(
                    deliveryBoyCount: widget.deliveryBoyCount,
                    outwardingPackage: widget.outwardingPackage,
                  ),
                ],
              ),
      ),
    );
  }
}

class internalOutwarding extends StatefulWidget {
  OutwardingPackageModel outwardingPackage;
  int franchise, distributor, branch, hub, warehouse;
  internalOutwarding(
      {required this.outwardingPackage,
      required this.franchise,
      required this.warehouse,
      required this.branch,
      required this.distributor,
      required this.hub});

  @override
  _internalOutwardingState createState() => _internalOutwardingState();
}

class _internalOutwardingState extends State<internalOutwarding> {
  bool getPreviousData = false;
  TextEditingController nameController = TextEditingController();
  TextEditingController vehicleController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  bool loadingList = false;
  bool loadingButton = false;
  List<String> selectionList = [];
  String selectDestinationType = "Select Destination";
  String selectedDestination = "Select";
  final _formKey3 = GlobalKey<FormState>();
  // List<String> franchiseList = [];
  // List<String> distributorList = [];
  // List<String> branchList = [];
  // List<String> hubList = [];
  // List<String> warehouseList = [];
  List<String>? franchiselist;
  List<String>? distributorlist;
  List<String>? branchlist;
  List<String>? hublist;
  List<String>? warehouselist;
  // Map<String, String> franchises = {};
  // Map<String, String> distributors = {};
  // Map<String, String> branches = {};
  // Map<String, String> hubs = {};
  // Map<String, String> warehouses = {};
  Map<String, String>? franchisemap;
  Map<String, String>? distributormap;
  Map<String, String>? branchmap;
  Map<String, String>? hubmap;
  Map<String, String>? warehousemap;
  String id = "0";
  bool validateVehicleNo(String value) {
    String pattern =
        r'^[A-Z]{2}[ -][0-9]{1,2}(?: [A-Z])?(?: [A-Z]*)? [0-9]{4}$';
    RegExp regex = new RegExp(pattern);
    return (!regex.hasMatch(value)) ? false : true;
  }

  int franchise = 0, distributor = 0, branch = 0, hub = 0, warehouse = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    franchise = widget.franchise;
    distributor = widget.distributor;
    branch = widget.branch;
    hub = widget.hub;
    warehouse = widget.warehouse;

    fetchdata();

    // BlocProvider.of<destinationCubit>(context).getList();
  }

  loadList(String type) {
    BlocProvider.of<destinationCubit>(context).getList(type);
  }

  fetchdata() async {
    franchiselist = await userSecureStorage2.getFranchises();
    distributorlist = await userSecureStorage2.getDistributors();
    branchlist = await userSecureStorage2.getBranches();

    hublist = await userSecureStorage2.getHubs();
    // final List<String>? warehouseslist =
    //     await userSecureStorage2.getWarehouses();
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    warehouselist = sharedPreferences.getStringList('warehouse');
    franchisemap = await userSecureStorage2.getFranchisesmap();
    distributormap = await userSecureStorage2.getDistributorsmap();
    branchmap = await userSecureStorage2.getBranchesmap();

    hubmap = await userSecureStorage2.getHubsmap();
    // warehousemap = await userSecureStorage2.getWarehousesmap();
    final str = sharedPreferences.getString('warehousemap');
    warehousemap = Map<String, String>.from(json.decode(str!));
  }

  store(List<String> list, String type, Map<String, String> map) async {
    print("stored");
    if (type == "franchise") {
      setState(() {
        franchisemap = map;
      });
      await userSecureStorage2.setFranchises(list);
      await userSecureStorage2.setFranchisesmap(map);
    } else if (type == "distributor") {
      setState(() {
        distributormap = map;
      });
      await userSecureStorage2.setDistributors(list);
      await userSecureStorage2.setDistributorsmap(map);
    } else if (type == "branch") {
      setState(() {
        branchmap = map;
      });
      await userSecureStorage2.setBranches(list);
      await userSecureStorage2.setBranchesmap(map);
    } else if (type == "hub") {
      setState(() {
        hubmap = map;
      });
      await userSecureStorage2.setHubs(list);
      await userSecureStorage2.setHubsmap(map);
    } else if (type == "warehouse") {
      setState(() {
        warehousemap = map;
      });
      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      sharedPreferences.setStringList('warehouse', list);
      sharedPreferences.setString('warehousemap', json.encode(map));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<destinationCubit, destinationState>(
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
            store(state.list, state.type, state.map);
            setState(() {
              selectionList = state.list;
              // franchiseList = state.franchiseList;
              // distributorList = state.distributorList;
              // branchList = state.branchList;
              //
              // hubList = state.hubList;
              // warehouseList = state.warehouseList;
              loadingList = false;
              // franchises = state.franchises;
              // distributors = state.distributors;
              // branches = state.branches;
              //
              // hubs = state.hubs;
              // warehouses = state.warehouses;
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
                    Container(
                      child: Text(
                        state.message,
                        style: TextStyle(
                          color: Color(0xfffec260),
                        ),
                      ),
                    ),
                  ],
                ),
                duration: Duration(milliseconds: 1000),
              ),
            );
          }
        },
        child: BlocListener<outwardCubit, outwardState>(
          listener: (context, state) async {
            // TODO: implement listener
            if (state.code == "00") {
              showDialog(
                  context: context,
                  builder: (context) {
                    Future.delayed(Duration(seconds: 5), () {
                      Navigator.pop(context);
                    });
                    return AlertDialog(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.close,
                              size: 30,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Lottie.asset("assets/success.json", fit: BoxFit.fill),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            'Outwarded',
                            style: TextStyle(fontSize: 30),
                          ),
                        ],
                      ),
                    );
                  });

              setState(() {
                loadingButton = false;
              });
              await userSecureStorage.setPhoneno(contactController.text);
              await userSecureStorage.setUsername(nameController.text);
              await userSecureStorage.setVehicleno(vehicleController.text);
              await userSecureStorage.setDestinationType(selectDestinationType);
              await userSecureStorage.setDestination(selectedDestination);
              Navigator.popUntil(context, (route) => route.isFirst);
            } else {
              setState(() {
                loadingButton = false;
                nameController.clear();
                vehicleController.clear();
                contactController.clear();

                selectedDestination = "Select";
                selectDestinationType = "Select Destination";
              });
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Colors.black,
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: Text(
                          state.message,
                          style: TextStyle(color: Color(0xfffec260)),
                        ),
                      ),
                    ],
                  ),
                  duration: Duration(milliseconds: 1000),
                ),
              );
            }
          },
          child: SafeArea(
            child: loadingList
                ? Center(child: CircularProgressIndicator())
                : Center(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20),
                        child: Form(
                          key: _formKey3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Checkbox(
                                        value: getPreviousData,
                                        activeColor: Color(0xfffec260),
                                        onChanged: (value) async {
                                          final contactNo =
                                              await userSecureStorage
                                                  .getPhoneno();
                                          final name = await userSecureStorage
                                              .getUsername();
                                          final vehicleNo =
                                              await userSecureStorage
                                                  .getVehicleno();
                                          final destionType =
                                              await userSecureStorage
                                                  .getDestinationType();
                                          final destination =
                                              await userSecureStorage
                                                  .getDestination();
                                          setState(() {
                                            this.getPreviousData = value!;
                                            if (getPreviousData == true) {
                                              if (vehicleNo == null) {
                                                Scaffold.of(context)
                                                    .showSnackBar(
                                                  SnackBar(
                                                    backgroundColor:
                                                        Colors.black,
                                                    content: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          "No Previous Data. Start again.",
                                                          style: TextStyle(
                                                              color: Color(
                                                                  0xfffec260),
                                                              fontSize: 18),
                                                        ),
                                                      ],
                                                    ),
                                                    duration: Duration(
                                                        milliseconds: 1000),
                                                  ),
                                                );
                                              } else {
                                                if (vehicleNo != null)
                                                  vehicleController.text =
                                                      vehicleNo.toString();
                                                if (contactNo != null)
                                                  contactController.text =
                                                      contactNo.toString();
                                                if (name != null)
                                                  nameController.text =
                                                      name.toString();
                                                if (destionType != null) {
                                                  selectDestinationType =
                                                      destionType;
                                                  if (selectDestinationType ==
                                                      "franchise") {
                                                    print(franchiselist!.length
                                                        .toString());
                                                    print(warehouse.toString());
                                                    if (franchiselist == null ||
                                                        (franchiselist!.length -
                                                                1) !=
                                                            franchise) {
                                                      loadList("franchise");
                                                    } else {
                                                      print("autofr");
                                                      setState(() {
                                                        selectionList =
                                                            franchiselist!;
                                                      });
                                                    }
                                                  } else if (selectDestinationType ==
                                                      "distributor") {
                                                    if (distributorlist ==
                                                            null ||
                                                        (distributorlist!
                                                                    .length -
                                                                1) !=
                                                            distributor) {
                                                      loadList("distributor");
                                                    } else {
                                                      print("autodr");
                                                      setState(() {
                                                        selectionList =
                                                            distributorlist!;
                                                      });
                                                    }
                                                  } else if (selectDestinationType ==
                                                      "branch") {
                                                    if (branchlist == null ||
                                                        (branchlist!.length -
                                                                1) !=
                                                            branch) {
                                                      loadList("branch");
                                                    } else {
                                                      print("autobr");
                                                      setState(() {
                                                        selectionList =
                                                            branchlist!;
                                                      });
                                                    }
                                                  } else if (selectDestinationType ==
                                                      "hub") {
                                                    if (hublist == null ||
                                                        (hublist!.length - 1) !=
                                                            hub) {
                                                      loadList("hub");
                                                    } else {
                                                      print("autohb");
                                                      setState(() {
                                                        selectionList =
                                                            hublist!;
                                                      });
                                                    }
                                                  } else if (selectDestinationType ==
                                                      "warehouse") {
                                                    if (warehouselist == null ||
                                                        (warehouselist!.length -
                                                                1) !=
                                                            warehouse) {
                                                      loadList("warehouse");
                                                    } else {
                                                      print("autowr");
                                                      setState(() {
                                                        selectionList =
                                                            warehouselist!;
                                                      });
                                                    }
                                                  }
                                                  // if (selectDestinationType ==
                                                  //     "franchise")
                                                  //   selectionList =
                                                  //       franchiseList;
                                                  // else if (selectDestinationType ==
                                                  //     "distributer")
                                                  //   selectionList =
                                                  //       distributorList;
                                                  // else if (selectDestinationType ==
                                                  //     "branch")
                                                  //   selectionList =
                                                  //       branchList;
                                                  // else if (selectDestinationType ==
                                                  //     "hub")
                                                  //   selectionList = hubList;
                                                  // else if (selectDestinationType ==
                                                  //     "warehouse")
                                                  //   selectionList =
                                                  //       warehouseList;
                                                }
                                                if (destination != null) {
                                                  selectedDestination =
                                                      destination;
                                                  if (selectDestinationType ==
                                                      "franchise")
                                                    id = franchisemap![
                                                            selectedDestination]
                                                        .toString();
                                                  else if (selectDestinationType ==
                                                      "distributer")
                                                    id = distributormap![
                                                            selectedDestination]
                                                        .toString();
                                                  else if (selectDestinationType ==
                                                      "branch")
                                                    id = branchmap![
                                                            selectedDestination]
                                                        .toString();
                                                  else if (selectDestinationType ==
                                                      "hub")
                                                    id = hubmap![
                                                            selectedDestination]
                                                        .toString();
                                                  else if (selectDestinationType ==
                                                      "warehouse")
                                                    id = warehousemap![
                                                            selectedDestination]
                                                        .toString();
                                                }
                                              }
                                            } else if (getPreviousData ==
                                                false) {
                                              nameController.clear();
                                              vehicleController.clear();
                                              contactController.clear();
                                              selectedDestination = "Select";
                                              selectDestinationType =
                                                  "Select Destination";
                                            }
                                          });
                                        }),
                                    Text("Get previous data"),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 20),
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        height: 60,
                                        child: DropdownButton(
                                            isExpanded: true,
                                            underline: SizedBox(
                                              child: Divider(
                                                thickness: 2,
                                                color: Color(0xfffec260),
                                              ),
                                            ),
                                            items: [
                                              "Select Destination",
                                              "franchise",
                                              "distributor",
                                              "branch",
                                              "hub",
                                              "warehouse"
                                            ].map((val) {
                                              return DropdownMenuItem<String>(
                                                value: val,
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 10),
                                                  child: Text(val),
                                                ),
                                              );
                                            }).toList(),
                                            icon: Icon(
                                              // Add this

                                              Icons.arrow_drop_down, // Add this
                                              color: Color(0xfffec260),
                                              size: 30, // Add this
                                            ),
                                            value: selectDestinationType,
                                            onChanged: (String? newvalue) {
                                              setState(() {
                                                selectedDestination = "Select";
                                                selectDestinationType =
                                                    newvalue.toString();
                                                // if (newvalue == "franchise")
                                                //   selectionList =
                                                //       franchiseList;
                                                // else if (newvalue ==
                                                //     "distributer")
                                                //   selectionList =
                                                //       distributorList;
                                                // else if (newvalue == "branch")
                                                //   selectionList = branchList;
                                                // else if (newvalue == "hub")
                                                //   selectionList = hubList;
                                                // else if (newvalue ==
                                                //     "warehouse")
                                                //   selectionList =
                                                //       warehouseList;
                                                if (newvalue == "franchise") {
                                                  print(franchiselist!.length
                                                      .toString());
                                                  print(warehouse.toString());
                                                  if (franchiselist == null ||
                                                      (franchiselist!.length -
                                                              1) !=
                                                          franchise) {
                                                    loadList("franchise");
                                                  } else {
                                                    print("autofr");
                                                    setState(() {
                                                      selectionList =
                                                          franchiselist!;
                                                    });
                                                  }
                                                } else if (newvalue ==
                                                    "distributor") {
                                                  if (distributorlist == null ||
                                                      (distributorlist!.length -
                                                              1) !=
                                                          distributor) {
                                                    loadList("distributor");
                                                  } else {
                                                    print("autodr");
                                                    setState(() {
                                                      selectionList =
                                                          distributorlist!;
                                                    });
                                                  }
                                                } else if (newvalue ==
                                                    "branch") {
                                                  if (branchlist == null ||
                                                      (branchlist!.length -
                                                              1) !=
                                                          branch) {
                                                    loadList("branch");
                                                  } else {
                                                    print("autobr");
                                                    setState(() {
                                                      selectionList =
                                                          branchlist!;
                                                    });
                                                  }
                                                } else if (newvalue == "hub") {
                                                  if (hublist == null ||
                                                      (hublist!.length - 1) !=
                                                          hub) {
                                                    loadList("hub");
                                                  } else {
                                                    print("autohb");
                                                    setState(() {
                                                      selectionList = hublist!;
                                                    });
                                                  }
                                                } else if (newvalue ==
                                                    "warehouse") {
                                                  if (warehouselist == null ||
                                                      (warehouselist!.length -
                                                              1) !=
                                                          warehouse) {
                                                    loadList("warehouse");
                                                  } else {
                                                    print("autowr");
                                                    setState(() {
                                                      selectionList =
                                                          warehouselist!;
                                                    });
                                                  }
                                                }
                                              });
                                            }),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              selectDestinationType != "Select Destination"
                                  ? (Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5, horizontal: 20),
                                      child: Text(
                                          "Select ${selectDestinationType} :",
                                          style: TextStyle(
                                              color: Color(0xfffec260),
                                              fontSize: 18)),
                                    ))
                                  : SizedBox(),
                              selectDestinationType != "Select Destination"
                                  ? Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 20),
                                      child: Container(
                                        height: 60,
                                        child: DropdownButton(
                                            isExpanded: true,
                                            underline: SizedBox(
                                              child: Divider(
                                                thickness: 2,
                                                color: Color(0xfffec260),
                                              ),
                                            ),
                                            items: selectionList.map((val) {
                                              return DropdownMenuItem<String>(
                                                value: val,
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 10),
                                                  child: Text(val),
                                                ),
                                              );
                                            }).toList(),
                                            icon: Icon(
                                              // Add this

                                              Icons.arrow_drop_down, // Add this
                                              color: Color(0xfffec260),
                                              size: 30, // Add this
                                            ),
                                            value: selectedDestination,
                                            onChanged: (String? newvalue) {
                                              setState(() {
                                                selectedDestination =
                                                    newvalue.toString();
                                                print(selectedDestination);
                                                if (selectDestinationType ==
                                                    "franchise")
                                                  id = franchisemap![
                                                          selectedDestination]
                                                      .toString();
                                                else if (selectDestinationType ==
                                                    "distributor")
                                                  id = distributormap![
                                                          selectedDestination]
                                                      .toString();
                                                else if (selectDestinationType ==
                                                    "branch")
                                                  id = branchmap![
                                                          selectedDestination]
                                                      .toString();
                                                else if (selectDestinationType ==
                                                    "hub")
                                                  id = hubmap![
                                                          selectedDestination]
                                                      .toString();
                                                else if (selectDestinationType ==
                                                    "warehouse")
                                                  id = warehousemap![
                                                          selectedDestination]
                                                      .toString();
                                              });
                                            }),
                                      ),
                                    )
                                  : SizedBox(),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 20),
                                child: TextFormField(
                                  textAlign: TextAlign.start,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      nameController.clear();
                                      return "Enter Driver Name";
                                    } else {
                                      return null;
                                    }
                                  },
                                  controller: nameController,
                                  decoration: InputDecoration(
                                    hintText: "Driver Name",
                                    errorStyle: TextStyle(
                                        color: Colors.redAccent,
                                        fontSize: 15.0),
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 10.0, horizontal: 20.0),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 20),
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  textAlign: TextAlign.start,
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(10),
                                  ],
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      contactController.clear();
                                      return "Enter Contact No";
                                    } else if (value.length < 10) {
                                      contactController.clear();
                                      return "contact no of 10 digit";
                                    } else {
                                      return null;
                                    }
                                  },
                                  controller: contactController,
                                  decoration: InputDecoration(
                                    hintText: "Driver contact no",
                                    errorStyle: TextStyle(
                                        color: Colors.redAccent,
                                        fontSize: 15.0),
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 10.0, horizontal: 20.0),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 20),
                                child: TextFormField(
                                  textCapitalization:
                                      TextCapitalization.characters,
                                  textAlign: TextAlign.start,
                                  validator: (value) {
                                    if (validateVehicleNo(
                                            vehicleController.text) ==
                                        false) {
                                      return "Enter Valid Vehicle No";
                                    } else
                                      return null;
                                  },
                                  controller: vehicleController,
                                  decoration: InputDecoration(
                                    hintText: "Vehicle no",
                                    errorStyle: TextStyle(
                                        color: Colors.redAccent,
                                        fontSize: 15.0),
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 10.0, horizontal: 20.0),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Center(
                                child: materialButtonX(
                                    message: "Outward",
                                    icon: Icons.outbox,
                                    onClick: () {
                                      print(id + "---------------------------");
                                      print(widget.outwardingPackage.packageId
                                          .toString());
                                      if (selectDestinationType ==
                                          "Select Destination type") {
                                        Scaffold.of(context).showSnackBar(
                                          SnackBar(
                                            backgroundColor: Colors.black,
                                            content: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "Please Select Destination Type",
                                                  style: TextStyle(
                                                      color: Color(0xfffec260),
                                                      fontSize: 18),
                                                ),
                                              ],
                                            ),
                                            duration:
                                                Duration(milliseconds: 1000),
                                          ),
                                        );
                                      } else if (selectedDestination ==
                                          "Select") {
                                        Scaffold.of(context).showSnackBar(
                                          SnackBar(
                                            backgroundColor: Colors.black,
                                            content: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "Please Select Destination",
                                                  style: TextStyle(
                                                      color: Color(0xfffec260),
                                                      fontSize: 18),
                                                ),
                                              ],
                                            ),
                                            duration:
                                                Duration(milliseconds: 1000),
                                          ),
                                        );
                                      } else if (_formKey3.currentState!
                                          .validate()) {
                                        print('validated');
                                        setState(() {
                                          loadingButton = true;
                                        });
                                        BlocProvider.of<outwardCubit>(context)
                                            .outward(
                                          widget.outwardingPackage.packageId
                                              .toString(),
                                          id,
                                          selectDestinationType,
                                          nameController.text,
                                          vehicleController.text,
                                          int.parse(contactController.text),
                                        );
                                      }
                                    },
                                    loading: loadingButton),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}

class outForDelivery extends StatefulWidget {
  int deliveryBoyCount;
  OutwardingPackageModel outwardingPackage;
  outForDelivery(
      {required this.deliveryBoyCount, required this.outwardingPackage});
  @override
  _outForDeliveryState createState() => _outForDeliveryState();
}

class _outForDeliveryState extends State<outForDelivery> {
  bool loadingList = false;
  bool loadingButton = false;
  bool getPreviousData = false;
  String deliveryBoy = "Select Delivery boy";
  final _formKey4 = GlobalKey<FormState>();
  List<String>? selectionList = [];
  Map<String, String>? selectionMap = {};
  TextEditingController vehicleController = TextEditingController();
  bool validateVehicleNo(String value) {
    String pattern =
        r'^[A-Z]{2}[ -][0-9]{1,2}(?: [A-Z])?(?: [A-Z]*)? [0-9]{4}$';
    RegExp regex = new RegExp(pattern);
    return (!regex.hasMatch(value)) ? false : true;
  }

  fetchdata() async {
    selectionList = await userSecureStorage2.getDeliveryBoy();

    selectionMap = await userSecureStorage2.getDeliveryBoymap();
    setState(() {});
    if (selectionList!.length <= 1 ||
        (selectionList!.length - 1) != widget.deliveryBoyCount) {
      print(selectionList!.length.toString());
      setState(() {
        loadingList = true;
      });

      BlocProvider.of<deliveryBoyCubit>(context).getList();
    }
  }

  store(List<String> list, Map<String, String> map) async {
    print("stored");
    await userSecureStorage2.setDeliveryBoy(list);
    await userSecureStorage2.setDeliveryBoymap(map);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchdata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<deliveryBoyCubit, deliveryBoyState>(
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
            store(state.list, state.map);
            setState(() {
              selectionList = state.list;
              selectionMap = state.map;
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
                      style: TextStyle(color: Color(0xfffec260), fontSize: 18),
                    ),
                  ],
                ),
                duration: Duration(milliseconds: 1000),
              ),
            );
          }
        },
        child: BlocListener<outwardForDeliveryCubit, outwardForDeliveryState>(
          listener: (context, state) async {
            // TODO: implement listener
            if (state.code == "00") {
              showDialog(
                  context: context,
                  builder: (context) {
                    Future.delayed(Duration(seconds: 5), () {
                      Navigator.pop(context);
                    });
                    return AlertDialog(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.close,
                              size: 30,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Lottie.asset("assets/success.json", fit: BoxFit.fill),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            'Outwarded',
                            style: TextStyle(fontSize: 30),
                          ),
                        ],
                      ),
                    );
                  });

              setState(() {
                loadingButton = false;
              });
              await userSecureStorage.setDeliveryBoyname(deliveryBoy);
              await userSecureStorage
                  .setDeliveryVehicleno(vehicleController.text);
              // await userSecureStorage.setVehicleno(vehicleController.text);
              // await userSecureStorage.setDestinationType(selectDestinationType);
              // await userSecureStorage.setDestination(selectedDestination);
              Navigator.popUntil(context, (route) => route.isFirst);
            } else {
              setState(() {
                loadingButton = false;
                deliveryBoy = "Select Delivery boy";
                vehicleController.clear();
                // contactController.clear();
                //
                // selectedDestination = "Select";
                // selectDestinationType = "Select Destination";
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
          child: SafeArea(
            child: loadingList
                ? Center(child: CircularProgressIndicator())
                : Center(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20),
                        child: Form(
                          key: _formKey4,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Checkbox(
                                        value: getPreviousData,
                                        activeColor: Color(0xfffec260),
                                        onChanged: (value) async {
                                          final deliveryBoyName =
                                              await userSecureStorage
                                                  .getDeliveryBoyname();
                                          final vehicleNo =
                                              await userSecureStorage
                                                  .getDeliveryVehicleno();
                                          setState(() {
                                            this.getPreviousData = value!;
                                            if (getPreviousData == true) {
                                              if (vehicleNo == null) {
                                                Scaffold.of(context)
                                                    .showSnackBar(
                                                  SnackBar(
                                                    backgroundColor:
                                                        Colors.black,
                                                    content: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          "No Previous Data. Start again.",
                                                          style: TextStyle(
                                                              color: Color(
                                                                  0xfffec260),
                                                              fontSize: 18),
                                                        ),
                                                      ],
                                                    ),
                                                    duration: Duration(
                                                        milliseconds: 1000),
                                                  ),
                                                );
                                              } else {
                                                if (vehicleNo != null)
                                                  vehicleController.text =
                                                      vehicleNo.toString();

                                                if (deliveryBoyName != null)
                                                  deliveryBoy = deliveryBoyName;
                                              }
                                            } else if (getPreviousData ==
                                                false) {
                                              deliveryBoy =
                                                  "Select Delivery boy";
                                              vehicleController.clear();
                                            }
                                          });
                                        }),
                                    Text("Get previous data"),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 20),
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        height: 60,
                                        child: DropdownButton(
                                            isExpanded: true,
                                            underline: SizedBox(
                                              child: Divider(
                                                thickness: 2,
                                                color: Color(0xfffec260),
                                              ),
                                            ),
                                            items: selectionList!.map((val) {
                                              return DropdownMenuItem<String>(
                                                value: val,
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 10),
                                                  child: Text(val),
                                                ),
                                              );
                                            }).toList(),
                                            icon: Icon(
                                              // Add this

                                              Icons.arrow_drop_down, // Add this
                                              color: Color(0xfffec260),
                                              size: 30, // Add this
                                            ),
                                            value: deliveryBoy,
                                            onChanged: (String? newvalue) {
                                              setState(() {
                                                deliveryBoy =
                                                    newvalue.toString();
                                              });
                                            }),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              deliveryBoy != "Select Delivery boy"
                                  ? Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5, horizontal: 20),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Contact No : ",
                                            style: TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.w900,
                                                color: Color(0xfffec260)),
                                          ),
                                          Text(
                                            selectionMap![deliveryBoy]
                                                .toString(),
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 17,
                                                color: Colors.white),
                                          ),
                                        ],
                                      ),
                                    )
                                  : SizedBox(),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 20),
                                child: TextFormField(
                                  textCapitalization:
                                      TextCapitalization.characters,
                                  textAlign: TextAlign.start,
                                  validator: (value) {
                                    if (validateVehicleNo(
                                            vehicleController.text) ==
                                        false) {
                                      return "Enter Valid Vehicle No";
                                    } else
                                      return null;
                                  },
                                  controller: vehicleController,
                                  decoration: InputDecoration(
                                    hintText: "Vehicle no",
                                    errorStyle: TextStyle(
                                        color: Colors.redAccent,
                                        fontSize: 15.0),
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 10.0, horizontal: 20.0),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Center(
                                child: materialButtonX(
                                    message: "Outward",
                                    icon: Icons.outbox,
                                    onClick: () {
                                      if (deliveryBoy ==
                                          "Select Delivery boy") {
                                        Scaffold.of(context).showSnackBar(
                                          SnackBar(
                                            backgroundColor: Colors.black,
                                            content: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "Please Select Delivery boy",
                                                  style: TextStyle(
                                                      color: Color(0xfffec260),
                                                      fontSize: 18),
                                                ),
                                              ],
                                            ),
                                            duration:
                                                Duration(milliseconds: 1000),
                                          ),
                                        );
                                      } else if (_formKey4.currentState!
                                          .validate()) {
                                        print('validated');
                                        setState(() {
                                          loadingButton = true;
                                        });
                                        BlocProvider.of<
                                                    outwardForDeliveryCubit>(
                                                context)
                                            .outward(
                                                widget
                                                    .outwardingPackage.packageId
                                                    .toString(),
                                                deliveryBoy,
                                                vehicleController.text);
                                      }
                                    },
                                    loading: loadingButton),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
