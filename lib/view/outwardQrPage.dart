import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:inventory_manager/models/inwardingPackageModel.dart';
import 'package:inventory_manager/models/outwardingPackageModel.dart';
import 'package:inventory_manager/view/inwardLoadDetails.dart';
import 'package:inventory_manager/widgets/nextButton.dart';
import 'package:qr_mobile_vision/qr_camera.dart';

import 'outwardLoad2.dart';

class outwardQrPage extends StatefulWidget {
  OutwardingPackageModel outwardingPackage;
  int franchise, distributor, branch, hub, warehouse, deliveryBoyCount;
  outwardQrPage({
    required this.outwardingPackage,
    required this.franchise,
    required this.warehouse,
    required this.branch,
    required this.distributor,
    required this.hub,
    required this.deliveryBoyCount,
  });
  @override
  _outwardQrPageState createState() => _outwardQrPageState();
}

class _outwardQrPageState extends State<outwardQrPage> {
  bool camState = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    camState = true;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    camState = false;
    super.dispose();
  }

  String qrid = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: FittedBox(child: Text("Scan QR")),
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
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                camState
                    ? Center(
                        child: SizedBox(
                          width: 270.0,
                          height: 270.0,
                          child: QrCamera(
                            onError: (context, error) => Text(
                              error.toString(),
                              style: TextStyle(color: Colors.red),
                            ),
                            qrCodeCallback: (code) {
                              HapticFeedback.selectionClick();
                              setState(() {
                                qrid = code.toString();
                              });
                            },
                            child: Container(),
                          ),
                        ),
                      )
                    : Center(child: Text("Scan to track")),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 10, bottom: 5, left: 20, right: 20),
                  child: Text("Package id is:", style: TextStyle(fontSize: 20)),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                  child: Text(
                    qrid,
                    style: TextStyle(fontSize: 20, color: Color(0xfffec260)),
                  ),
                ),
                materialButtonX(
                    loading: false,
                    message: "Verify",
                    icon: Icons.location_history,
                    onClick: () {
                      if (qrid == "") {
                        Scaffold.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.black,
                            content: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Please Scan Package Id.",
                                  style: TextStyle(
                                      color: Color(0xfffec260), fontSize: 18),
                                ),
                              ],
                            ),
                            duration: Duration(milliseconds: 1000),
                          ),
                        );
                      } else if (widget.outwardingPackage.packageId != qrid) {
                        setState(() {
                          qrid = "";
                        });
                        Scaffold.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.black,
                            content: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Wrong Package",
                                  style: TextStyle(
                                      color: Color(0xfffec260), fontSize: 18),
                                ),
                              ],
                            ),
                            duration: Duration(milliseconds: 1000),
                          ),
                        );
                      } else if (widget.outwardingPackage.packageId == qrid) {
                        Scaffold.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.black,
                            content: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Verified",
                                  style: TextStyle(
                                      color: Color(0xfffec260), fontSize: 18),
                                ),
                              ],
                            ),
                            duration: Duration(milliseconds: 1000),
                          ),
                        );
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return outwardLoad2(
                            outwardingPackage: widget.outwardingPackage,
                            franchise: widget.franchise,
                            distributor: widget.distributor,
                            branch: widget.branch,
                            hub: widget.hub,
                            warehouse: widget.warehouse,
                            deliveryBoyCount: widget.deliveryBoyCount,
                          );
                        }));
                      }
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
