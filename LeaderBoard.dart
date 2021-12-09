import 'package:flutter/material.dart';
import 'package:grade_tracker/marksContainer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:page_transition/page_transition.dart';
import 'data.dart';
import 'expandMarks.dart';
import 'main.dart';

class LeaderBoard extends StatefulWidget {
  LeaderBoard({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LeaderBoardState createState() => _LeaderBoardState();
}

class _LeaderBoardState extends State<LeaderBoard> {
  List<Widget> subjects = [];
  TextEditingController usernameController = TextEditingController();
  double sleep = 0;
  double prep = 0;
  double stress = 0;
  double health = 0;
  List<Component> components = [];

  @override
  void initState() {
    super.initState();
    /*  subjects = [
      MarksContainer(subject: "English", marks: "35", totalMarks: "50"),
      MarksContainer(subject: "Maths", marks: "25", totalMarks: "50"),
      MarksContainer(subject: "Physics", marks: "40", totalMarks: "50"),
      MarksContainer(subject: "Subject 4", marks: "40", totalMarks: "50"),
      MarksContainer(subject: "Subject 5", marks: "40", totalMarks: "50"),
      MarksContainer(subject: "Subject 6", marks: "40", totalMarks: "50"),
      MarksContainer(subject: "Subject 7", marks: "40", totalMarks: "50"),
    ];
 */
  }

  /* addSubject(String subject) {
    usernameController.clear();
    setState(() {
      subjects
          .add(MarksContainer(subject: subject, marks: "0", totalMarks: "0"));
    });
  }
  */

  addSub() {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
                actions: [
                  TextButton(
                      onPressed: () async {
                        if (usernameController.text.length > 0)
                          //   addSubject(usernameController.text);

                          FirebaseFirestore.instance
                              .collection('Users')
                              .doc(Data.docId)
                              .collection('Subjects')
                              .add({
                            'name': usernameController.text,
                            'marks': 0,
                            'totalMarks': 0,
                            'sleep': 0,
                            'stress': 0,
                            'prep': 0,
                            'health': 0
                          });
                        Navigator.pop(context);
                        setState(() {});
                      },
                      child: Text('Add'))
                ],
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0))),
                title: Text("Add Subject"),
                content: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 0.0, vertical: 8),
                        child: Container(
                          padding: const EdgeInsets.only(
                              left: 8, right: 8, top: 6, bottom: 0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                          ),
                          child: TextField(
                            controller: usernameController,
                            keyboardType: TextInputType.emailAddress,
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              hasFloatingPlaceholder: true,
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              hintText: 'Enter your subject name',
                              // labelStyle: TextStyle(color: Colors.black),
                              // labelText: UserDetail.username
                            ),
                            onChanged: (String value) {},
                          ),
                        ),
                      ),
                    ])));
  }

  getData() async {
    subjects = [];
    components = [];

    var snapshot2 = await FirebaseFirestore.instance
        .collection('Users')
        .orderBy('percent', descending: true)
        .get();

    int k = 0;
    if (snapshot2.docs.length != 0) {
      for (var doc in snapshot2.docs) {
        k++;
        Map<String, dynamic> data = doc.data();
        subjects.add(ExpandMarks(
            docId: doc.id,
            componentName: "#$k ${data['name'] ?? ""}",
            percent: data['percent'],
            sleep: data['sleep'] ?? 0,
            prep: data['prep'] ?? 0,
            health: data['health'] ?? 0,
            stress: data['stress'] ?? 0));

        sleep += data['sleep'] ?? 0;
        prep += data['prep'] ?? 0;
        health += data['health'] ?? 0;
        stress += data['stress'] ?? 0;
      }
      return 1;
    } else {
      return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0336FF),
      appBar: AppBar(
        backgroundColor: Color(0xFFFFDE03),
        centerTitle: false,
        leading: GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                PageTransition(
                    type: PageTransitionType.rightToLeft, child: MyHomePage()));
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Color(0xFFFF0266),
          ),
        ),
        title: Text(
          "Leaderboard",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w800),
        ),
      ),
      body: ListView(
        children: [
          FutureBuilder(
              future: getData(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  Map<String, double> dataMap = {
                    "Preperation": prep,
                    "Stress Level": stress,
                    "Average Sleep": sleep,
                    "Health Level": health,
                  };

                  if (snapshot.data == 0)
                    return Container();
                  else {
                    return Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15)),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: subjects.length,
                                      itemBuilder: (BuildContext buildContext,
                                          int index) {
                                        return subjects[index];
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }
                } else
                  return Container();
              })
        ],
      ),
   );
  }
}
