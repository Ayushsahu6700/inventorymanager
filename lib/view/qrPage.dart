import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:inventory_manager/models/inwardingPackageModel.dart';
import 'package:inventory_manager/view/inwardLoadDetails.dart';
import 'package:inventory_manager/widgets/nextButton.dart';
import 'package:qr_mobile_vision/qr_camera.dart';

class qrPage extends StatefulWidget {
  InwardingPackagesModel inwardingPackage;
  qrPage({required this.inwardingPackage});
  @override
  _qrPageState createState() => _qrPageState();
}

class _qrPageState extends State<qrPage> {
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
                      } else if (widget.inwardingPackage.packageId != qrid) {
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
                      } else if (widget.inwardingPackage.packageId == qrid) {
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
                          return inwardLoadDetails(
                              inwardingPackage: widget.inwardingPackage);
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
