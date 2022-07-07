import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences? _sharedPreferences;

Future<Null> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  _sharedPreferences = await SharedPreferences.getInstance();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Shared Preferences'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, this.title}) : super(key: key);
  final String? title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _notification = true;
  String _string = '';

  void _update(bool value) {
    setState(() {
      _notification = value;
      _string =
      _notification ? 'Notificações Ativada' : 'Notificações Desativada';
    });
    _sharedPreferences?.setBool('_notification', value);
  }

  @override
  void initState() {
    // TODO: implement initState
    var value = _sharedPreferences?.getBool('_notification') ?? false;
    _update(value);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title!),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(_string),
            Switch(
              onChanged: (bool value) {
                _update(value);
              },
              value: _notification,
            ),
          ],
        ),
      ),
    );
  }
}