library CHOOSERANDOM;

import '../Game.dart';

class ChooseRandom
{
  List<List> list = [];
  int weightSum = 0;
  
  ChooseRandom({List loopList : null})
  {
    if(loopList != null)
    for(int i = 0, length = loopList.length; i < length; i++)
    {
      this.weightSum += loopList[i][0];
      this.list.add([loopList[i][1], loopList[i][0]]);
    }
  }
  
  void add(dynamic obj, int weight)
  {
    this.weightSum += weight;
    this.list.add([obj, weight]);
  }
  
  dynamic pick()
  {
    int randomNum = RNG.nextInt(weightSum);
    for(int i = 0, length = list.length; i < length; i++)
    {
      if(randomNum < list[i][1])
        return list[i][0];
      randomNum -= list[i][1];
    }
    
    return "derp, check class ChooseRandom";
  }
}