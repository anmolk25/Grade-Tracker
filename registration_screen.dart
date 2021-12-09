import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grade_tracker/main.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'data.dart';

class BFMUser {
  String email;
  String password;
  String phoneNumber;
  List<String> favourites = [];
  String gender;
  String username;
  String name;
  String birthday;
  String profession;
}

class Test2 extends StatefulWidget {
  @override
  _Test2State createState() => _Test2State();
}

class _Test2State extends State<Test2> {
  bool obscure = true;
  bool loading = false;
  String email = "";
  String password = "";
  String name1 = "";
  String name2 = "";
  TextEditingController name1Contr = TextEditingController();
  TextEditingController name2Contr = TextEditingController();
  var _auth;
  TapGestureRecognizer tap;
  TapGestureRecognizer tap2;
  BFMUser user;

  @override
  void initState() {
    _auth = FirebaseAuth.instance;
    user = new BFMUser();
  }

  List<String> convertArr(String name) {
    List<String> arr = [];
    for (int a = 1; a <= name.length; a++) arr.add(name.substring(0, a));
    return arr;
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
                            "Let's setup your account",
                            style: GoogleFonts.aBeeZee(
                                textStyle: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                            )), //TextStyle(fontSize: 18, fontWeight: FontWeight.w800,),
                          ),
                        ),
                      ),
                      SizedBox(height: 65),
                      /*  Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 45.0),
                        child: Container(
                            alignment: Alignment.centerLeft,
                            child: Text("People use real names on BFM :)")),
                      ),
                     */
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 40.0, right: 15),
                              child: Container(
                                //   height: 30,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 2),
                                  child: TextField(
                                    controller: name1Contr,
                                    autofillHints: [AutofillHints.givenName],
                                    keyboardType: TextInputType.name,
                                    textCapitalization:
                                        TextCapitalization.words,
                                    style: GoogleFonts.aBeeZee(
                                        textStyle: TextStyle(
                                      //    fontSize: 13,
                                      fontWeight: FontWeight.w400,
                                    )),
                                    decoration: InputDecoration(
                                      hintStyle: TextStyle(
                                          color: Colors.black, fontSize: 15),
                                      hintText: "First Name",
                                      border: InputBorder.none,
                                    ),
                                    onChanged: (String value) {
                                      if (value.length == 1) {
                                        value = value.toUpperCase();
                                      }
                                      name1 = value;
                                      if (name1.length > 20) {
                                        name1 = name1.substring(0, 20);
                                        name1Contr.text = name1;
                                        name1Contr.selection =
                                            TextSelection.fromPosition(
                                                TextPosition(
                                                    offset: name1.length));
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 15.0, right: 40),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 2),
                                  child: TextField(
                                    controller: name2Contr,
                                    autofillHints: [AutofillHints.familyName],
                                    keyboardType: TextInputType.name,
                                    textCapitalization:
                                        TextCapitalization.sentences,
                                    style: GoogleFonts.aBeeZee(
                                        textStyle: TextStyle(
                                      //    fontSize: 13,
                                      fontWeight: FontWeight.w400,
                                    )),
                                    decoration: InputDecoration(
                                      hintStyle: TextStyle(
                                          color: Colors.black, fontSize: 15),
                                      hintText: "Last Name",
                                      border: InputBorder.none,
                                    ),
                                    onChanged: (String value) {
                                      if (value.length == 1) {
                                        value = value.toUpperCase();
                                      }

                                      name2 = value;
                                      if (name2.length > 20) {
                                        name2 = name2.substring(0, 20);
                                        name2Contr.text = name2;
                                        name2Contr.selection =
                                            TextSelection.fromPosition(
                                                TextPosition(
                                                    offset: name2.length));
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 25),
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
                              autofillHints: [AutofillHints.email],
                              keyboardType: TextInputType.emailAddress,
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
                              autofillHints: [AutofillHints.newPassword],
                              //        onEditingComplete: ()=> TextInput.finishAutofillContext(shouldSave: true),
                              obscureText: obscure,
                              //     textInputAction: TextInputAction.,
                              onSubmitted: (value) {},
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
                                    "By creating your account, you're agreeing to our\n",
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
                                'Create Account',
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              )),
                              onPressed: () async {
                                email = email.toLowerCase();
                                user.email = email;
                                user.name = name1.trim() + " " + name2.trim();
                                if (name1.trim().length == 0 ||
                                    name2.trim().length == 0)
                                  showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20.0))),
                                          title: Text("Empty Fields"),
                                          content: Text(
                                              "Please complete all fields before proceding.")));
                                else {
                                  TextInput.finishAutofillContext(
                                      shouldSave: true);

                                  setState(() {
                                    loading = true;
                                  });
                                  try {
                                    final newUser = await _auth
                                        .createUserWithEmailAndPassword(
                                            email: user.email.trim(),
                                            password: password.trim());
                                    if (newUser != null) {
                                      await newUser.user
                                          .sendEmailVerification();

                                      Firestore.instance
                                          .collection("Users")
                                          .add({
                                        "name": user.name,
                                        "email": user.email,
                                        //      "mobile number": "",
                                        //       "username": "",
                                      }).then((doc) async {
                                        showDialog(
                                            context: context,
                                            barrierDismissible: false,
                                            builder: (context) => AlertDialog(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  20.0))),
                                                  title:
                                                      Text("Verify Your Email"),
                                                  content: Text(
                                                      "Please Verify your email by opening the link which we just sent you on your email."),
                                                ));
                                        await new Future.delayed(
                                            const Duration(seconds: 3));
                                        Navigator.pop(context);
                                        Data.email = user.email.trim();
                                        Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  MyHomePage(),
                                            ),
                                            (e) => false);
                                      });
                                    }
                                  } on FirebaseAuthException catch (e) {
                                    setState(() {
                                      loading = false;
                                      showDialog(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              20.0))),
                                              title: Text(
                                                  "Check your credentials"),
                                              content: Text(e.message)));
                                    });
                                  }

                                  //         Navigator.push(context,
                                  //           MaterialPageRoute(builder: (context) => FeedPage()));

                                }
                              }),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 30.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("Already hava a account? ",
                              style: GoogleFonts.aBeeZee(
                                  textStyle: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w100,
                              ))),
                          GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                                /*        Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                      pageBuilder:
                                          (context, animation1, animation2) =>
                                              SignupPage(),
                                      transitionDuration:
                                          Duration(milliseconds: 500),
                                    ));
                         */
                              },
                              child: Text(
                                "Sign in.",
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
