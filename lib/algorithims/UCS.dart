
import 'dart:collection';
import 'package:untitled4/Logic/logic.dart';

class UCS {
  List<Map<List<Logic?>,int>>getGoalPath =[];
  List<Logic>goal=[];
  Logic startNode;
  UCS(this.startNode);


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
    List<Logic?>list=[];
    list.add(goal);
    while(goal.father!=null){
      list.add(goal.father);
      goal=goal.father!;
      cost++;
    }
    List<Logic?>listtemp = list;
    list=listtemp.reversed.toList();
    getGoalPath.add({list: cost});
  }
}
