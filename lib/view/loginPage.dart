import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_manager/cubit/loginCubit.dart';
import 'package:inventory_manager/cubit/loginState.dart';
import 'package:inventory_manager/provider/constants.dart';
import 'package:inventory_manager/view/homePage.dart';
import 'package:inventory_manager/widgets/nextButton.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:inventory_manager/utlis/securestorage.dart';

class loginPage extends StatefulWidget {
  @override
  _loginPageState createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  late bool _passwordVisible1;
  bool _loading = false;
  @override
  initState() {
    // TODO: implement initState
    init();
    super.initState();
    _passwordVisible1 = false;
  }

  init() async {
    final email = await userSecureStorage2.getEmail();

    emailController.text = email != null ? email.toString() : "";
  }

  final _formKey1 = GlobalKey<FormState>();
  bool validateEmail(String value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    return (!regex.hasMatch(value)) ? false : true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<loginCubit, loginState>(
        listener: (context, state) async {
          // TODO: implement listener
          if (state.code == "00") {
            Scaffold.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.black,
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      loggedInText,
                      style: TextStyle(color: Color(0xfffec260), fontSize: 18),
                    ),
                  ],
                ),
                duration: Duration(milliseconds: 1000),
              ),
            );
            await userSecureStorage2.setEmail(emailController.text);

            final SharedPreferences sharedPreferences =
                await SharedPreferences.getInstance();
            sharedPreferences.setString('email', emailController.text);

            setState(() {
              _loading = false;
            });
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return mainPage();
            }));
            emailController.clear();
            passController.clear();
          } else {
            setState(() {
              _loading = false;
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
            emailController.clear();
            passController.clear();
          }
        },
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Form(
                key: _formKey1,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height / 4,
                        child: Image.asset(
                          "assets/inventory.png",
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: Text(
                          "Inventory Manager",
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.w700),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: TextFormField(
                          autofocus: false,
                          keyboardType: TextInputType.emailAddress,
                          decoration: kTextFieldDecoration.copyWith(
                            prefixIcon: Icon(Icons.email),
                            labelText: "Email ID",
                            hintText: "Enter Your Email ID",
                          ),
                          controller: emailController,
                          validator: (value) {
                            if (validateEmail(emailController.text) == false) {
                              return enterValidEmailText;
                            } else
                              return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: TextFormField(
                          autofocus: false,
                          obscureText: !_passwordVisible1,
                          decoration: kTextFieldDecoration.copyWith(
                            prefixIcon: Icon(Icons.password),
                            labelText: "Password",
                            hintText: "Enter Your Password",
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
                          controller: passController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return pleaseEnterPassWordText;
                            } else if (value.length < 8) {
                              return passwordOfMinLength8Text;
                            } else
                              return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: materialButtonX(
                            message: "Login",
                            icon: Icons.login,
                            onClick: () {
                              print("aysuu");
                              setState(() {
                                if (_formKey1.currentState!.validate() ==
                                    true) {
                                  _loading = true;
                                  BlocProvider.of<loginCubit>(context)
                                      .loginEmail(emailController.text,
                                          passController.text);
                                }
                              });
                            },
                            loading: _loading),
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
