import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grade_tracker/LeaderBoard.dart';
import 'package:grade_tracker/login_screen.dart';
import 'package:grade_tracker/seeAllSubjects.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pie_chart/pie_chart.dart';
import 'barGraph.dart';
import 'data.dart';
import 'marksContainer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Grade Tracker',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: (FirebaseAuth.instance.currentUser == null) ? Test() : MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
    var snapshot = await FirebaseFirestore.instance
        .collection('Users')
        .where('email', isEqualTo: Data.email)
        .limit(1)
        .get();
    for (var a in snapshot.docs) {
      Data.docId = a.id;
    }
    var snapshot2 = await FirebaseFirestore.instance
        .collection('Users')
        .doc(Data.docId)
        .collection('Subjects')
        .orderBy('totalMarks', descending: true)
        .limit(3)
        .get();

    int k = 0;
    if (snapshot2.docs.length != 0) {
      for (var doc in snapshot2.docs) {
        Map<String, dynamic> data = doc.data();
        subjects.add(MarksContainer(
            docId: doc.id,
            subject: data['name'] ?? "",
            marks: (data['marks'] ?? "0").toString(),
            totalMarks: (data['totalMarks'] ?? "0").toString()));
        sleep += data['sleep'] ?? 0;
        prep += data['prep'] ?? 0;
        health += data['health'] ?? 0;
        stress += data['stress'] ?? 0;

        k++;
        if (data['totalMarks'] > 0) {
          components.add(Component(
              name: data['name'] ?? "",
              marks: ((data['marks'] ?? 0) / (data['totalMarks'] ?? 1)) * 100,
              max: 100));
        }
      }
      return 1;
    } else {
      return 0;
    }
  }

  final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    sleep = 0;
    prep = 0;
    stress = 0;
    health = 0;
    return Scaffold(
      key: _key,
      backgroundColor: Color(0xFF0336FF),
      appBar: AppBar(
        backgroundColor: Color(0xFFFFDE03),
        centerTitle: false,
        leading: GestureDetector(
          onTap: () {
            _key.currentState.openDrawer();
          },
          child: Icon(
            Icons.home,
            color: Color(0xFFFF0266),
          ),
        ),
        title: GestureDetector(
          onTap: () {
            _key.currentState.openDrawer();
          },
          child: Text(
            "Home",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w800),
          ),
        ),
      ),
      drawer: Drawer(
        child: LayoutBuilder(
          builder: (context, constraint) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraint.maxHeight),
                child: IntrinsicHeight(
                  child: Column(
                    children: <Widget>[
                      Container(
                        color: Color(0xFFFFDE03),
                        child: DrawerHeader(
                          margin: EdgeInsets.all(0.0),
                          child: Center(
                            child: Text(
                              "Grade Tracker",
                              style: GoogleFonts.ptSans(
                                  textStyle: TextStyle(
                                fontSize: 22,
                                color: Colors.black,
                                fontWeight: FontWeight.w800,
                              )),
                            ),
                          ),
                        ),
                      ),
                      ListTile(
                        tileColor: Color(0xFF0336FF),
                        leading: Icon(Icons.home, color: Color(0xFFFF0266)),
                        title: Text(
                          "Home",
                          style: TextStyle(color: Colors.white),
                        ),
                        onTap: () {
                          //       StaticFunctions.testing();
                          Navigator.pop(context);
                        },
                      ),
                      ListTile(
                        tileColor: Color(0xFF0336FF),
                        leading: Icon(Icons.show_chart_rounded,
                            color: Color(0xFFFF0266)),
                        title: Text(
                          "LeaderBoard",
                          style: TextStyle(color: Colors.white),
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              PageTransition(
                                  type: PageTransitionType.rightToLeft,
                                  child: LeaderBoard()));
                        },
                      ),
                      Expanded(
                          child: SizedBox(
                        child: Container(color: Color(0xFF0336FF)),
                      )),
                      const Divider(height: 1.0, color: Colors.grey),
                      ListTile(
                        tileColor: Color(0xFFFFDE03),
                        leading: Icon(Icons.exit_to_app),
                        title: Text("Logout"),
                        onTap: () async {
                          await FirebaseAuth.instance.signOut();

                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      // MyHomePage()
                                      Test()),
                              (e) => false);
                        },
                      )
                    ],
                  ),
                ),
              ),
            );
          },
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
                  else
                    return Container(
                      color: Color(0xFF0336FF),
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
                                    itemBuilder:
                                        (BuildContext buildContext, int index) {
                                      return subjects[index];
                                    },
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          PageTransition(
                                              type: PageTransitionType
                                                  .rightToLeft,
                                              child: SeeAllSubjects()));
                                    },
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 6, horizontal: 12.0),
                                        child: Text(
                                          "See More",
                                          style: GoogleFonts.aBeeZee(
                                              textStyle: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 15)),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 15.0),
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
                                          Text("OVERALL STATISTICS",
                                              style: GoogleFonts.aBeeZee(
                                                textStyle: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              )),
                                          if (components.length > 1)
                                            Container(
                                                height: 250,
                                                child: SimpleBarChart
                                                    .withSampleData(
                                                        components)),
                                          if (sleep != 0 ||
                                              prep != 0 ||
                                              health != 0 ||
                                              stress != 0)
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
                                          else
                                            Container(
                                              height: 100,
                                              child: Center(
                                                child: Text("No Data Available",
                                                    style: GoogleFonts.aBeeZee(
                                                      textStyle: TextStyle(
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    )),
                                              ),
                                            )
                                        ],
                                      ),
                                    )),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                } else
                  return Container();
              })
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFFFFDE03),
        onPressed: addSub,
        tooltip: 'Add Subject',
        child: Icon(
          Icons.add,
          color: Colors.black,
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
