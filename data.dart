import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';

class Data {
  static String email;
  static String docId;

  static updateProfile() async {
    var snapshot = await FirebaseFirestore.instance
        .collection('Users')
        .doc(Data.docId)
        .get();

    var data = snapshot.data();
    var min2 = 0;
    var prep = data['prep'];
    var stress = data['stress'];
    var sleep = data['sleep'];
    var health = data['health'];
    min2 = min(prep, stress);
    min2 = min(min2, sleep);
    min2 = min(min2, health);

    var tot = (data['marks'] / (data['totalMarks'] ?? 1)) * 100;

    FirebaseFirestore.instance
        .collection('Users')
        .doc(Data.docId)
        .update({'balance': min2, 'percent': tot});
  }
}

class Component {
  final String name;
  final double marks;
  final double max;

  Component({this.max, this.marks, this.name});
}
