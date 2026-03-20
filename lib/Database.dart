import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;


import 'package:my_cst2335_labs/Dao/ShoppingListDao.dart';
import 'package:my_cst2335_labs/Item.dart';


part 'Database.g.dart';

@Database(version: 1, entities: [Item])
abstract class AppDatabase extends FloorDatabase {
  ShoppingListDao get shoppinglistDao;
}