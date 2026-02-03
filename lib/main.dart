import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),

      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var beef = AssetImage("images/beef.jpg");
  var chicken = AssetImage("images/Chicken.jpg");
  var pork = AssetImage("images/Pork.jpg");
  var seafood = AssetImage("images/seafood.jpg");
  var maindishes = AssetImage("images/Maindishes.jpg");
  var salad = AssetImage("images/salad.jpg");
  var sidedishes = AssetImage("images/sidedishes.jpg");
  var crockpot = AssetImage("images/crockpot.jpg");
  var icecream = AssetImage("images/icecream.jpg");
  var brownies = AssetImage("images/brownies.jpg");
  var cookies = AssetImage("images/cookies.jpg");
  var pies = AssetImage("images/pies.jpg");


  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(

      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(children:[ Text('BROWSE CATEGORIES', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, letterSpacing: 4.0),),
              Text("Not sure about exactly which recipe you're looking for? Do a search, or dive into or most popular categories. ", style: TextStyle(fontSize: 24),),]),
            Column(
            children:[ Text('BY MEAT' , style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, letterSpacing: 4.0)),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CircleAvatar(backgroundImage: beef,radius: 100, child: const Text('BEEF', style: TextStyle(color: Colors.black, fontSize: 28),)),
              CircleAvatar(backgroundImage: chicken,radius: 100, child: const Text('CHICKEN', style: TextStyle(color: Colors.black, fontSize: 28),),),
              CircleAvatar(backgroundImage: pork,radius: 100, child: const Text('PORK', style: TextStyle(color: Colors.black, fontSize: 28),),),
              CircleAvatar(backgroundImage: seafood,radius: 100, child: const Text('SEAFOOD', style: TextStyle(color: Colors.black, fontSize: 28),),)
            ])]),
            Column(
                children:[ Text('BY COURSE' , style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, letterSpacing: 4.0)),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CircleAvatar(backgroundImage: maindishes,radius: 100, child: const Text('MAINDISHES', style: TextStyle(color: Colors.white, fontSize: 24),)),
                        CircleAvatar(backgroundImage: salad,radius: 100, child: const Text('SALAD RECIPES', style: TextStyle(color: Colors.white, fontSize: 20),),),
                        CircleAvatar(backgroundImage: sidedishes,radius: 100, child: const Text('SIDE DISHES', style: TextStyle(color: Colors.white, fontSize: 20),),),
                        CircleAvatar(backgroundImage: crockpot,radius: 100, child: const Text('CROCKPOT', style: TextStyle(color: Colors.white, fontSize: 20),),)
                      ])]),
            Column(
                children:[ Text('BY DESSERT' , style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, letterSpacing: 4.0)),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CircleAvatar(backgroundImage: icecream,radius: 100, child: const Text('ICE CREAM', style: TextStyle(color: Colors.white, fontSize: 28),)),
                        CircleAvatar(backgroundImage: brownies,radius: 100, child: const Text('BROWNIES', style: TextStyle(color: Colors.white, fontSize: 28),),),
                        CircleAvatar(backgroundImage: pies,radius: 100, child: const Text('PIES', style: TextStyle(color: Colors.white, fontSize: 28),),),
                        CircleAvatar(backgroundImage: cookies,radius: 100, child: const Text('COOKIES', style: TextStyle(color: Colors.white, fontSize: 28),),)
                      ])]),

          ]




        ),
      ),

    );
  }
}
