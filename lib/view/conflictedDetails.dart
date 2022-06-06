import 'package:flutter/material.dart';
import 'package:inventory_manager/models/inwardingPackageModel.dart';
import 'package:inventory_manager/widgets/nextButton.dart';

class conflictedDetails extends StatefulWidget {
  InwardingPackagesModel conflictedPackage;
  conflictedDetails({required this.conflictedPackage});
  @override
  _conflictedDetailsState createState() => _conflictedDetailsState();
}

class _conflictedDetailsState extends State<conflictedDetails> {
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
                                widget.conflictedPackage.sourceAddress!.address
                                        .toString() +
                                    ", " +
                                    widget.conflictedPackage.sourceAddress!.city
                                        .toString() +
                                    ", " +
                                    widget
                                        .conflictedPackage.sourceAddress!.state
                                        .toString() +
                                    ", " +
                                    widget.conflictedPackage.sourceAddress!
                                        .pinCode
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
                                widget.conflictedPackage.deliveryAddress!
                                        .address
                                        .toString() +
                                    ", " +
                                    widget
                                        .conflictedPackage.deliveryAddress!.city
                                        .toString() +
                                    ", " +
                                    widget.conflictedPackage.deliveryAddress!
                                        .state
                                        .toString() +
                                    ", " +
                                    widget.conflictedPackage.deliveryAddress!
                                        .pinCode
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
                                " ${widget.conflictedPackage.dimensions!.length}cm X ${widget.conflictedPackage.dimensions!.width}cm X ${widget.conflictedPackage.dimensions!.height}cm",
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
                                widget.conflictedPackage.weight.toString() +
                                    "gm",
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
