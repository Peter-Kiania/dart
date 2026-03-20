import 'package:floor/floor.dart';

@entity
class Item {

  static int ID = 1;

  @primaryKey
  final int id;

  final String name;
  final int count;


Item (this.id, this.name, this.count){
  if (id>= ID) {
    ID = id +1;
  }
}
}