
import 'dart:collection';

import 'package:untitled4/Logic/logic.dart';

class Bfs {
  List<List<Logic?>>getGoalPath =[];
  List<Logic>goal=[];
  Logic startNode;
  Bfs(this.startNode);


  void travers(){

     Queue<Logic> q =  Queue();
     q.add(startNode);
     while(q.isNotEmpty){
       Logic current = q.first;
       if(!current.isvisited){
         if(current.checkwin()){
           goal.add(current);
         }
         current.isvisited=true;
         q.removeFirst();
         current.addNextStates();
         q.addAll(current.nextStates);
       }
       else {
         q.removeFirst();
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
// void BfsImplimentation(){
//
//   Logic ll = Logic();
//
//   print('${ll.stringBoard}\n');
//
//   Bfs bfs = Bfs(ll);
//
//   bfs.travers();
//
//   bfs.goal.forEach((element) {  bfs.getPath(element);});
//
//   print(bfs.getGoalPath.length);
//
// }
