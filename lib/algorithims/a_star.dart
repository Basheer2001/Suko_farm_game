

import 'dart:collection';
import 'package:untitled4/Logic/logic.dart';

import '../Components/pair.dart';

class AStar {
  List<Map<List<Logic?>,int>>getGoalPath =[];
  List<Logic>goal=[];
  Logic startNode;
  AStar(this.startNode);
  List<List> seedtohole = [];
  List<List> seedtofarmer = [];



  void travers(){

    Queue<Logic> q =  Queue();
    q.add(startNode);
    while(q.isNotEmpty){

      Logic current = q.last;
      if(!current.isvisited){
        if(current.checkwin()){
          goal.add(current);
        }
        current.isvisited=true;
        q.removeLast();
        current.addNextStates();
        q.addAll(current.nextStates);
      }
      else {
        q.removeLast();
      }
    }
  }


  void getPath(Logic goal){
    int cost=1;
    int heuristic=getheuristic();
    int tCost =0;
    List<Logic?>list=[];
    list.add(goal);
    while(goal.father!=null){
      list.add(goal.father);
      goal=goal.father!;
      cost++;
    }
    tCost = cost+heuristic;
    List<Logic?>listtemp = list;
    list=listtemp.reversed.toList();
    getGoalPath.add({list: tCost});
  }

  int getheuristic(){
    startNode.seedPosition();
    startNode.holePosition();
    startNode.farPosition();
    startNode.holes.forEach((hole) {
      startNode.seeds.forEach((seed) {
        seedtohole.add([hole,seed,(hole.x - seed.x) + (hole.y-seed.y)]);
      });
    });
    seedtohole.forEach((element) {
      seedtohole.forEach((element1) {
        if(element[0].x==element1[0].x&&element[0].y==element1[0].y){
          if(element[2]>element1[2]){seedtohole.remove(element);}
          else if (element[2]<element1[2]){seedtohole.remove(element1);}
          else{seedtohole.remove(element1);}
        }
      });
    });
      startNode.seeds.forEach((seed) {
        seedtofarmer.add([seed,(seed.x - startNode.xf) + (seed.y-startNode.yf)]);
      });
    List closestseedtofarmer =seedtofarmer[0];
    List closestseedtohole =seedtohole[0];

      for(int i=0;i<seedtofarmer.length-1;i++){
        if(closestseedtofarmer[1]>seedtofarmer[i+1][1]){
          closestseedtofarmer=seedtofarmer[i+1][1];
        }
      }

    for(int i=0;i<seedtohole.length-1;i++){
      if(closestseedtohole[1]>seedtohole[i+1][2]){
        closestseedtohole=seedtohole[i+1][2];
      }
    }




    return closestseedtofarmer[1]+closestseedtohole[2];

  }

}
