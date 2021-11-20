import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:env_manager/env_manager.dart' as env;
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await env.locateAndLoad([
    env.EnvironmentFileLoader("myEnvName", await rootBundle.loadString("envdir/application.yaml")),
  ]);

  //Optional
  env.useProductionEnvironment(true);

  runApp(MaterialApp(
    title: env.get("myEnvName")["application_name"],
    home: const MyApplication(),
  ));
}

class MyApplication extends StatefulWidget {
  const MyApplication({Key? key}) : super(key: key);

  @override
  _MyApplicationState createState() => _MyApplicationState();
}

class _MyApplicationState extends State<MyApplication> {
  @override
  void initState() {
    super.initState();

    env.useProductionEnvironment(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Text(env.get("myEnvName")["my_env_variable"]),
      ),
    );
  }
}
