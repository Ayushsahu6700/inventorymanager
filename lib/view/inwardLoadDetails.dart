import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_manager/cubit/inwardCubit.dart';
import 'package:inventory_manager/cubit/inwardState.dart';
import 'package:inventory_manager/cubit/inwardingPackageCubit.dart';
import 'package:inventory_manager/cubit/toApproveCubit.dart';
import 'package:inventory_manager/cubit/toApproveState.dart';
import 'package:inventory_manager/models/inwardingPackageModel.dart';
import 'package:inventory_manager/view/qrPage.dart';
import 'package:inventory_manager/widgets/nextButton.dart';
import 'package:lottie/lottie.dart';

class inwardLoadDetails extends StatefulWidget {
  InwardingPackagesModel inwardingPackage;
  inwardLoadDetails({required this.inwardingPackage});
  @override
  _inwardLoadDetailsState createState() => _inwardLoadDetailsState();
}

class _inwardLoadDetailsState extends State<inwardLoadDetails> {
  String button = "Inward";
  bool loading = false;
  final _formKey2 = GlobalKey<FormState>();
  String weightunit = "gm",
      heightunit = "cm",
      widthunit = "cm",
      lengthunit = "cm";
  double weight = 0.0, height = 0.0, length = 0.0, width = 0.0;
  bool dimensionsconfirm = true;
  bool weightconfirm = true;
  TextEditingController weightController = TextEditingController();
  TextEditingController lengthController = TextEditingController();
  TextEditingController widthController = TextEditingController();
  TextEditingController heigthController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    weightController.text = widget.inwardingPackage.weight.toString();
    heigthController.text =
        widget.inwardingPackage.dimensions!.height.toString();
    lengthController.text =
        widget.inwardingPackage.dimensions!.length.toString();
    widthController.text = widget.inwardingPackage.dimensions!.width.toString();
  }

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
      body: MultiBlocListener(
        listeners: [
          BlocListener<toApproveCubit, toApproveState>(
              listener: (context, state) {
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
                          Lottie.asset("assets/send.json", fit: BoxFit.fill),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            'Send For Approval',
                            style: TextStyle(fontSize: 30),
                          ),
                        ],
                      ),
                    );
                  });
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Colors.black,
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Send For Approval",
                        style:
                            TextStyle(color: Color(0xfffec260), fontSize: 18),
                      ),
                    ],
                  ),
                  duration: Duration(milliseconds: 1000),
                ),
              );
              setState(() {
                loading = false;
              });
              Navigator.popUntil(context, (route) => route.isFirst);
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
              setState(() {
                loading = false;
              });
            }
          }),
          BlocListener<inwardCubit, inwardState>(listener: (context, state) {
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
                            'Inwarded',
                            style: TextStyle(fontSize: 30),
                          ),
                        ],
                      ),
                    );
                  });
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Colors.black,
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Inwarded",
                        style:
                            TextStyle(color: Color(0xfffec260), fontSize: 18),
                      ),
                    ],
                  ),
                  duration: Duration(milliseconds: 1000),
                ),
              );
              setState(() {
                loading = false;
              });
              Navigator.popUntil(context, (route) => route.isFirst);
              BlocProvider.of<inwardingPackageCubit>(context).getList();
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
              setState(() {
                loading = false;
              });
            }
          }),
        ],
        child: SafeArea(
          child: RawScrollbar(
            thumbColor: Color(0xfffec260),
            thickness: 3,
            isAlwaysShown: true,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: _formKey2,
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
                                  widget.inwardingPackage.sourceAddress!
                                          .address
                                          .toString() +
                                      ", " +
                                      widget
                                          .inwardingPackage.sourceAddress!.city
                                          .toString() +
                                      ", " +
                                      widget
                                          .inwardingPackage.sourceAddress!.state
                                          .toString() +
                                      ", " +
                                      widget.inwardingPackage.sourceAddress!
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
                                  widget
                                          .inwardingPackage.deliveryAddress!.address
                                          .toString() +
                                      ", " +
                                      widget.inwardingPackage.deliveryAddress!
                                          .city
                                          .toString() +
                                      ", " +
                                      widget.inwardingPackage.deliveryAddress!
                                          .state
                                          .toString() +
                                      ", " +
                                      widget.inwardingPackage.deliveryAddress!
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
                                  " ${widget.inwardingPackage.dimensions!.length}cm X ${widget.inwardingPackage.dimensions!.width}cm X ${widget.inwardingPackage.dimensions!.height}cm",
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
                            Text("Confirm Dimensions",
                                style: TextStyle(
                                    color: Color(0xfffec260), fontSize: 18)),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            ListTile(
                              title: const Text('Yes'),
                              leading: Radio<bool>(
                                activeColor: Color(0xfffec260),
                                value: true,
                                groupValue: dimensionsconfirm,
                                onChanged: (bool? value) {
                                  setState(() {
                                    dimensionsconfirm = value!;

                                    if (weightconfirm) button = "Inward";
                                  });
                                },
                              ),
                            ),
                            ListTile(
                              title: const Text('No'),
                              leading: Radio<bool>(
                                activeColor: Color(0xfffec260),
                                value: false,
                                groupValue: dimensionsconfirm,
                                onChanged: (bool? value) {
                                  setState(() {
                                    dimensionsconfirm = value!;
                                    button = "Approve";
                                    ;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      dimensionsconfirm
                          ? SizedBox()
                          : Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 20),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 5,
                                        child: Container(
                                          child: TextFormField(
                                            keyboardType: TextInputType.number,
                                            textAlign: TextAlign.start,
                                            controller: lengthController,
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return "Enter the Length";
                                              } else {
                                                return null;
                                              }
                                            },
                                            decoration: InputDecoration(
                                              hintText: 'Length',
                                              errorStyle: TextStyle(
                                                  color: Colors.redAccent,
                                                  fontSize: 15.0),
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      vertical: 10.0,
                                                      horizontal: 20.0),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                          child: Center(
                                            child: DropdownButton(
                                                underline: SizedBox(),
                                                items: [
                                                  "in",
                                                  "cm",
                                                  "ft",
                                                ].map((val) {
                                                  return DropdownMenuItem<
                                                      String>(
                                                    value: val,
                                                    child: Text(val),
                                                  );
                                                }).toList(),
                                                value: lengthunit,
                                                onChanged: (String? newvalue) {
                                                  setState(() {
                                                    lengthunit =
                                                        newvalue.toString();
                                                  });
                                                }),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 20),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 5,
                                        child: Container(
                                          child: TextFormField(
                                            keyboardType: TextInputType.number,
                                            controller: widthController,
                                            textAlign: TextAlign.start,
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return "Enter the width";
                                              } else {
                                                return null;
                                              }
                                            },
                                            decoration: InputDecoration(
                                              hintText: 'Width',
                                              errorStyle: TextStyle(
                                                  color: Colors.redAccent,
                                                  fontSize: 15.0),
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      vertical: 10.0,
                                                      horizontal: 20.0),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                          width: 65,
                                          child: Center(
                                            child: DropdownButton(
                                                underline: SizedBox(),
                                                items: [
                                                  "in",
                                                  "cm",
                                                  "ft",
                                                ].map((val) {
                                                  return DropdownMenuItem<
                                                      String>(
                                                    value: val,
                                                    child: Text(val),
                                                  );
                                                }).toList(),
                                                value: widthunit,
                                                onChanged: (String? newval) {
                                                  setState(() {
                                                    widthunit =
                                                        newval.toString();
                                                  });
                                                }),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 20),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 5,
                                        child: Container(
                                          child: TextFormField(
                                            keyboardType: TextInputType.number,
                                            controller: heigthController,
                                            textAlign: TextAlign.start,
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return "Enter the height";
                                              } else {
                                                return null;
                                              }
                                            },
                                            decoration: InputDecoration(
                                              hintText: 'Height',
                                              errorStyle: TextStyle(
                                                  color: Colors.redAccent,
                                                  fontSize: 15.0),
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      vertical: 10.0,
                                                      horizontal: 20.0),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                          child: Center(
                                            child: DropdownButton(
                                                underline: SizedBox(),
                                                items: [
                                                  "in",
                                                  "cm",
                                                  "ft",
                                                ].map((val) {
                                                  return DropdownMenuItem<
                                                      String>(
                                                    value: val,
                                                    child: Text(val),
                                                  );
                                                }).toList(),
                                                value: heightunit,
                                                onChanged: (String? newval) {
                                                  setState(() {
                                                    heightunit =
                                                        newval.toString();
                                                  });
                                                }),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
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
                                  widget.inwardingPackage.weight.toString() +
                                      "gm",
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
                            Text("Confirm Weight",
                                style: TextStyle(
                                    color: Color(0xfffec260), fontSize: 18)),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Column(
                          children: [
                            ListTile(
                              title: const Text('Yes'),
                              leading: Radio<bool>(
                                activeColor: Color(0xfffec260),
                                value: true,
                                groupValue: weightconfirm,
                                onChanged: (bool? value) {
                                  setState(() {
                                    weightconfirm = value!;
                                    if (dimensionsconfirm) button = "Inward";
                                  });
                                },
                              ),
                            ),
                            ListTile(
                              title: const Text('No'),
                              leading: Radio<bool>(
                                activeColor: Color(0xfffec260),
                                value: false,
                                groupValue: weightconfirm,
                                onChanged: (bool? value) {
                                  setState(() {
                                    weightconfirm = value!;
                                    button = "Approve";
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      weightconfirm
                          ? SizedBox()
                          : Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 20),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 5,
                                    child: Container(
                                      child: TextFormField(
                                        keyboardType: TextInputType.number,
                                        controller: weightController,
                                        textAlign: TextAlign.start,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return "Enter the weight";
                                          } else {
                                            return null;
                                          }
                                        },
                                        decoration: InputDecoration(
                                          hintText: 'Weight',
                                          errorStyle: TextStyle(
                                              color: Colors.redAccent,
                                              fontSize: 15.0),
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: 10.0, horizontal: 20.0),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      child: Center(
                                        child: DropdownButton(
                                            underline: SizedBox(),
                                            items: ["kg", "gm"].map((val) {
                                              return DropdownMenuItem<String>(
                                                value: val,
                                                child: Text(val),
                                              );
                                            }).toList(),
                                            value: weightunit,
                                            onChanged: (String? newvalue) {
                                              setState(() {
                                                weightunit =
                                                    newvalue.toString();
                                              });
                                            }),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 20),
                        child: materialButtonX(
                            message: button,
                            icon: Icons.input,
                            loading: loading,
                            onClick: () {
                              setState(() {
                                if (_formKey2.currentState!.validate()) {
                                  print("validated");
                                  loading = true;

                                  if (weightunit == "kg") {
                                    weight =
                                        double.parse(weightController.text);
                                    weight = weight * 1000.0;
                                  } else {
                                    weight =
                                        double.parse(weightController.text);
                                  }
                                  if (lengthunit == "in") {
                                    length =
                                        double.parse(lengthController.text);
                                    length = length * 2.54;
                                  } else if (lengthunit == 'ft') {
                                    length =
                                        double.parse(lengthController.text);
                                    length = length * 30.58;
                                  } else {
                                    length =
                                        double.parse(lengthController.text);
                                  }
                                  if (widthunit == "in") {
                                    width = double.parse(widthController.text);
                                    width = width * 2.54;
                                  } else if (widthunit == 'ft') {
                                    width = double.parse(widthController.text);
                                    width = width * 30.58;
                                  } else {
                                    width = double.parse(widthController.text);
                                  }
                                  if (heightunit == "in") {
                                    height =
                                        double.parse(heigthController.text);
                                    height = height * 2.54;
                                  } else if (heightunit == 'ft') {
                                    height =
                                        double.parse(heigthController.text);
                                    height = height * 30.58;
                                  } else {
                                    height =
                                        double.parse(heigthController.text);
                                  }
                                  button == "Approve"
                                      ? BlocProvider.of<toApproveCubit>(context)
                                          .approve(
                                              widget.inwardingPackage.packageId
                                                  .toString(),
                                              weight,
                                              length,
                                              width,
                                              height)
                                      : BlocProvider.of<inwardCubit>(context)
                                          .inward(
                                              widget.inwardingPackage.packageId
                                                  .toString(),
                                              weight,
                                              length,
                                              width,
                                              height);
                                }

                                // Calculate();
                              });
                            }),
                      ),
                    ],
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
