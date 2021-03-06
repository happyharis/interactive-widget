/// Flutter code sample for InteractiveViewer.constrained

// This example shows how to create a pannable table. Because the table is
// larger than the entire screen, setting `constrained` to false is necessary
// to allow it to be drawn to its full size. The parts of the table that
// exceed the screen size can then be panned into view.

import 'package:flutter/material.dart';

/// This is the main application widget.
class MyThirdApp extends StatelessWidget {
  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: AppBar(title: const Text(_title)),
        body: MyStatelessWidget(),
      ),
    );
  }
}

/// This is the stateless widget that the main application instantiates.
class MyStatelessWidget extends StatelessWidget {
  MyStatelessWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const int _rowCount = 20;
    const int _columnCount = 3;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pannable Table'),
      ),
      body: InteractiveViewer(
        constrained: false,
        scaleEnabled: false,
        child: Table(
          columnWidths: <int, TableColumnWidth>{
            for (int column = 0; column < _columnCount; column += 1)
              column: const FixedColumnWidth(300.0),
          },
          children: <TableRow>[
            for (int row = 0; row < _rowCount; row += 1)
              TableRow(
                children: <Widget>[
                  for (int column = 0; column < _columnCount; column += 1)
                    Container(
                      height: 100,
                      color:
                          row % 2 + column % 2 == 1 ? Colors.red : Colors.green,
                    ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
