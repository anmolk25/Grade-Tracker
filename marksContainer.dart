import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grade_tracker/SubjectMarks.dart';
import 'package:page_transition/page_transition.dart';

class MarksContainer extends StatefulWidget {
  String subject;
  String marks;
  String totalMarks;
  String docId;
  MarksContainer(
      {Key key,
      @required this.docId,
      @required this.subject,
      @required this.marks,
      @required this.totalMarks})
      : super(key: key);

  @override
  _MarksContainerState createState() => _MarksContainerState();
}

class _MarksContainerState extends State<MarksContainer> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              PageTransition(
                  type: PageTransitionType.rightToLeft,
                  child: SubjectMarks(
                    docId: widget.docId,
                    subjectName: widget.subject)));
        },
        child: Card(
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Container(
              decoration: BoxDecoration(
                color: Colors.white, //Color(0xFFFF0266),
                borderRadius: BorderRadius.circular(15),
              ),
              // height: 80,
              width: double.infinity,
              padding: EdgeInsets.all(8),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(widget.subject,
                            style: GoogleFonts.aBeeZee(
                              textStyle: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 17),
                            )),
                        Text("${widget.marks}/${widget.totalMarks}",
                            style: GoogleFonts.aBeeZee(
                              textStyle: TextStyle(
                                  color: Color(0xFFFF0266),
                                  fontWeight: FontWeight.w800,
                                  fontSize: 16),
                            )),
                      ],
                    ),
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
