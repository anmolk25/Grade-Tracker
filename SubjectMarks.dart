import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grade_tracker/barGraph.dart';
import 'package:grade_tracker/expandMarks.dart';
import 'package:grade_tracker/main.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pie_chart/pie_chart.dart';
import 'data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SubjectMarks extends StatefulWidget {
  final String subjectName;
  final String docId;
  SubjectMarks({Key key, @required this.docId, @required this.subjectName})
      : super(key: key);

  @override
  _SubjectMarksState createState() => _SubjectMarksState();
}

int value1 = 0;
int value2 = 0;
int value3 = 0;
int value4 = 0;

class _SubjectMarksState extends State<SubjectMarks> {
  List<Widget> subjects = [];
  TextEditingController usernameController = TextEditingController();
  double min = 0;
  double max = 0;
  List<Component> components = [];
  Map<String, double> dataMap;
  double sleep = 0;
  double prep = 0;
  double stress = 0;
  double health = 0;

  @override
  void initState() {
    super.initState();
    /*   subjects = [
      ExpandMarks(componentName: "Quiz 1", marks: 8, maxMarks: 10),
      ExpandMarks(componentName: "Assignmet 1", marks: 6, maxMarks: 10),
      ExpandMarks(componentName: "Assignment 2", marks: 7, maxMarks: 10),
      ExpandMarks(componentName: "Quiz 2", marks: 9, maxMarks: 10),
    ];
  */
  }

  /* addSubject(String subject, double minMarks, double maxMarks) {
    usernameController.clear();
    min = 0;
    max = 0;
    setState(() {
      subjects.add(
        ExpandMarks(
            componentName: subject, marks: minMarks, maxMarks: maxMarks),
      );
    });
  }
*/
  addSub() {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
                actions: [
                  TextButton(
                      onPressed: () {
                        if (usernameController.text.length > 0) {
                          //  addSubject(usernameController.text, min, max);
                          FirebaseFirestore.instance
                              .collection('Users')
                              .doc(Data.docId)
                              .collection('Subjects')
                              .doc(widget.docId)
                              .collection('Components')
                              .add({
                            'name': usernameController.text,
                            'marks': min,
                            'totalMarks': max,
                            'prep': value1,
                            'stress': value2,
                            'sleep': value3,
                            'health': value4
                          });

                          FirebaseFirestore.instance
                              .collection('Users')
                              .doc(Data.docId)
                              .collection('Subjects')
                              .doc(widget.docId)
                              .update({
                            'marks': FieldValue.increment(min),
                            'totalMarks': FieldValue.increment(max),
                            'prep': FieldValue.increment(value1),
                            'stress': FieldValue.increment(value2),
                            'sleep': FieldValue.increment(value3),
                            'health': FieldValue.increment(value4)
                          });

                          FirebaseFirestore.instance
                              .collection('Users')
                              .doc(Data.docId)
                              .update({
                            'marks': FieldValue.increment(min),
                            'totalMarks': FieldValue.increment(max),
                            'prep': FieldValue.increment(value1),
                            'stress': FieldValue.increment(value2),
                            'sleep': FieldValue.increment(value3),
                            'health': FieldValue.increment(value4)
                          });

                          Data.updateProfile();
                        }
                        Navigator.pop(context);
                        setState(() {});
                      },
                      child: Text('Add'))
                ],
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0))),
                title: Text("Add Subject"),
                content: Container(
                  height: 190,//180,
                  child: SingleChildScrollView(
                    child: Column(
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
                                      borderSide:
                                          BorderSide(color: Colors.white),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  hintText: 'Enter your subject name',
                                  // labelStyle: TextStyle(color: Colors.black),
                                  // labelText: UserDetail.username
                                ),
                                onChanged: (String value) {},
                              ),
                            ),
                          ),
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
                                keyboardType: TextInputType.emailAddress,
                                style: TextStyle(color: Colors.black),
                                decoration: InputDecoration(
                                  hasFloatingPlaceholder: true,
                                  focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  hintText: 'Enter scored marks',
                                  // labelStyle: TextStyle(color: Colors.black),
                                  // labelText: UserDetail.username
                                ),
                                onChanged: (String value) {
                                  min = double.parse(value);
                                },
                              ),
                            ),
                          ),
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
                                keyboardType: TextInputType.emailAddress,
                                style: TextStyle(color: Colors.black),
                                decoration: InputDecoration(
                                  hasFloatingPlaceholder: true,
                                  focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  hintText: 'Enter max marks',
                                  // labelStyle: TextStyle(color: Colors.black),
                                  // labelText: UserDetail.username
                                ),
                                onChanged: (String value) {
                                  max = double.parse(value);
                                },
                              ),
                            ),
                          ),
                          SubSlider(
                            name: "Preperation",
                          ),
                          SubSlider(
                            name: "Stress",
                          ),
                          SubSlider(
                            name: "Average Sleep",
                          ),
                          SubSlider(
                            name: "Average Health",
                          )
                        ]),
                  ),
                )));
  }

  getData() async {
    components = [];
    subjects = [];

    var snapshot2 = await FirebaseFirestore.instance
        .collection('Users')
        .doc(Data.docId)
        .collection('Subjects')
        .doc(widget.docId)
        .collection('Components')
        .get();

    int k = 0;
    //print(snapshot2.docs.length);
    if (snapshot2.docs.length != 0) {
      for (var doc in snapshot2.docs) {
        Map<String, dynamic> data = doc.data();
        subjects.add(ExpandMarks(
            docId: doc.id,
            componentName: data['name'] ?? "",
            marks: (data['marks'] ?? 0),
            maxMarks: (data['totalMarks'] ?? 1),
            sleep: data['sleep'] ?? 0,
            prep: data['prep'] ?? 0,
            health: data['health'] ?? 0,
            stress: data['stress'] ?? 0));

        components.add(Component(
            name: data['name'] ?? "",
            marks: ((data['marks'] ?? 0) / (data['totalMarks'] ?? 1)) * 100,
            max: 100));

        sleep += data['sleep'] ?? 0;
        prep += data['prep'] ?? 0;
        health += data['health'] ?? 0;
        stress += data['stress'] ?? 0;

        dataMap = {
          "Preperation": prep,
          "Stress Level": stress,
          "Average Sleep": sleep,
          "Health Level": health,
        };
      }
      print(subjects.length);
      return 1;
    } else {
      return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.push(
            context,
            PageTransition(
                type: PageTransitionType.rightToLeft, child: MyHomePage()));
      },
      child: Scaffold(
        backgroundColor: Color(0xFF0336FF),
        appBar: AppBar(
          backgroundColor: Color(0xFFFFDE03),
          centerTitle: false,
          leading: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.rightToLeft,
                        child: MyHomePage()));
              },
              child: Icon(
                Icons.arrow_back_ios,
                color: Color(0xFFFF0266),
              )),
          title: Text(
            widget.subjectName,
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w800),
          ),
        ),
        body: FutureBuilder(
            future: getData(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data == 0)
                  return Container();
                else
                  return ListView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: subjects.length,
                          itemBuilder: (BuildContext buildContext, int index) {
                            return subjects[index];
                          },
                        ),
                      ),
                      Container(
                        color: Color(0xFF0336FF),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 15.0),
                                  child: Container(
                                      padding: EdgeInsets.all(8),
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text("SUBJECT STATISTICS",
                                                style: GoogleFonts.aBeeZee(
                                                  textStyle: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                )),
                                            SizedBox(height: 30),
                                            if (components.length > 1)
                                              Container(
                                                  height: 250,
                                                  child: SimpleBarChart
                                                      .withSampleData(
                                                          components)),

                                            /*       Container(
                                    //height: 100,
                                    child: Image.asset("assets/graph.png"),
                                  ),
                             */
                                            Container(
                                                //height: 100,
                                                child: PieChart(
                                              dataMap: dataMap,
                                              chartValuesOptions:
                                                  ChartValuesOptions(
                                                showChartValueBackground: true,
                                                showChartValuesInPercentage:
                                                    true,
                                                showChartValuesOutside: false,
                                                decimalPlaces: 1,
                                              ),
                                            )
                                                // Image.asset("assets/chart.png"),
                                                )
                                          ],
                                        ),
                                      )),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
              } else
                return Container();
            }),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Color(0xFFFFDE03),
          onPressed: addSub,
          tooltip: 'Add Subject',
          child: Icon(
            Icons.add,
            color: Colors.black,
          ),
        ), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}

