
import 'package:flutter_flurry_drawer/flutter_flurry_drawer.dart';
import 'package:flutter/material.dart';

final Screen fourthscreen = new Screen(
    contentBuilder: (BuildContext context) {
      return new Center(
        child: new Container(
          height:100.0,
          child: new Padding(
            padding: const EdgeInsets.all(25.0),
            child: new Column(
              children: [
                new Expanded(
                    child: new Center(
                        child: new Text('BOiiiiiiii')
                    )
                )
              ],
            ),
          ),
        ),

      );
    }
);