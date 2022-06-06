import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

import 'package:image_picker/image_picker.dart';
import 'package:inventory_manager/cubit/updateProfileCubit.dart';
import 'package:inventory_manager/cubit/updateProfileState.dart';
import 'package:inventory_manager/provider/constants.dart';
import 'package:inventory_manager/widgets/nextButton.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

var dio = Dio();

class profile extends StatefulWidget {
  String email, name, phoneNo, aadhar, document;
  profile(
      {required this.email,
      required this.phoneNo,
      required this.name,
      required this.aadhar,
      required this.document});
  @override
  _profileState createState() => _profileState();
}

class _profileState extends State<profile> {
  bool load1 = false, load2 = false;
  File? image, document;
  final _formKey = GlobalKey<FormState>();
  String name = "", email = "", phone = "";
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  bool _passwordVisible1 = false;
  bool _passwordVisible2 = false;
  Future pickImageGallery1() async {
    try {
      final image = await ImagePicker()
          .pickImage(source: ImageSource.gallery, imageQuality: 15);
      if (image == null) return;
      final imageTemporary = File(image.path);
      setState(() {
        print((imageTemporary.lengthSync()).toString());
        this.image = imageTemporary;
      });
    } on PlatformException catch (e) {
      // TODO
      print("failed to pick image:$e");
    }
  }

  Future pickImageCamera1() async {
    try {
      final image = await ImagePicker()
          .pickImage(source: ImageSource.camera, imageQuality: 15);
      if (image == null) return;
      final imageTemporary = File(image.path);
      setState(() {
        print((imageTemporary.lengthSync() / 1024).toString());
        this.image = imageTemporary;
      });
    } on PlatformException catch (e) {
      // TODO
      print("failed to pick image:$e");
    }
  }

  Future pickImageGallery2() async {
    try {
      final image = await ImagePicker()
          .pickImage(source: ImageSource.gallery, imageQuality: 15);
      if (image == null) return;
      final imageTemporary = File(image.path);
      setState(() {
        this.document = imageTemporary;
      });
    } on PlatformException catch (e) {
      // TODO
      print("failed to pick image:$e");
    }
  }

  Future pickImageCamera2() async {
    try {
      final image = await ImagePicker()
          .pickImage(source: ImageSource.camera, imageQuality: 15);
      if (image == null) return;
      final imageTemporary = File(image.path);
      setState(() {
        print((imageTemporary.lengthSync() / 1024).toString());
        this.document = imageTemporary;
      });
    } on PlatformException catch (e) {
      // TODO
      print("failed to pick image:$e");
    }
  }

  Future download2(String url, String savePath) async {
    var status = await Permission.storage.request();
    if (status.isGranted) {
      var response = await Dio()
          .get(url, options: Options(responseType: ResponseType.bytes));
      final result = await ImageGallerySaver.saveImage(
          Uint8List.fromList(response.data),
          quality: 60,
          name: "aadhar");
      print(result);
      setState(() {
        load2 = false;
      });
    }
  }

  Future download1(String url, String savePath) async {
    var status = await Permission.storage.request();
    if (status.isGranted) {
      var response = await Dio()
          .get(url, options: Options(responseType: ResponseType.bytes));
      final result = await ImageGallerySaver.saveImage(
          Uint8List.fromList(response.data),
          quality: 60,
          name: "licence");
      print(result);
      setState(() {
        load1 = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: BlocListener<updateProfileCubit, updateProfileState>(
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
                      style: TextStyle(
                        color: Color(0xfffec260),
                      ),
                    ),
                  ],
                ),
                duration: Duration(milliseconds: 1000),
              ),
            );

