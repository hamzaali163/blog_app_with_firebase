import 'package:blog_app/Utils/general_utils.dart';
import 'package:blog_app/Utils/route_names.dart';
import 'package:blog_app/components/app_colors.dart';
import 'package:blog_app/components/roundbutton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  FocusNode emailfocusnode = FocusNode();
  FocusNode passwordfocusnode = FocusNode();
  bool load = false;
  final _formkey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  // final _myrepo = GeneralUtils();
  @override
  void dispose() {
    super.dispose();
    emailcontroller.dispose();
    passwordcontroller.dispose();
  }

  void login() async {
    setState(
      () {
        load = true;
      },
    );
    await _auth
        .signInWithEmailAndPassword(
            email: emailcontroller.text.toString(),
            password: passwordcontroller.text.toString())
        .then((value) {
      GeneralUtils().successfulmessage("Logged In", context);
      Navigator.pushNamed(context, RoutesNames.homeScreen);
      setState(() {
        load = false;
      });
    }).onError((error, stackTrace) {
      GeneralUtils().showerrormessage(error.toString(), context);
      setState(() {
        load = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    //   final provider = Provider.of<GeneralUtils>(context, listen: false);
    return ModalProgressHUD(
      inAsyncCall: GeneralUtils().showspinner,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          // title: const Text('Login Screen'),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 50, bottom: 10),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      'Sign In',
                      style: AppColors.heading,
                    ),
                  ),
                ),
                const Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    'Please log in into your account',
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
                        focusNode: emailfocusnode,
                        controller: emailcontroller,
                        style: const TextStyle(color: Colors.black),
                        decoration: const InputDecoration(
                          fillColor: Color(0xffF5F5F5),
                          border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.transparent)),
                          labelText: 'Email',
                          hintText: "Enter email",
                          prefixIcon: Icon(
                            Icons.email_outlined,
                            color: AppColors.mainColor,
                          ),
                        ),
                        onFieldSubmitted: ((value) {
                          GeneralUtils.focusnodechange(
                              emailfocusnode, passwordfocusnode, context);
                        }),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter your email address';
                          } else if (!value.contains('@')) {
                            return 'Enter a correct email, i.e hamza@gmail.com';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        style: const TextStyle(color: Colors.black),
                        obscureText: true,
                        focusNode: passwordfocusnode,
                        controller: passwordcontroller,
                        decoration: const InputDecoration(
                            fillColor: Color(0xffF5F5F5),
                            border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent)),
                            hintText: "Enter password",
                            labelText: 'Password',
                            prefixIcon: Icon(
                              Icons.lock,
                              color: AppColors.mainColor,
                            )),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter password';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.05,
                      ),
                      RoundButton(
                          title: 'Log In',
                          loading: load,
                          ontap: () {
                            if (_formkey.currentState!.validate()) {
                              login();
                            }
                          }),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: TextButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, RoutesNames.ForgotPasswordScreen);
                            },
                            child: const Text(
                              "Forgot Password",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.orange,
                                  fontSize: 14),
                            )),
                      ),
                      // SizedBox(
                      //   height: MediaQuery.of(context).size.height * 0.05,
                      // ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                AuthButton(
                    title: 'Sign in with phone number',
                    ontap: () {
                      Navigator.pushNamed(
                          context, RoutesNames.phoneNumberScreen);
                    }),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                GoogleButton(
                    title: 'Sign in with Google',
                    ontap: () {
                      signInWithGoogle();
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<dynamic> signInWithGoogle() async {
    GeneralUtils().progressindic(true);
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    await FirebaseAuth.instance.signInWithCredential(credential).then((value) {
      Navigator.pushNamed(context, RoutesNames.homeScreen);
      GeneralUtils().progressindic(false);
    }).onError((error, stackTrace) {
      GeneralUtils().showerrormessage(error.toString(), context);
      GeneralUtils().progressindic(false);
    });
  }
}
