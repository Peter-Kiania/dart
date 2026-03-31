import 'package:floor/floor.dart';
import 'package:flutter/material.dart';
import 'package:my_cst2335_labs/Database.dart';
import 'package:my_cst2335_labs/Dao/ShoppingListDao.dart';
import 'package:my_cst2335_labs/Item.dart';

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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
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
  List<Item> item = [];
  Item? selectedItem = null;
  TextEditingController _controller = TextEditingController();
  TextEditingController _quantity = TextEditingController();
  late var dao;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async{
    AppDatabase database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
    dao = database.shoppinglistDao;
    final list = await dao.findAllItems();

    setState((){
      item = list;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _quantity.dispose();
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
        backgroundColor: Theme
            .of(context)
            .colorScheme
            .inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: reactiveLayout(),
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.



    );
  }
  Widget reactiveLayout(){
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;

    if( (width>height) && (width > 720)) {

      return Row( children:[
        Expanded(flex:2,child: listPage(),    ),
        Expanded(flex:3, child: detailsPage(), )
      ]);
    }

    else{
      if( selectedItem== null) {
        return listPage();
      }
      else{
        return detailsPage();
      }

    }
  }

  Widget detailsPage() {
    if(selectedItem != null){
      return Center(child:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        Text("Name: ${selectedItem!.name}", style: TextStyle(fontSize: 20.0),),
        Text("Quantity: ${selectedItem!.count}", style: TextStyle(fontSize: 20.0)),
          Text("DatabaseID: ${selectedItem!.id}", style: TextStyle(fontSize: 20.0)),
        ElevatedButton(onPressed: () async{
          dao.deleteItem(selectedItem!);
          setState(() {
            item.remove(selectedItem);
            selectedItem = null; });
          }, child: Text("Delete")),

        ElevatedButton(onPressed: (){
          setState(() { selectedItem = null; });
          }, child: Text("Close"))

      ],)
      );
    }
    else{
      return Text("Please select an item from the list",style: TextStyle(fontSize: 20.0));
    }
  }


  Widget listPage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: TextField(controller: _controller,
                decoration: InputDecoration(labelText: 'Type the item here',
                    border: OutlineInputBorder()),)
              ),
              Expanded(child: TextField(controller: _quantity,
                decoration: InputDecoration(labelText: 'Type the quantity here',
                    border: OutlineInputBorder()),)
              ),
              ElevatedButton(child: Text("Click here"), onPressed: ()async {
                if (_controller.text.isNotEmpty && _quantity.text.isNotEmpty){
                  final newItem = Item(
                      Item.ID++, _controller.text, int.parse(_quantity.value.text)
                  );
                  await dao.insertItem(newItem);

                  setState(() {
                    item.add(newItem);
                  });
                }})
            ]),
        Expanded(child: Builder(builder: (context) {
          if (item.isEmpty) {
            return const Text("There are no items in the list");
          }
          else {
            return ListView.builder(itemCount: item.length,
                itemBuilder: (context, rowNum) {
              return GestureDetector(
                  child: Row(mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("${rowNum + 1}."), Text(item[rowNum].name),
                        Text(" quantity:  ${item[rowNum].count}")
                      ]), onLongPress: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                              title: const Text(
                                  "Do you want to Delete the Item?"),
                              actions: [
                                TextButton(onPressed: () =>
                                    Navigator.of(context).pop(),
                                    child: const Text("No")),
                                TextButton(onPressed: () async {
                                  final items = item[rowNum];
                                  dao.deleteItem(items);
                                  setState(() {
                                    item.removeAt(rowNum);
                                  });
                                  Navigator.of(context).pop();
                                  }, child: const Text("Yes"))
                              ]
                          );
                        }
                        );
                  }
                  );
            }
            );
          }
        }),),
      ],
    );
  }
}