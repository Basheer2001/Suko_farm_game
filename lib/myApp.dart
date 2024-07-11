import 'package:flutter/material.dart';
import 'package:untitled4/Logic/logic.dart';
import 'package:flutter_joystick/flutter_joystick.dart';
import 'package:untitled4/algorithims/bfs.dart';
import 'package:untitled4/levels.dart';

import 'Logic/Looser.dart';
import 'Logic/Winner.dart';
import 'algorithims/a_star.dart';


class MyHomePage extends StatefulWidget {

   MyHomePage();
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {

  Logic logic = Logic();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Column(

        children: [
          Container(
            color: Color(0xff267513),

            child: GridView.builder(
              itemCount: logic.stringBoard.length*logic.stringBoard[0].length,
              // padding: EdgeInsets.symmetric(
              //   horizontal: 20,
              //   vertical: 8,
              // ),
              //childAspectRatio: 1,
              //crossAxisSpacing: 0,
              //mainAxisSpacing: 0,t
              //children:  logic.graphicBoard;
              shrinkWrap: true,
              gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount:logic.stringBoard[0].length,


              ),
              itemBuilder: (BuildContext context, int index) {
               return logic.graphicBoard[index];
              } ,





            ),
          ),
          Expanded(
              child: Container(

            child: Container(

              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.3),

                shape: BoxShape.circle,

              ),


              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    child: Icon(
                      Icons.arrow_back_outlined,
                      size: 100,
                      color: Colors.grey,

                    ),
                    onTap: (){
                      logic.move('a');
                      logic.graphicBoard.clear();
                      setState(() {
                        logic.getGraphicBoard();
                      });
                      logic.setUSerPathState();
                      if(logic.checkwin()){

                        showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return Winner(

                              );
                            }
                        );
                      }

                      if(logic.checkloos()){


                        showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return Looser(
                              );
                            }
                        );
                      }

                    },
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [
                      GestureDetector(
                        child: Icon(
                          Icons.arrow_upward_outlined,
                          size: 100,
                          color: Colors.grey,

                        ),
                        onTap: (){

                          // Logic ll = Logic();
                          // AStar a = AStar(ll);
                          // a.travers();

                          logic.move('w');
                          logic.graphicBoard.clear();

                          setState(() {
                             logic.getGraphicBoard();
                          });
                          logic.setUSerPathState();
                          if(logic.checkwin()){

                            showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return Winner(

                                  );
                                }
                            );
                          }
                          if(logic.checkloos()){

                            showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return Looser(
                                  );
                                }
                            );
                          }
                        },
                      ),
                      GestureDetector(
                        child: Icon(
                          Icons.arrow_downward_outlined,
                          size: 100,
                          color: Colors.grey,

                        ),
                        onTap: (){
                          logic.move('s');
                          logic.graphicBoard.clear();
                          setState(() {
                            logic.getGraphicBoard();

                          });
                          logic.setUSerPathState();
                          if(logic.checkwin()){

                            showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return Winner(

                                  );
                                }
                            );
                          }
                          if(logic.checkloos()){

                            showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return Looser(
                                  );
                                }
                            );
                          }
                        },
                      ),



                    ],

                  ),
                  GestureDetector(
                    child: Icon(
                      Icons.arrow_forward_outlined,
                      size: 100,
                      color: Colors.grey,

                    ),
                    onTap: (){
                      logic.move('d');
                      logic.graphicBoard.clear();
                      setState(() {
                        logic.getGraphicBoard();
                      });
                      logic.setUSerPathState();
                      if(logic.checkwin()){

                        showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return Winner(
                              );
                            }
                        );
                      }
                      if(logic.checkloos()){

                        showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return Looser(
                              );
                            }
                        );
                      }

                    },
                  ),


                ],
              ),
            ),
          ),
          ),

        ],
      )


    );
  }
}
