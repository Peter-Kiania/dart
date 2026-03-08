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
      home: const MyHomePage(title: 'Shopping List'),
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
  List<String> words =  [] ;
  List<int> quantity = [];
  late TextEditingController _controller;
  late TextEditingController _quantity;

  @override
  void initState(){
    super.initState();
    _controller = TextEditingController();
    _quantity = TextEditingController();
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
      body: listPage(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
      ),



    );
  }
  Widget listPage(){
    return Column(
        children:[
          Row( children:[
            Expanded(child: TextField(controller: _controller,
              decoration: InputDecoration(labelText: 'Type the item here',
                  border: OutlineInputBorder() ),)
             ),
            Expanded(child: TextField(controller: _quantity,
              decoration: InputDecoration(labelText: 'Type the quantity here',
              border: OutlineInputBorder()), )
             ),
            ElevatedButton( child:Text("Click here"), onPressed:() {
              setState(() {
                words.add( _controller.value.text );
                _controller.text = "";
                quantity.add(int.parse(_quantity.text));
                _quantity.text = "";

              });
            }, )]),
          Expanded(child:
          ListView.builder( itemCount:words.length,
              itemBuilder: (context, rowNum) {
                return
                  GestureDetector(
                      child: Row(mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("${rowNum + 1}."), Text(words[rowNum]),
                            Text(" quantity: ${quantity[rowNum]}")
                          ]), onLongPress: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context){
                          return AlertDialog(
                              title: const Text("Do you want to Delete the Item?"),
                              actions: [
                                TextButton(onPressed: () =>
                                    Navigator
                                        .of(context)
                                        .pop(),
                                    child: const Text("No")),
                                TextButton(onPressed: () {
                                  setState(() {
                                    words.removeAt(rowNum);
                                    quantity.removeAt(rowNum);
                                  });
                                  Navigator.of(context).pop();
                                }, child: const Text("Yes"))
                              ]
                          );

                            }

                        );}
                  );
              })
              )]);
  }
}
