import 'package:flutter/material.dart';
import 'package:flutter_app/widgets/text_icon.dart';
import 'package:flutter_app/widgets/feels_icon.dart';
//import 'package:flutter_app/models/user.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_session/flutter_session.dart';

class RelationSlider extends StatefulWidget {
  @override
  _RelationSlider createState() => _RelationSlider();
}

class _RelationSlider extends State<RelationSlider> {
  double _currentSliderValue = 50;
  bool _isClicked = false;
  String username = "Fede";
  Map<String, dynamic> data = {};

  Map<String, String> newUser = {};

  final FlutterLocalNotificationsPlugin fltrNotification =
      FlutterLocalNotificationsPlugin();
  @override
  void initState() {
    super.initState();

    // Future<dynamic> _userFuture = Future<dynamic>.value(getUser());
    const AndroidInitializationSettings androidInitialize =
        AndroidInitializationSettings('lovemeter');
    const IOSInitializationSettings iOSinitialize = IOSInitializationSettings();
    final InitializationSettings initializationsSettings =
        InitializationSettings(android: androidInitialize, iOS: iOSinitialize);
    //fltrNotification = new FlutterLocalNotificationsPlugin();
    fltrNotification.initialize(initializationsSettings,
        onSelectNotification: notificationSelected);
  }

  Future notificationSelected(String payload) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Text("Love has been sent..."),
      ),
    );
  }

  Future _showNotification() async {
    var androidDetails = new AndroidNotificationDetails(
        "Channel ID", "Desi programmer", "This is my channel",
        importance: Importance.max);
    var iSODetails = new IOSNotificationDetails();
    var generalNotificationDetails =
        new NotificationDetails(android: androidDetails, iOS: iSODetails);

    fltrNotification.show(
        1,
        "Lovemeter in: ",
        _currentSliderValue.toInt().toString() + " %",
        generalNotificationDetails);
  }

  Widget createListView(BuildContext context, AsyncSnapshot snapshot) {
    var values = snapshot.data;
    return SizedBox(
      height: 200, // constrain height
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: values.length,
        itemBuilder: (BuildContext context, int index) {
          return values.isNotEmpty
              ? Column(
                  children: <Widget>[
                    ListTile(
                      title: Text(values[index].username),
                    ),
                    Text(values[index].score),
                    Divider(
                      height: 2.0,
                    ),
                  ],
                )
              : CircularProgressIndicator();
        },
      ),
    );
  }

  Future _updateUserDBState() async {
    //update the user data with the new value from the slider
    // _currentSliderValue
    dynamic _email = await FlutterSession().get("authToken");
    String score = _currentSliderValue.toInt().toString();

    Future<http.Response> response =
        http.put(Uri.http("10.0.2.2:4000", "/api/users/update"),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(<String, String>{
              'email': _email,
              'score': score,
            }));
    response.then((value) => {
          print('Update account...'),
          print('Update account...${value.statusCode}'),
          if (value.statusCode == 404)
            {
              print('Backend message: ${value.statusCode}'),
              //todo: send error message to UI
            }
          else
            {
              data = jsonDecode(value.body),
              if (data['status'] == "200")
                {
                  print('Backend message, ${data['message']}!'),
                  print('Start sending notification...'),
                  _showNotification(),
                }
              else if (data['status'] == "500")
                {print('Backend message Error: , ${data['message']}!')}
            }
        });
    response.catchError((onError) => {print('Servers Down!')});

    // print('Howdy, ${data['users']}!');
    // debugPrint(response);
  }

  Future getUsersData() async {
    /*  List<User> _userData = await DBProvider.db.getUser();
    return _userData;

   */
    /*final Future futureDB = dbconn.initDB();
    return futureDB.then((db) {
      Future<List<Trans>> futureTrans = dbconn.trans();
      futureTrans.then((transList) {
        setState(() {
          this.transList = transList;
        });
      });
    });*/
  }

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text("How is your Relation ?",
          style: TextStyle(
              fontSize: 30, color: Colors.blue, fontWeight: FontWeight.bold)),
      Padding(
        padding: EdgeInsets.only(top: 0.0, bottom: 0.0),
        child: Slider(
          value: _currentSliderValue,
          min: 0,
          max: 100,
          divisions: 4,
          label: _currentSliderValue.round().toString(),
          onChanged: (double value) {
            setState(() {
              _currentSliderValue = value;
              _isClicked = false;
              //_userFuture = getUser();
            });
          },
        ),
      ),
      FeelsIcon(_currentSliderValue.round().toString()),
      Opacity(
        opacity: _isClicked ? 0.0 : 1.0,
        child: Padding(
            padding: EdgeInsets.only(top: 0.0, bottom: .0),
            child: RaisedButton(
              onPressed: () {
                setState(() {
                  _isClicked = true;
                });
                /* var newDBUser = User(
                    username: username, score: _currentSliderValue.toString());

                DBProvider.db.newUser(newDBUser);

                */
                _updateUserDBState();
              },
              textColor: Colors.white,
              padding: const EdgeInsets.all(0.0),
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: <Color>[
                      Color(0xFF0D47A1),
                      Color(0xFF1976D2),
                      Color(0xFF42A5F5),
                    ],
                  ),
                ),
                padding: const EdgeInsets.all(20.0),
                child: const Text('Send IT!!!', style: TextStyle(fontSize: 20)),
              ),
            )),
      ),
      Opacity(
        opacity: _isClicked ? 1.0 : 0.0,
        child: Padding(
            padding: EdgeInsets.only(top: 0.0, bottom: 00.0),
            child: Text(
                _currentSliderValue == 100
                    ? "Now just wait and Enjoy!!!"
                    : _currentSliderValue == 75
                        ? "Live the Moment!!!"
                        : _currentSliderValue == 50
                            ? "Let's put us Together!!!"
                            : _currentSliderValue == 25
                                ? "Come on!!!"
                                : "Fuck Off!!!",
                style: TextStyle(
                    fontSize: 30,
                    color: _currentSliderValue == 100
                        ? Colors.red
                        : _currentSliderValue == 75
                            ? Colors.green
                            : _currentSliderValue == 50
                                ? Colors.green
                                : _currentSliderValue == 25
                                    ? Colors.amber
                                    : Colors.red,
                    fontWeight: FontWeight.bold))),
      ),
      Padding(
          padding: EdgeInsets.only(top: 0.0, bottom: 0.0),
          child: FutureBuilder(
            future: getUsersData(),
            initialData: [],
            builder: (context, snapshot) {
              if (snapshot.data != null && snapshot.connectionState != null)
                return createListView(context, snapshot);

              return Text('HI');
              /*if (snapshot != null && snapshot.connectionState != null) {
                if (!newUser.containsKey('username')) {
                  newUser = Map<String, String>.from(snapshot.data);
                }
                return createListView(context, snapshot);
               //return Column(children: <Widget>[createListView]);
              } else {
                return Text('HI');
              }*/
            },
          ))
    ]);
  }
}
