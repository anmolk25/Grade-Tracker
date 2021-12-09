import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pie_chart/pie_chart.dart';

class ExpandMarks extends StatefulWidget {
  final String componentName;
  final double marks;
  final double maxMarks;
  final int stress;
  final int sleep;
  final int prep;
  final int health;
  final String docId;
  double percent;

  ExpandMarks(
      {this.percent,
      @required this.componentName,
      @required this.docId,
      @required this.sleep,
      @required this.stress,
      @required this.health,
      @required this.prep,
       this.marks,
       this.maxMarks});

  ExpandMarkstate createState() => ExpandMarkstate();
}

class ExpandMarkstate extends State<ExpandMarks> {
  Map<String, double> dataMap = {
    "Preperation": 8,
    "Stress Level": 3,
    "Average Sleep": 2,
    "Health Level": 2,
  };

  @override
  void initState() {
    super.initState();

    dataMap = {
      "Preperation": widget.prep.toDouble(),
      "Stress Level": widget.stress.toDouble(),
      "Average Sleep": widget.sleep.toDouble(),
      "Health Level": widget.health.toDouble(),
    };
  }

  Widget build(BuildContext context) {
    return Card(
      elevation: widget.percent != null ? 0 : 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Container(
          color: Colors.white,
          child: ExpansionTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("${widget.componentName}  ",
                    style: GoogleFonts.aBeeZee(
                        textStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ))),
                Text(
                    widget.percent != null
                        ? "${widget.percent} %"
                        : "(${widget.marks}/${widget.maxMarks})",
                    style: GoogleFonts.aBeeZee(
                        textStyle: TextStyle(
                      color: Color(0xFFFF0266),
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ))),
              ],
            ),
            //     textAlign: TextAlign.center,

            children: <Widget>[
              /*  Container(
                //height: 100,
                child: Image.asset("assets/chart.png"),
              ),
             */
              PieChart(
                dataMap: dataMap,
                centerText: widget.percent != null ? "" : widget.componentName,
                chartValuesOptions: ChartValuesOptions(
                  showChartValueBackground: true,
                  showChartValuesInPercentage: true,
                  showChartValuesOutside: false,
                  decimalPlaces: 1,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
