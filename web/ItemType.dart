library ITEMTYPE;

import 'Enum.dart';

class ItemType<String> extends Enum<String, String>
{
  const ItemType(String val, String name) : super(val, name);
  
  static const ItemType KEY = const ItemType("K", "key");
  static const ItemType TREASURECHEST = const ItemType("T", "treasure chest");
}