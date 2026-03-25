import 'package:floor/floor.dart';
import 'package:my_cst2335_labs/Item.dart';
@dao
abstract class ShoppingListDao {

  @Query('SELECT * FROM Item')
  Future<List<Item>> findAllItems();


  @delete
  Future<void> deleteItem(Item p);

  @insert
  Future<void> insertItem(Item item);
}