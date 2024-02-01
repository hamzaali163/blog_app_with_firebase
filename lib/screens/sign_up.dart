import 'package:blog_app/Utils/general_utils.dart';
import 'package:blog_app/Utils/route_names.dart';
import 'package:blog_app/components/app_colors.dart';
import 'package:blog_app/components/roundbutton.dart';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  final namecontroller = TextEditingController();

  FocusNode emailfocusnode = FocusNode();
  FocusNode passwordfocusnode = FocusNode();
  FocusNode namefocusnode = FocusNode();

  final _formkey = GlobalKey<FormState>();

  FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  void dispose() {
    super.dispose();
    emailcontroller.dispose();
    passwordcontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final providerr = Provider.of<GeneralUtils>(
      context,
    );
    return ModalProgressHUD(
      color: Colors.white,
      inAsyncCall: providerr.showspinner,
      child: Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 90, bottom: 10),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      'Sign Up',
                      style: AppColors.heading,
                    ),
                  ),
                ),
                const Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    'Please create a new account',
                    style: AppColors.subheading,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Form(
                  key: _formkey,
                  child: Column(
                    children: [
                      TextFormField(
                        style: const TextStyle(color: Colors.black),
                        controller: namecontroller,
                        focusNode: namefocusnode,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xffE1E1E1))),
                            hintText: "Enter name",
                            labelText: 'Name',
                            prefixIcon: Icon(
                              Icons.person,
                              color: AppColors.mainColor,
                            )),
                        validator: (value) {
                          if (value!.isEmpty) {
                            providerr.progressindic(false);
                            return 'Enter name';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        style: const TextStyle(color: Colors.black),
                        keyboardType: TextInputType.emailAddress,
                        controller: emailcontroller,
                        focusNode: emailfocusnode,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xffE1E1E1))),
                            fillColor: Colors.black,
                            hintText: "Enter email",
                            labelText: 'Email',
                            prefixIcon: Icon(
                              Icons.email_outlined,
                              color: AppColors.mainColor,
                            )),
                        onFieldSubmitted: ((value) {
                          GeneralUtils.focusnodechange(
                              emailfocusnode, passwordfocusnode, context);
                        }),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter your email address';
                          }

                          // else if (!value.contains('@')) {
                          //   return 'Enter a correct email, i.e hamza@gmail.com';
                          // }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        style: const TextStyle(color: Colors.black),
                        obscureText: true,
                        controller: passwordcontroller,
                        focusNode: passwordfocusnode,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xffE1E1E1))),
                            hintText: "Enter password",
                            labelText: 'Password',
                            prefixIcon: Icon(
                              Icons.lock,
                              color: AppColors.mainColor,
                            )),
                        validator: (value) {
                          if (value!.isEmpty) {
                            providerr.progressindic(false);
                            return 'Enter password';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.05,
                      ),
                      RoundButtonTwo(
                          title: 'Sign Up',
                          loading: providerr.showspinner,
                          ontap: () async {
                            providerr.progressindic(true);
                            if (_formkey.currentState!.validate()) {
                              try {
                                await _auth.createUserWithEmailAndPassword(
                                  email: emailcontroller.text.toString(),
                                  password: passwordcontroller.text.toString(),
                                );
                                // ignore: use_build_context_synchronously
                                GeneralUtils().successfulmessage(
                                    'Signed up succesfully !', context);
                                providerr.progressindic(false);
                                Navigator.pushNamed(
                                    context, RoutesNames.homeScreen);
                              } on FirebaseAuthException catch (e) {
                                debugPrint(e.toString());
                                if (e.code == 'email-already-in-use') {
                                  // ignore: use_build_context_synchronously
                                  GeneralUtils().showerrormessage(
                                      'Account already exists', context);
                                  providerr.progressindic(false);
                                } else if (e.code == 'invalid-email') {
                                  // ignore: use_build_context_synchronously
                                  GeneralUtils().showerrormessage(
                                      'Enter a correct email, i.e hamza@gmail.com',
                                      context);
                                  providerr.progressindic(false);
                                } else if (e.code == 'weak-password') {
                                  // ignore: use_build_context_synchronously
                                  GeneralUtils().showerrormessage(
                                      'Password is very weak', context);
                                  providerr.progressindic(false);
                                }
                              }
                            }
                          }),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