class SubSlider extends StatefulWidget {
  final String name;
  const SubSlider({Key key, @required this.name}) : super(key: key);

  @override
  _SubSliderState createState() => _SubSliderState();
}

class _SubSliderState extends State<SubSlider> {
  int value = 0;
  @override
  void initState() {
    super.initState();

    if (widget.name == 'Preperation') value = value1;
    if (widget.name == 'Stress') value = value2;
    if (widget.name == 'Average Health') value = value3;
    if (widget.name == 'Average Sleep') value = value4;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            "$value",
            style: GoogleFonts.aBeeZee(
              textStyle: TextStyle(
                  color: Color(0xFFFF0266),
                  fontWeight: FontWeight.w800,
                  fontSize: 16),
            ),
          ),
          Expanded(
              child: Slider(
                  value: value.toDouble(),
                  min: 0.0,
                  max: 10.0,
                  divisions: 10,
                  activeColor: Color(0xFFFFDE03),
                  inactiveColor: Color(0xFF0336FF),
                  label: 'Set ${widget.name} level value',
                  onChanged: (double newValue) {
                    setState(() {
                      value = newValue.round();
                      if (widget.name == 'Preperation')
                        value1 = newValue.round();
                      if (widget.name == 'Stress') value2 = newValue.round();
                      if (widget.name == 'Average Health')
                        value3 = newValue.round();
                      if (widget.name == 'Average Sleep')
                        value4 = newValue.round();
                    });
                  },
                  semanticFormatterCallback: (double newValue) {
                    return '${newValue.round()} dollars';
                  })),
          Text("10",
              style: GoogleFonts.aBeeZee(
                textStyle: TextStyle(
                    color: Color(0xFFFF0266),
                    fontWeight: FontWeight.w800,
                    fontSize: 16),
              ))
        ]);
  }
}