            Navigator.pop(context);
          } else {
            Scaffold.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.black,
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      state.message,
                      style: TextStyle(
                        color: Color(0xfffec260),
                      ),
                    ),
                  ],
                ),
                duration: Duration(milliseconds: 1000),
              ),
            );
          }
        },
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Text("Update Name:",
                      style: TextStyle(
                          color: Color(0xfffec260),
                          fontWeight: FontWeight.bold,
                          fontSize: 20)),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    textAlign: TextAlign.start,
                    controller: nameController,
                    onChanged: (value) {
                      setState(() {});
                    },
                    decoration: kTextFieldDecoration2.copyWith(
                        prefixIcon: Icon(Icons.person), hintText: widget.name),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Text("Update Email:",
                      style: TextStyle(
                          color: Color(0xfffec260),
                          fontWeight: FontWeight.bold,
                          fontSize: 20)),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    textAlign: TextAlign.start,
                    controller: emailController,
                    onChanged: (value) {
                      setState(() {});
                    },
                    decoration: kTextFieldDecoration2.copyWith(
                        prefixIcon: Icon(Icons.email), hintText: widget.email),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Text("Update Phone no:",
                      style: TextStyle(
                          color: Color(0xfffec260),
                          fontWeight: FontWeight.bold,
                          fontSize: 20)),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.start,
                    controller: phoneController,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(10),
                    ],
                    onChanged: (value) {
                      setState(() {});
                    },
                    decoration: kTextFieldDecoration2.copyWith(
                        prefixIcon: Icon(Icons.phone),
                        hintText: widget.phoneNo.toString()),
                  ),
                ),
                // Padding(
                //   padding:
                //       const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                //   child: Text("Aadhar :",
                //       style: TextStyle(
                //           color: Color(0xfffec260),
                //           fontWeight: FontWeight.bold,
                //           fontSize: 20)),
                // ),
                // Center(
                //   child: Image.network(
                //     "https://api.sfcmanagement.in/api/docs/download/${widget.aadhar}",
                //     height: 200,
                //     fit: BoxFit.fitHeight,
                //   ),
                // ),
                // Center(
                //   child: ElevatedButton(
                //       onPressed: () async {
                //         var tempDir = await getTemporaryDirectory();
                //         String fullPath = tempDir.path + "/aadhar2.pdf'";
                //         print('full path ${fullPath}');
                //         setState(() {
                //           load2 = true;
                //         });
                //         download2(
                //             "https://api.sfcmanagement.in/api/docs/download/${widget.aadhar}",
                //             fullPath);
                //       },
                //       child: Row(
                //         mainAxisSize: MainAxisSize.min,
                //         children: [
                //           Text("Download"),
                //           SizedBox(
                //             width: 5,
                //           ),
                //           load2 == false
                //               ? Icon(Icons.download)
                //               : Container(
                //                   height: 15,
                //                   width: 15,
                //                   child: CircularProgressIndicator(
                //                     color: Colors.black,
                //                     strokeWidth: 3,
                //                   ),
                //                 ),
                //         ],
                //       )),
                // ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Text("Update Password:",
                      style: TextStyle(
                          color: Color(0xfffec260),
                          fontWeight: FontWeight.bold,
                          fontSize: 20)),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextFormField(
                    textAlign: TextAlign.start,
                    obscureText: !_passwordVisible1,
                    controller: oldPasswordController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please Enter Password";
                      } else if (value.length < 8) {
                        return "Password should be of min length 8";
                      } else {
                        return null;
                      }
                    },
                    onChanged: (value) {
                      setState(() {});
                    },
                    decoration: kTextFieldDecoration2.copyWith(
                      prefixIcon: Icon(Icons.password),
                      hintText: "Old Password",
                      suffixIcon: IconButton(
                        icon: Icon(
                          // Based on passwordVisible state choose the icon
                          _passwordVisible1
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          // Update the state i.e. toogle the state of passwordVisible variable
                          setState(() {
                            _passwordVisible1 = !_passwordVisible1;
                          });
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 8.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextFormField(
                    textAlign: TextAlign.start,
                    obscureText: !_passwordVisible2,
                    controller: newPasswordController,
                    onChanged: (value) {
                      setState(() {});
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please Enter Password";
                      } else if (value.length < 8) {
                        return "Password should be of min length 8";
                      } else {
                        return null;
                      }
                    },
                    decoration: kTextFieldDecoration2.copyWith(
                      prefixIcon: Icon(Icons.password),
                      hintText: "New Password",
                      suffixIcon: IconButton(
                        icon: Icon(
                          // Based on passwordVisible state choose the icon
                          _passwordVisible2
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          // Update the state i.e. toogle the state of passwordVisible variable
                          setState(() {
                            _passwordVisible2 = !_passwordVisible2;
                          });
                        },
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 4,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: Container(
                          child: Text("Upload Image:",
                              style: TextStyle(
                                  color: Color(0xfffec260),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20)),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: EdgeInsets.only(right: 20),
                        child: ElevatedButton(
                            onPressed: () => pickImageGallery1(),
                            child: Icon(Icons.upload_rounded)),
                      ),
                    ),
                  ],
                ),
                image != null
                    ? Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: Text("Image Preview:",
                            style: TextStyle(
                                color: Color(0xfffec260),
                                fontWeight: FontWeight.bold,
                                fontSize: 20)),
                      )
                    : SizedBox(),
                image != null
                    ? Center(
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black54, blurRadius: 10.0),
                              ],
                              borderRadius: BorderRadius.circular(130.0)),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: CircleAvatar(
                              radius: 100,
                              backgroundImage: FileImage(image!),
                            ),
                          ),
                        ),
                      )
                    : SizedBox(),
                // Padding(
                //   padding:
                //       const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                //   child: Text("Document :",
                //       style: TextStyle(
                //           color: Color(0xfffec260),
                //           fontWeight: FontWeight.bold,
                //           fontSize: 20)),
                // ),
                // Center(
                //   child: Image.network(
                //     "https://api.sfcmanagement.in/api/docs/download/${widget.document}",
                //     height: 200,
                //     fit: BoxFit.fitHeight,
                //   ),
                // ),
                // Center(
                //   child: ElevatedButton(
                //       onPressed: () async {
                //         var tempDir = await getTemporaryDirectory();
                //         String fullPath = tempDir.path + "/licence.pdf'";
                //         print('full path ${fullPath}');
                //         setState(() {
                //           load1 = true;
                //         });
                //         download1(
                //             "https://api.sfcmanagement.in/api/docs/download/${widget.document}",
                //             fullPath);
                //       },
                //       child: Row(
                //         mainAxisSize: MainAxisSize.min,
                //         children: [
                //           Text("Download"),
                //           SizedBox(
                //             width: 5,
                //           ),
                //           load1 == false
                //               ? Icon(Icons.download)
                //               : Container(
                //                   height: 15,
                //                   width: 15,
                //                   child: CircularProgressIndicator(
                //                     color: Colors.black,
                //                     strokeWidth: 3,
                //                   ),
                //                 ),
                //         ],
                //       )),
                // ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 4,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: Text("Upload Document:",
                            style: TextStyle(
                                color: Color(0xfffec260),
                                fontWeight: FontWeight.bold,
                                fontSize: 20)),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: ElevatedButton(
                            onPressed: () => pickImageGallery2(),
                            child: Icon(Icons.upload_rounded)),
                      ),
                    ),
                  ],
                ),
                document != null
                    ? Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: Text("Image Preview:",
                            style: TextStyle(
                                color: Color(0xfffec260),
                                fontWeight: FontWeight.bold,
                                fontSize: 20)),
                      )
                    : SizedBox(),
                document != null
                    ? Center(
                        child: Image.file(
                          document!,
                          height: 200,
                          fit: BoxFit.fitHeight,
                        ),
                      )
                    : SizedBox(),
                (image != null ||
                        document != null ||
                        nameController.text.toString() != "" ||
                        emailController.text.toString() != "" ||
                        phoneController.text.toString() != "" ||
                        oldPasswordController.text.toString() != "" ||
                        newPasswordController.text.toString() != "")
                    ? Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 20),
                        child: Center(
                          child: materialButtonX(
                            loading: false,
                            onClick: () {
                              if (oldPasswordController.text.toString() != "" ||
                                  newPasswordController.text.toString() != "") {
                                if (_formKey.currentState!.validate()) {
                                  BlocProvider.of<updateProfileCubit>(context)
                                      .updateProfile(
                                          nameController.text,
                                          image,
                                          document,
                                          emailController.text,
                                          phoneController.text,
                                          oldPasswordController.text,
                                          newPasswordController.text);
                                }
                              } else {
                                BlocProvider.of<updateProfileCubit>(context)
                                    .updateProfile(
                                        nameController.text,
                                        image,
                                        document,
                                        emailController.text,
                                        phoneController.text,
                                        oldPasswordController.text,
                                        newPasswordController.text);
                              }
                            },
                            message: "Update",
                            icon: Icons.update,
                          ),
                        ),
                      )
                    : SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
