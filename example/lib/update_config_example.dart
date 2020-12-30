import 'package:catcher/catcher.dart';
import 'package:flutter/material.dart';

Catcher catcher;

main() {
  CatcherOptions debugOptions = CatcherOptions(DialogReportMode(), [
    //EmailManualHandler(["recipient@email.com"]),
    HttpHandler(HttpRequestType.post,
        Uri.parse("https://jsonplaceholder.typicode.com/posts"),
        printLogs: true),
    ConsoleHandler()
  ]);
  CatcherOptions releaseOptions = CatcherOptions(PageReportMode(), [
    EmailManualHandler(["recipient@email.com"])
  ]);

  catcher = Catcher(MyApp(),
      debugConfig: debugOptions, releaseConfig: releaseOptions);
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: Catcher.navigatorKey,
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Plugin example app'),
          ),
          body: ChildWidget()),
    );
  }
}

class ChildWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(children: [
        FlatButton(
          child: Text("Change config"),
          onPressed: () => changeConfig(),
        ),
        FlatButton(
          child: Text("Generate error"),
          onPressed: () => generateError(),
        ),
      ]),
    );
  }

  void generateError() async {
    Catcher.sendTestException();
  }

  void changeConfig() {
    catcher.updateConfig(
      debugConfig: CatcherOptions(
        PageReportMode(),
        [ConsoleHandler()],
      ),
    );
  }
}
