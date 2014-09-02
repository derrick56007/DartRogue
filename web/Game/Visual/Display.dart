library DISPLAY;

import 'dart:html' hide Player;
import '../Game.dart';
import '../../Entity/Entity.dart';
import '../../Entity/Player/Player.dart';
import 'DialogBox.dart';

Element playerStats;
Element enemyStats;
Element narration;
DialogBox dialogBox;

class Display
{
  final Element display = querySelector("#display");

  Display()
  {
    dialogBox = new DialogBox(["derrrrpdddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd", "herputy"]);
    defineElements();
  }

  void displayWorld()
  {
    display.children.clear();
    for(int i = 0, length = world.grid.nodes.length; i < length; i++)
    {
      String lineText = "";
      for(int j = 0, length2 = world.grid.nodes[i].length; j < length2; j++)
      {
        lineText = lineText + (world.grid.nodes[i][j].isVisible ? world.grid.nodes[i][j].toString() : "●");
      }
      Element line = new Element.div();
      line.text = lineText;
      line.className = "worldLine";
      display.children.add(line);
    }
  }

  void defineElements()
  {
    playerStats = makeStats("player");
    enemyStats = makeStats("enemy");
    querySelector("#HUD").children.add(playerStats);
    querySelector("#HUD").children.add(enemyStats);
    enemyStats.style.opacity = "0";
    narration = querySelector("#narration");

    for(int i = 0; i < 9; i++)
    {
      addToNarration(" ", "black");
    }
  }

  Element makeStats(String statName)
  {
    Element stats = new Element.div();
    stats.id = "${statName}Stats";
    stats.className = "stats";

    Element name = new Element.div();
    name.className = "statTitle";
    name.text = statName.toUpperCase();
    stats.children.add(name);

    Element HP = new Element.div();
    HP.text = "HP:";
    stats.children.add(HP);

    Element atk = new Element.div();
    atk.text = "ATK:";
    stats.children.add(atk);

    Element def = new Element.div();
    def.text = "DEF:";
    stats.children.add(def);

    Element weapon = new Element.div();
    weapon.text = "WEAPON:";
    stats.children.add(weapon);

    Element armor = new Element.div();
    armor.text = "ARMOR:";
    stats.children.add(armor);

    Element items = new Element.div();
    items.className = "itemsStat";
    items.text = "Items:";
    stats.children.add(items);

    return stats;
  }

  void refreshStats(Entity ent)
  {
    Element el;
    if(ent is Player)
    {
      el = playerStats;
    }
    else
    {
      el = enemyStats;
      el.style.opacity = "1";
      el.children[0].text = "${ent.type.NAME}".toUpperCase();
    }

    el.children[1].text = "HP: ${ent.HP}/${ent.MAXHP}";
    el.children[2].text = "ATK: ${ent.atk} +${ent.weapon.atk}";
    el.children[3].text = "DEF: ${ent.def} +${ent.armor.def}";
    el.children[4].text = "WEAPON: ${ent.weapon.NAME} +${ent.weapon.atk} atk";
    el.children[5].text = "ARMOR: ${ent.armor.NAME} +${ent.armor.def} def";
    el.children[6].text = "ITEMS: ${ent.itemToString()}";
  }

  void addToNarration(String text, String color)
  {
    Element line = new Element.div();
    line.className = "narrationLine";
    line.style.color = color;
    line.text = text;
    narration.children.add(line);
    narration.scrollTop = narration.scrollHeight;

    while( narration.children.length > 10)
    {
      narration.children.first.remove();
    }

    for(int i = narration.children.length - 1; i > 0;)
    {
      narration.children[i].style.opacity = "${(i+1)/10}";
      i--;
    }
  }
}