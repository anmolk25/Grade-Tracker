import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'data.dart';

class SimpleBarChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  SimpleBarChart(this.seriesList, {this.animate});

  /// Creates a [BarChart] with sample data and no transition.
  factory SimpleBarChart.withSampleData(List<Component> data) {
    return new SimpleBarChart(
      _createSampleData(data),
      // Disable animations for image tests.
      animate: true,
    );
  }


  @override
  Widget build(BuildContext context) {
    return new charts.BarChart(
      seriesList,
      animate: animate,
    );
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<Component, String>> _createSampleData(List<Component> components) {
  
    

    return [
      new charts.Series<Component, String>(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.indigo.shadeDefault,
        domainFn: (Component sales, _) => sales.name,
        measureFn: (Component sales, _) => sales.marks,
        data: components,
      )
    ];
  }
}

