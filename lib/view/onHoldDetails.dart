import 'package:flutter/material.dart';
import 'package:inventory_manager/models/inwardingPackageModel.dart';
import 'package:inventory_manager/widgets/nextButton.dart';

class onHoldDetails extends StatefulWidget {
  InwardingPackagesModel onHoldPackage;
  onHoldDetails({required this.onHoldPackage});
  @override
  _onHoldDetailsState createState() => _onHoldDetailsState();
}

class _onHoldDetailsState extends State<onHoldDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      ),
      body: SafeArea(
        child: RawScrollbar(
          thumbColor: Color(0xfffec260),
          thickness: 3,
          isAlwaysShown: true,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Source         : ",
                              style: TextStyle(
                                  color: Color(0xfffec260), fontSize: 18)),
                          Expanded(
                            child: Text(
                                widget.onHoldPackage.sourceAddress!.address
                                        .toString() +
                                    ", " +
                                    widget.onHoldPackage.sourceAddress!.city
                                        .toString() +
                                    ", " +
                                    widget.onHoldPackage.sourceAddress!.state
                                        .toString() +
                                    ", " +
                                    widget.onHoldPackage.sourceAddress!.pinCode
                                        .toString()
                                        .toString(),
                                style: TextStyle(fontSize: 18)),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Destination : ",
                              style: TextStyle(
                                  color: Color(0xfffec260), fontSize: 18)),
                          Expanded(
                            child: Text(
                                widget.onHoldPackage.deliveryAddress!.address
                                        .toString() +
                                    ", " +
                                    widget.onHoldPackage.deliveryAddress!.city
                                        .toString() +
                                    ", " +
                                    widget.onHoldPackage.deliveryAddress!.state
                                        .toString() +
                                    ", " +
                                    widget
                                        .onHoldPackage.deliveryAddress!.pinCode
                                        .toString(),
                                style: TextStyle(fontSize: 18)),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Dimensions:",
                              style: TextStyle(
                                  color: Color(0xfffec260), fontSize: 18)),
                          Expanded(
                            child: Text(
                                " ${widget.onHoldPackage.dimensions!.length}cm X ${widget.onHoldPackage.dimensions!.width}cm X ${widget.onHoldPackage.dimensions!.height}cm",
                                style: TextStyle(fontSize: 18)),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Weight         : ",
                              style: TextStyle(
                                  color: Color(0xfffec260), fontSize: 18)),
                          Expanded(
                            child: Text(
                                widget.onHoldPackage.weight.toString() + "gm",
                                style: TextStyle(fontSize: 18)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
