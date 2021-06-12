import 'package:flutter/material.dart';
import 'package:peek/screens/home.dart';
import 'package:graphql_flutter/graphql_flutter.dart';


//TODO: build with web-renderer
//TODO: change icons, favicon

void main() async {
  await initHiveForFlutter();

  final Link apiLink = HttpLink("https://api.graphql.jobs/");

  ValueNotifier<GraphQLClient> client = ValueNotifier(
    GraphQLClient(
      link: apiLink,
      cache: GraphQLCache(store: HiveStore()),
    ),
  );

  runApp(
      GraphQLProvider(
        child: MyApp(),
        client: client,
      )
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Peek',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        primaryColor: Color(0xFF543855),
        accentColor: Color(0xFFF49CAB),
        canvasColor: Color(0xFFC2CBE6),
        backgroundColor: Color(0xFF94A1C8),
        cardColor: Color(0xFFFFA175),
        highlightColor: Color(0xFFFEF9DD),
        hintColor: Color(0xFFF49CAB),
        fontFamily: "Montserrat"
      ),
      home: HomePage(),
    );
  }
}

