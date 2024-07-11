
import 'dart:collection';

import 'package:untitled4/Logic/logic.dart';

class Dfs {
  List<List<Logic?>>getGoalPath =[];
  List<Logic>goal=[];
  Logic startNode;
  Dfs(this.startNode);


  void travers(){

    Queue<Logic> q =  Queue();             //the (Queue) here acts as a (Stack)
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
    List<Logic?>list=[];
    list.add(goal);
    while(goal.father!=null){
      list.add(goal.father);
      goal=goal.father!;
    }
    List<Logic?>listtemp = list;
    list=listtemp.reversed.toList();
    getGoalPath.add(list);
  }
}
