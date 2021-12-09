import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/gestures.dart';
import 'package:grade_tracker/data.dart';
import 'package:grade_tracker/main.dart';
import 'package:grade_tracker/registration_screen.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Test extends StatefulWidget {
  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  bool obscure = true;
  TapGestureRecognizer tap;
  TapGestureRecognizer tap2;
  bool loading = false;
  String email = "";
  String password = "";
  bool update = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFFFDE03),
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: ModalProgressHUD(
            inAsyncCall: loading,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                AutofillGroup(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 60.0),
                        child: Center(
                          child: Text(
                            "Welcome to Grade Tracker",
                            style: GoogleFonts.aBeeZee(
                                textStyle: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                            )), //TextStyle(fontSize: 18, fontWeight: FontWeight.w800,),
                          ),
                        ),
                      ),
                      SizedBox(height: 65),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 2),
                            child: TextField(
                              keyboardType: TextInputType.emailAddress,
                              autofillHints: [AutofillHints.email],
                              style: GoogleFonts.aBeeZee(
                                  textStyle: TextStyle(
                                //    fontSize: 13,
                                fontWeight: FontWeight.w400,
                              )),
                              decoration: InputDecoration(
                                hintStyle: TextStyle(
                                    color: Colors.black, fontSize: 15),
                                hintText: "Enter Email",
                                border: InputBorder.none,
                              ),
                              onChanged: (String value) {
                                //  email = value;
                                email = value;
                              },
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 2),
                            child: TextField(
                              obscureText: obscure,
                              autofillHints: [AutofillHints.password],
                              //           onEditingComplete: () =>
                              //             TextInput.finishAutofillContext(),
                              keyboardType: TextInputType.visiblePassword,
                              style: GoogleFonts.aBeeZee(
                                  textStyle: TextStyle(
                                //    fontSize: 13,
                                fontWeight: FontWeight.w400,
                              )),
                              decoration: InputDecoration(
                                suffixIcon: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      obscure = !obscure;
                                    });
                                  },
                                  child: Icon(
                                    !obscure
                                        ? Icons.visibility_off_outlined
                                        : Icons.remove_red_eye_outlined,
                                    color: Colors.black54,
                                  ),
                                ),
                                hintStyle: TextStyle(
                                    color: Colors.black, fontSize: 15),
                                hintText: "Enter Password",
                                border: InputBorder.none,
                              ),
                              onChanged: (String value) {
                                //  email = value;
                                password = value;
                              },
                            ),
                          ),
                        ),
                      ),
                      /*               Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 45.0),
                        child: Container(
                            alignment: Alignment.centerRight,
                            child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      PageRouteBuilder(
                                        pageBuilder:
                                            (context, animation1, animation2) =>
                                                ForgetPassword(),
                                        transitionDuration:
                                            Duration(milliseconds: 500),
                                      ));
                                },
                                child: Text("Forgot Password?"))),
                      ),
         */
                    ],
                  ),
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Text.rich(
                        TextSpan(
                          style: TextStyle(
                            height: 1.8,
                            fontSize: 13,
                          ),
                          children: [
                            TextSpan(
                                text:
                                    "By signing in to your account, you're agreeing to our\n",
                                style: GoogleFonts.aBeeZee(
                                    textStyle: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w100,
                                ))),
                            TextSpan(
                                recognizer: tap,
                                text: 'Terms of Service ',
                                style: GoogleFonts.aBeeZee(
                                    textStyle: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w800,
                                ))),
                            TextSpan(
                                text: 'and',
                                style: GoogleFonts.aBeeZee(
                                    textStyle: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w100,
                                ))),
                            TextSpan(
                                recognizer: tap2,
                                text: ' Privacy Policy',
                                style: GoogleFonts.aBeeZee(
                                    textStyle: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w800,
                                ))),
                            TextSpan(
                                text: '. Thanks!',
                                style: GoogleFonts.aBeeZee(
                                    textStyle: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w100,
                                )))
                          ],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Hero(
                      tag: "1",
                      child: Padding(
                        padding: const EdgeInsets.only(
                            right: 45, left: 45.0, top: 40, bottom: 25),
                        child: SizedBox(
                          height: 60,
                          child: FlatButton(
                            color: Color(0xFF0336FF),
                            shape: new RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(25.0)),
                                side: BorderSide(color: Colors.white)),
                            // padding: EdgeInsets.only(left: 150, right: 150),
                            // color: Theme.of(context).buttonColor,
                            textColor: Colors.white,
                            child: Center(
                                child: Text(
                              'Sign In',
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            )),
                            onPressed: () async {
                              TextInput.finishAutofillContext();
                              print("1");
                              setState(() {
                                loading = true;
                              });
                              try {
                                print("1");
                                final user = await FirebaseAuth.instance
                                    .signInWithEmailAndPassword(
                                        email: email.trim(),
                                        password: password.trim());
                                if (user != null) {
                                  loading = false;
                                  Data.email = email.trim();
                                  Navigator.pushAndRemoveUntil(context,
                                      MaterialPageRoute(builder: (context) {
                                    return MyHomePage();
                                  }), (e) => false);
                                }
                              } on FirebaseAuthException catch (e) {
                                setState(() {
                                  loading = false;
                                  showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20.0))),
                                          title: Text("Check your credentials"),
                                          content: Text(e.message)));
                                });
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 30.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("Don't hava a account? ",
                              style: GoogleFonts.aBeeZee(
                                  textStyle: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w100,
                              ))),
                          GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                      pageBuilder:
                                          (context, animation1, animation2) =>
                                              Test2(),
                                      transitionDuration:
                                          Duration(milliseconds: 500),
                                    ));
                              },
                              child: Text(
                                "Create Account",
                                style: GoogleFonts.aBeeZee(
                                    textStyle: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w800,
                                )),
                              ))
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
