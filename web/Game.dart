library GAME;

import 'World.dart';
import 'Display.dart';
import 'Input.dart';
import 'dart:math';
import 'dart:html' hide Player;
import 'Player.dart';
import 'Entity.dart';

World world;
Display display;
Input input;
bool allVisible = true;
Random RNG;
Element playerStats;
Element enemyStats;
Element narration;
Element decision;

class Game 
{
  int seed;
  int randMax = 1 << 32;
  
  Game()
  {
    addDefineElements();
    if (window.location.href.contains("?")) 
    {
      try
      {
        seed = int.parse(window.location.href.split("?")[1]);
      }
      on FormatException
      {
        seed = new Random().nextInt(randMax);
      }
    }
    else
    {
      seed = new Random().nextInt(randMax);
    }
    
    print("Seed: " + "$seed");
    RNG = new Random(seed);
    world = new World(100, 50);
    display = new Display();
    input = new Input();
  }
}

dynamic getRandomWeighted(List chanceList)
{
  int rndNum = RNG.nextInt(100) + 1;
  
  int chanceAdd = 0;
  for(int i = 0; i < chanceList.length; i++)
  {
    chanceAdd = chanceAdd + chanceList[i][0];
    
    if(rndNum <= chanceAdd)
    {
      return chanceList[i][1];
    }
  }
  
  return "getRandomWeighted in class game.dart";
}

int getPosOrNeg(int number, int range)
{
  return number + (RNG.nextBool() ? -RNG.nextInt(range) : RNG.nextInt(range));
}

void addDefineElements()
{
  playerStats = makeStats("player");
  querySelector("#HUD").children.add(playerStats);
  playerStats = querySelector("#playerStats");
  
  enemyStats = makeStats("enemy");
  querySelector("#HUD").children.add(enemyStats);
  enemyStats = querySelector("#enemyStats");
  enemyStats.style.opacity = "0";
  
  narration = querySelector("#narration");
  
  decision = new Element.div();
  decision.id = "decision";
  Element title = new Element.div();
  title.text = "Decision";
  title.className = "statTitle";
  decision.children.add(title);
  Element ynHolder = new Element.div();
  ynHolder.id = "ynHolder";
  Element yes = new Element.div();
  yes.text = "YES";
  yes.className = "choice";
  Element no = new Element.div();
  no.text = "NO";
  no.className = "choice";
  ynHolder.children.add(yes);
  ynHolder.children.add(no);
  decision.children.add(ynHolder);
  querySelector("#narrationHolder").children.add(decision);
  decision = querySelector("#decision");
  decision.style.opacity = "0";
  
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
  //HP.className = "statTitle";
  HP.text = "HP:";
  stats.children.add(HP);
  
  Element atk = new Element.div();
  //atk.className = "statTitle";
  atk.text = "ATK:";
  stats.children.add(atk);
  
  Element def = new Element.div();
  //def.className = "statTitle";
  def.text = "DEF:";
  stats.children.add(def);
  
  Element weapon = new Element.div();
  //def.className = "statTitle";
  weapon.text = "WEAPON:";
  stats.children.add(weapon);
  
  Element armor = new Element.div();
  //def.className = "statTitle";
  armor.text = "ARMOR:";
  stats.children.add(armor);
  
  Element items = new Element.div();
  items.className = "itemsStat";
  items.text = "Items:";
  stats.children.add(items);
  
  return stats;
}

void refreshStats(dynamic entity)
{
  var el;
  Entity ent = entity;
  if(entity is Player)
  {
    el = playerStats;
  }
  else
  {
    el = enemyStats;
    el.style.opacity = "1";
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
  
  while(narration.children.length > 10)
  {
    narration.children.first.remove();
  }
  
  for(int i = narration.children.length - 1; i > 0; i)
  {
    narration.children[i].style.opacity = "${(i+1)/10}";
    i--;
  }
}