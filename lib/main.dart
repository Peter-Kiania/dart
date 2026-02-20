import 'package:flutter/material.dart';
import 'package:my_cst2335_labs/second_page.dart';
import 'package:my_cst2335_labs/data_repository.dart';
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
      initialRoute: '/',
      routes: {
        '/SecondPage': (context)=> TheSecondPage()
      },
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
  // var _counter = 0.0;
  // var myFontSize = 30.0;
  late TextEditingController _controller;
  late TextEditingController _password;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _password = TextEditingController();
    loadData();
  }
   void loadData() async {
     var loginName = await DataRepository.prefs.getString("LoginName");
     var passname = await DataRepository.prefs.getString("Password");
     if (_controller.text.isEmpty && _password.text.isEmpty) {
       if (loginName.isNotEmpty && passname.isNotEmpty) {
         setState(() {
           _controller.text = loginName;
           _password.text = passname;

           DataRepository.loginName= loginName;
         });
       }
     }
   }


  @override
  void dispose() {
    _controller.dispose();
    _password.dispose();
    super.dispose();
  }

  void buttonClicked() async{
    var loginName = await DataRepository.prefs.getString("LoginName");
    var passname = await DataRepository.prefs.getString("Password");

    if (loginName==_controller.text && passname == _password.text){
      DataRepository.loginName= loginName;
      Navigator.pushNamed(context, '/SecondPage');
    }
    else {
      showDialog(context: context, builder: (BuildContext context) => AlertDialog(
        title: const Text('Save Details?'),
        content: const Text('Do you want to save your username and password?'),
        actions: [ ElevatedButton(onPressed: onClicked, child: Text('Yes')),
          ElevatedButton(onPressed: onnotClicked, child: Text('No'))],
      ));
    }
    }



  void onClicked(){
    DataRepository.loginName= _password.text;
    DataRepository.prefs.setString("LoginName", _controller.text);
    DataRepository.prefs.setString("Password", _password.text).then((bool success){
      Navigator.pop(context);
      Navigator.pushNamed(context, '/SecondPage');

    });
  }


    void onnotClicked(){
      Navigator.pop(context);
      DataRepository.prefs.remove("LoginName");
      DataRepository.prefs.remove("Password");
    }



    // void _incrementCounter() {
    //   setState(() {
    //     if (_counter <99.0) {
    //       _counter++;
    //       myFontSize++;
    //     }
    //   });
    // }

    // void setNewValue(double value)
    // {
    //   setState(() {
    //     _counter = value;
    //     myFontSize= value;
    //   });
    // }

    @override
    Widget build(BuildContext context) {
      // This method is rerun every time setState is called, for instance as done
      // by the _incrementCounter method above.
      //
      // The Flutter framework has been optimized to make rerunning build methods
      // fast, so that you can just rebuild anything that needs updating rather
      // than having to individually change instances of widgets.
      return Scaffold(
        appBar: AppBar(
          // TRY THIS: Try changing the color here to a specific color (to
          // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
          // change color while the other colors stay the same.
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.title),
        ),
        body: Center(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child: Column(
            // Column is also a layout widget. It takes a list of children and
            // arranges them vertically. By default, it sizes itself to fit its
            // children horizontally, and tries to be as tall as its parent.
            //
            // Column has various properties to control how it sizes itself and
            // how it positions its children. Here we use mainAxisAlignment to
            // center the children vertically; the main axis here is the vertical
            // axis because Columns are vertical (the cross axis would be
            // horizontal).
            //
            // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
            // action in the IDE, or press "p" in the console), to see the
            // wireframe for each widget.
            mainAxisAlignment: .center,
            children: [
              // Text('You have pushed the button this many times:', style: TextStyle(fontSize: myFontSize), ),
              // Text(
              //   '$_counter',
              //   style: TextStyle(fontSize: myFontSize),
              // ),
              // Slider(value: _counter, max: 100.0, onChanged: setNewValue,min: 0.0,),
              TextField(controller: _controller,
                decoration: InputDecoration(hintText: "Enter your Login name",
                    border: OutlineInputBorder(),
                    labelText: "Login"
                ),),
              TextField(controller: _password,
                obscureText: true,
                decoration: InputDecoration(hintText: "Enter your Password",
                  border: OutlineInputBorder(),
                  labelText: "Password",),),
              ElevatedButton(onPressed: buttonClicked, child: Text("Login",)),
            ],
          ),
        ),


        // floatingActionButton: FloatingActionButton(
        //   onPressed: _incrementCounter,
        //   tooltip: 'Increment',
        //   child: const Icon(Icons.add),
        // ),
      );
    }
  }
