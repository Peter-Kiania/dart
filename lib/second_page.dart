import 'package:flutter/material.dart';
import 'package:my_cst2335_labs/main.dart';
import 'package:url_launcher/url_launcher.dart';

class TheSecondPage extends StatelessWidget {
  const TheSecondPage({super.key});

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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SecondPage(title: 'Profile Page'),
    );
  }
}

  class SecondPage extends StatefulWidget{
    const SecondPage({super.key, required this.title});
    final String title;


  @override
  State<SecondPage> createState() => SecondPageState();
}


class SecondPageState extends State<SecondPage> {
  late TextEditingController _firstname;
  late TextEditingController _lastname;
  late TextEditingController _phonenumber;
  late TextEditingController _emailaddress;





  @override
  void initState() {
    super.initState();
    _firstname = TextEditingController();
    _lastname = TextEditingController();
    _phonenumber = TextEditingController();
    _emailaddress = TextEditingController();

    DataRepository.loadData(_firstname, _lastname, _phonenumber, _emailaddress);

    _firstname.addListener(() => DataRepository.saveData('fname', _firstname.text));
    _lastname.addListener(() => DataRepository.saveData('lname', _lastname.text));
    _phonenumber.addListener(() => DataRepository.saveData('phone', _phonenumber.text));
    _emailaddress.addListener(() => DataRepository.saveData('email', _emailaddress.text));

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Welcome Back ${DataRepository.loginName}"),
        ),
      );
    });
  }

  @override
  void dispose() {
    _firstname.dispose();
    _lastname.dispose();
    _phonenumber.dispose();
    _emailaddress.dispose();
    super.dispose();
  }

  void _showErrorDialog(String scheme) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Not Supported'),
        content: Text('The $scheme service is not supported on this device.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void smss() async {
    final Uri smsUri = Uri(
      scheme: 'sms',
      path: _phonenumber.text,
    );

    bool itCan = await canLaunchUrl(smsUri);

    if (itCan) {
      await launchUrl(smsUri);
    } else {
      _showErrorDialog('sms');
    }
  }
  void phoney() async {
    final Uri telUri = Uri(
      scheme: 'tel',
      path: _phonenumber.text,
    );

    bool itCan = await canLaunchUrl(telUri);

    if (itCan) {
      await launchUrl(telUri);
    } else {
      _showErrorDialog('tel');
    }
  }
  void emaily() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: _emailaddress.text,
    );
    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    } else {
      _showErrorDialog('mailto');
    }
  }

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
          mainAxisAlignment: MainAxisAlignment .start,
          children: [
            // Text('You have pushed the button this many times:', style: TextStyle(fontSize: myFontSize), ),
            // Text(
            //   '$_counter',
            //   style: TextStyle(fontSize: myFontSize),
            // ),
            // Slider(value: _counter, max: 100.0, onChanged: setNewValue,min: 0.0,),
            Text("Welcome back: "+ DataRepository.loginName, style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),),
            TextField(controller: _firstname,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "First Name"
              ),),
            TextField(controller: _lastname,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Last Name",),),
            Row( children: [ Flexible(child: TextField(controller: _phonenumber,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Phone Number",),))
                ,IconButton(icon: Icon(Icons.phone),onPressed: phoney,),
              IconButton(icon: Icon(Icons.sms),onPressed: smss,)])
            ,
            Row( children: [Flexible(child: TextField(controller: _emailaddress,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Email Address",),),),
              IconButton(icon: Icon(Icons.email),onPressed: emaily,)
            ])
            ,
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
