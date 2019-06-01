import 'dart:convert';

import 'package:flutter/material.dart';

void main() {
  runApp(new MaterialApp(
    home: new MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  MyAppState createState() => new MyAppState();
}

class MyAppState extends State<MyApp> {
  List data;
  static List<CustomPopupMenu> choices = <CustomPopupMenu>[
    CustomPopupMenu(title: 'Globant', icon: Icons.computer,company:'data_repo/globant_data.json' ),
    CustomPopupMenu(title: 'Infosys', icon: Icons.bookmark,company:'data_repo/infosys_data.json'),
    CustomPopupMenu(title: 'TCS', icon: Icons.settings,company:'data_repo/starwars_data.json'),
  ];

  CustomPopupMenu _selectedChoices = choices[0];

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
            bottom: PreferredSize(child: Container(color: Colors.orange, height: 4.0,)),
            title: new Text("Jobs @ Here: Globant"),
//            actions: <Widget>[
////            new IconButton( icon: new Icon(Icons.location_on) ),],
//              PopupMenuButton(
//                itemBuilder: (BuildContext context) {
//                  return [
//                    PopupMenuItem(child: IconButton(
//                      icon: Icon(Icons.location_on),
//                      onPressed: () {
//                        clicked(context, "Email sent");
//                      },
//                    ),),
//                  ];
//                },
//              ),]

          actions: <Widget>[
            PopupMenuButton<CustomPopupMenu>(
              elevation: 3.2,
              initialValue: choices[1],
              onCanceled: () {
                print('You have not chossed anything');
              },
              tooltip: 'This is tooltip',
              onSelected: _select,
              itemBuilder: (BuildContext context) {
                return choices.map((CustomPopupMenu choice) {
                  return PopupMenuItem<CustomPopupMenu>(
                    value: choice,
                    child: Text(choice.title),
                  );
                }).toList();
              },
            )
          ],
        ),


        body: new Container(
          child: new Center(
            // Use future builder and DefaultAssetBundle to load the local JSON file
            child: new FutureBuilder(
                future: DefaultAssetBundle
                    .of(context)
//                    .loadString(_selectedChoices.company),
            .loadString('data_repo/starwars_data.json'),
                builder: (context, snapshot) {
                  // Decode the JSON
                  var new_data = json.decode(snapshot.data.toString());

                  return new ListView.builder(
                    // Build the ListView
                    itemBuilder: (BuildContext context, int index) {
                      return new Card(
                        child: new Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            new RichText(
                              text: TextSpan(
                                style: DefaultTextStyle.of(context).style,
                                children: <TextSpan>[
                                  TextSpan(text: 'Role: ', style: TextStyle(fontWeight: FontWeight.bold)),
                                  TextSpan(text:  new_data[index]['Role']),
                                ],
                              ),
                            )
//1
                            ,new RichText(
                              text: TextSpan(
                                style: DefaultTextStyle.of(context).style,
                                children: <TextSpan>[
                                  TextSpan(text: 'Experience: ', style: TextStyle(fontWeight: FontWeight.bold)),
                                  TextSpan(text: new_data[index]['Experience']),
                                ],
                              ),
                            )
//1
                            ,new RichText(
                              text: TextSpan(
                                style: DefaultTextStyle.of(context).style,
                                children: <TextSpan>[
                                  TextSpan(text: 'Skills: ', style: TextStyle(fontWeight: FontWeight.bold)),
                                  TextSpan(text: new_data[index]['Skills']),
                                ],
                              ),
                            )
                            ,new RichText(
                              text: TextSpan(
                                style: DefaultTextStyle.of(context).style,
                                children: <TextSpan>[
                                  TextSpan(text: 'Pay: ', style: TextStyle(fontWeight: FontWeight.bold)),
                                  TextSpan(text: new_data[index]['ps']),
                                ],
                              ),
                            )
//1
                            ,new RichText(
                              text: TextSpan(
                                style: DefaultTextStyle.of(context).style,
                                children: <TextSpan>[
                                  TextSpan(text: "Job Description: ", style: TextStyle(fontWeight: FontWeight.bold)),
                                  TextSpan(text: new_data[index]['jd']),
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    },
                    itemCount: new_data == null ? 0 : new_data.length,
                  );
                }),
          ),
        ));
  }

  void clicked(BuildContext context, menu) {
    final scaffold = Scaffold.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: Text(menu),
        action: SnackBarAction(
            label: 'UNDO',
            onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }
  void _select(CustomPopupMenu choice) {
    setState(() {
      _selectedChoices = choice;
    });
  }

}
class CustomPopupMenu {
  CustomPopupMenu({this.title, this.icon,String company});

  String title;
  IconData icon;
  String company;
}
class SelectedOption extends StatelessWidget {
  CustomPopupMenu choice;

  SelectedOption({Key key, this.choice}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              choice.title,
              style: TextStyle(color: Colors.green, fontSize: 30),
            )
          ],
        ),
      ),
    );
  }
}