

import 'dart:js_util';

import 'package:flutter/cupertino.dart';
import 'package:collection/collection.dart';
import 'package:untitled4/levels.dart';
import '../Components/Board.dart';
import '../Components/pair.dart';

class Logic {
  int cost=1;
  Logic? father;
  bool isvisited = false;
  List <List<String>> stringBoard =[] ;
  List<Container> graphicBoard=[];
  int xf=0;
  int yf=0;
    List<Pair> holes =[] ;
    List<Pair> seeds =[] ;
    List<Board> userPath=[];
    List<Logic> nextStates=[];

  Logic(){
    Board b = Board ([
      ['x','x','g','g','g','x'],
      ['x','g','g','s','h','x'],
      ['f','g','g','g','g','x'],
      ['x','g','g','s','h','x'],
      ['x','x','g','x','g','x'],
    ]);


    stringBoard = b.getBoard();
         this.start();

  }


  Logic.named(List <List<String>> list){
    Board b = Board (list);

    stringBoard = b.getBoard();

  }

  Function eq = const ListEquality().equals;
  // getAllStates(){
  //
  //   int i;
  //   Logic l = Logic.named(this.stringBoard);
  //
  //   if(checkMove('w')){
  //
  //     if(Statics.states.isEmpty){
  //       Statics.states.add(l.stringBoard);
  //     }
  //
  //     for( i=0;i<Statics.states.length;i++ ){
  //
  //       if(eq(Statics.states[i],l.stringBoard)){
  //         break;
  //       }
  //     }
  //     if(i>=Statics.states.length){
  //       l.move('w');
  //       for(int i=0;i<Statics.states.length;i++ ){
  //         if(!eq(Statics.states[i],l.stringBoard)){
  //           Statics.states.add(l.stringBoard);
  //         }
  //       }
  //       l.getAllStates();
  //     }
  //
  //   }
  //
  //
  //   if(checkMove('s')){
  //
  //     if(Statics.states.isEmpty){
  //       Statics.states.add(l.stringBoard);
  //     }
  //     for( i=0;i<Statics.states.length;i++ ){
  //       if(eq(Statics.states[i],l.stringBoard)){
  //         break;
  //       }
  //     }
  //     if(i>=Statics.states.length){
  //       l.move('s');
  //       for(int i=0;i<Statics.states.length;i++ ){
  //         if(!eq(Statics.states[i],l.stringBoard)){
  //           Statics.states.add(l.stringBoard);
  //         }
  //       }
  //       l.getAllStates();
  //     }
  //
  //   }
  //
  //   if(checkMove('a')){
  //
  //     if(Statics.states.isEmpty){
  //       Statics.states.add(l.stringBoard);
  //     }
  //     for( i=0;i<Statics.states.length;i++ ){
  //       if(eq(Statics.states[i],l.stringBoard)){
  //         break;
  //       }
  //     }
  //     if(i>=Statics.states.length){
  //       l.move('a');
  //       for(int i=0;i<Statics.states.length;i++ ){
  //         if(!eq(Statics.states[i],l.stringBoard)){
  //           Statics.states.add(l.stringBoard);
  //         }
  //       }
  //       l.getAllStates();
  //     }
  //
  //   }
  //   if(checkMove('d')){
  //
  //     if(Statics.states.isEmpty){
  //       Statics.states.add(l.stringBoard);
  //     }
  //     for( i=0;i<Statics.states.length;i++ ){
  //       if(eq(Statics.states[i],l.stringBoard)){
  //         break;
  //       }
  //     }
  //     if(i>=Statics.states.length){
  //       l.move('d');
  //       for(int i=0;i<Statics.states.length;i++ ){
  //         if(!eq(Statics.states[i],l.stringBoard)){
  //           Statics.states.add(l.stringBoard);
  //         }
  //       }
  //       l.getAllStates();
  //     }
  //
  //   }
  //
  //
  //   return;
  //
  //
  // }



   void getGraphicBoard(){
     for(int i=0;i<stringBoard.length;i++){
       for(String e in stringBoard[i]){
            if(e=='g'){
              graphicBoard.add(Container(child: Image(image: AssetImage('assets/way.png'),fit: BoxFit.fill,)));
            }
            else if (e=='x'){
              graphicBoard.add(
                  Container(
                    child: Image(
                      image: AssetImage('assets/block.png'),
                      fit: BoxFit.fill,
                    ),
                  )
              );
            }
            else if(e=='h'){
              graphicBoard.add(Container(child: Image(image: AssetImage('assets/hole.png'),fit: BoxFit.fill,)));
            }
            else if (e=='f'){
              graphicBoard.add(Container(child: Image(image:AssetImage('assets/farmer.png') ,fit: BoxFit.fill,)));
       }
            else {
              graphicBoard.add(Container(child: Image(image:AssetImage('assets/seed.png') ,fit: BoxFit.fill,)));
            }
       }
     }
   }
   void getBoard (){
    for(int i =0;i<stringBoard.length;i++){
      print("   ");
      for(int j =0;j<stringBoard[i].length;j++){
        print( stringBoard[i][j]);
        print("   ");

      }
      print("\n \n");


    }
  }
  void farPosition(){
    for(int i = 0;i<stringBoard.length;i++){
      for(int j = 0;j<stringBoard[i].length;j++){
        if (stringBoard[i][j]=='f'){
          xf=i;
          yf=j;
          break;
        }

      }
    }
  }
  void holePosition(){
    for(int i = 0;i<stringBoard.length;i++){
      for(int j = 0;j<stringBoard[i].length;j++){
        if (stringBoard[i][j]=='h'){
          holes.add( Pair(i,j));
        }

      }
    }
  }void seedPosition(){
    for(int i = 0;i<stringBoard.length;i++){
      for(int j = 0;j<stringBoard[i].length;j++){
        if (stringBoard[i][j]=='s'){
          seeds.add( Pair(i,j));
        }

      }
    }
  }
  void returnHolePosition(){
    for (Pair e in holes) {
      if(xf!=e.x || yf!=e.y){
        if(stringBoard[e.x][e.y]=='g'){
          stringBoard[e.x][e.y] = 'h';
        }
      }
    }
  }
   void start(){
    holePosition();
    farPosition();
    userPath.add( Board(this.stringBoard));
    //addNextStates();
    getGraphicBoard();

  }

  void addNextStates(){

     nextStates.add(move1('w'));
     nextStates.last.father=this;
     nextStates.add(move1('s'));
     nextStates.last.father=this;
     nextStates.add(move1('a'));
     nextStates.last.father=this;
     nextStates.add(move1('d'));
     nextStates.last.father=this;

  }


  void setUSerPathState(){
    if (!eq(this.userPath.last.board,this.stringBoard)){
      this.userPath.add(Board(this.stringBoard));
    }

  }
  bool checkMove(String move){
    // if(move == 'w' ){
    // if(stringBoard[xf-1][yf]=='g'){
    //   return true;
    // }
    // else if(stringBoard[xf-1][yf]=='h'){}
    // else if (stringBoard[xf-1][yf]=='s'){
    //
    //   if(stringBoard[xf-2][yf]=='h'||stringBoard[xf-2][yf]=='g'){
    //
    //   }
    //   else if(stringBoard[xf-2][yf]=='s'){
    //
    //     if(stringBoard[xf-3][yf]=='h'||stringBoard[xf-3][yf]=='g'){
    //
    //     }
    //   }
    // }
    // }
    if(move == 'w' && 0<xf ){
      if(stringBoard[xf-1][yf]=='g'){
        return true;

      }
      else if(stringBoard[xf-1][yf]=='h'){
        return true;

      }
      else if (stringBoard[xf-1][yf]=='s' && 0<= xf-2){

        if(stringBoard[xf-2][yf]=='h'||stringBoard[xf-2][yf]=='g'){
          return true;
        }
        else if(stringBoard[xf-2][yf]=='s'&& 0<= xf-3){

          if(stringBoard[xf-3][yf]=='h'||stringBoard[xf-3][yf]=='g'){
            return true;
          }

        }
      }
    }



    else if(move == 's'&& xf<stringBoard.length-1){
      if(stringBoard[xf+1][yf]=='g'){
       return  true;
      }
      else if(stringBoard[xf+1][yf]=='h'){
        return  true;

      }
      else if (stringBoard[xf+1][yf]=='s' && xf+2<=stringBoard.length-1){

        if(stringBoard[xf+2][yf]=='h'||stringBoard[xf+2][yf]=='g'){
          return  true;
        }
        else if(stringBoard[xf+2][yf]=='s'&& xf+3<=stringBoard.length-1){

          if(stringBoard[xf+3][yf]=='h'||stringBoard[xf+3][yf]=='g'){
            return  true;
          }

        }
      }

    }


    else if(move == 'd'&& yf<stringBoard.length-1){
      if(stringBoard[xf][yf+1]=='g'){
        return  true;
      }
      else if(stringBoard[xf][yf+1]=='h'){
        return  true;
      }
      else if (stringBoard[xf][yf+1]=='s' && yf+2<=stringBoard.length-1){

        if(stringBoard[xf][yf+2]=='h'||stringBoard[xf][yf+2]=='g'){
          return  true;
        }
        else if(stringBoard[xf][yf+2]=='s'&& yf+3<=stringBoard.length-1){

          if(stringBoard[xf][yf+3]=='h'||stringBoard[xf][yf+3]=='g'){
            return  true;
          }

        }
      }

    }


    else if(move == 'a'&& 0<yf){

      if(stringBoard[xf][yf-1]=='g'){
        return  true;
      }
      else if(stringBoard[xf][yf-1]=='h'){
        return  true;

      }
      else if (stringBoard[xf][yf-1]=='s' && 0<=yf-2){

        if(stringBoard[xf][yf-2]=='h'||stringBoard[xf][yf-2]=='g'){
          return  true;
        }
        else if(stringBoard[xf][yf-2]=='s'&& 0<=yf-3){

          if(stringBoard[xf][yf-3]=='h'||stringBoard[xf][yf-3]=='g'){
            return  true;
          }

        }
      }

    }

    return false;
  }


   void move(String move){





    if(checkMove(move)){

      if(move == 'w' && 0<xf ){
        if(stringBoard[xf-1][yf]=='g'){
          stringBoard[xf][yf]='g';
          stringBoard[xf-1][yf]='f';

        }
        else if(stringBoard[xf-1][yf]=='h'){
          stringBoard[xf][yf]='g';
          stringBoard[xf-1][yf]='f';

        }
        else if (stringBoard[xf-1][yf]=='s' && 0<= xf-2){

          if(stringBoard[xf-2][yf]=='h'||stringBoard[xf-2][yf]=='g'){
            stringBoard[xf][yf]='g';
            stringBoard[xf-1][yf]='f';
            stringBoard[xf-2][yf]='s';
          }
          else if(stringBoard[xf-2][yf]=='s'&& 0<= xf-3){

            if(stringBoard[xf-3][yf]=='h'||stringBoard[xf-3][yf]=='g'){
              stringBoard[xf][yf]='g';
              stringBoard[xf-1][yf]='f';
              stringBoard[xf-2][yf]='s';
              stringBoard[xf-3][yf]='s';
            }

          }
        }
      }


      if(move == 's'&& xf<stringBoard.length-1){
        if(stringBoard[xf+1][yf]=='g'){
          stringBoard[xf][yf]='g';
          stringBoard[xf+1][yf]='f';
        }
        else if(stringBoard[xf+1][yf]=='h'){
          stringBoard[xf][yf]='g';
          stringBoard[xf+1][yf]='f';

        }
        else if (stringBoard[xf+1][yf]=='s' && xf+2<=stringBoard.length-1){

          if(stringBoard[xf+2][yf]=='h'||stringBoard[xf+2][yf]=='g'){
            stringBoard[xf][yf]='g';
            stringBoard[xf+1][yf]='f';
            stringBoard[xf+2][yf]='s';
          }
          else if(stringBoard[xf+2][yf]=='s'&& xf+3<=stringBoard.length-1){

            if(stringBoard[xf+3][yf]=='h'||stringBoard[xf+3][yf]=='g'){
              stringBoard[xf][yf]='g';
              stringBoard[xf+1][yf]='f';
              stringBoard[xf+2][yf]='s';
              stringBoard[xf+3][yf]='s';
            }

          }
        }

      }


      if(move == 'd'&& yf<stringBoard.length-1){
        if(stringBoard[xf][yf+1]=='g'){
          stringBoard[xf][yf]='g';
          stringBoard[xf][yf+1]='f';
        }
        else if(stringBoard[xf][yf+1]=='h'){
          stringBoard[xf][yf]='g';
          stringBoard[xf][yf+1]='f';
        }
        else if (stringBoard[xf][yf+1]=='s' && yf+2<=stringBoard.length-1){

          if(stringBoard[xf][yf+2]=='h'||stringBoard[xf][yf+2]=='g'){
            stringBoard[xf][yf]='g';
            stringBoard[xf][yf+1]='f';
            stringBoard[xf][yf+2]='s';
          }
          else if(stringBoard[xf][yf+2]=='s'&& yf+3<=stringBoard.length-1){

            if(stringBoard[xf][yf+3]=='h'||stringBoard[xf][yf+3]=='g'){
              stringBoard[xf][yf]='g';
              stringBoard[xf][yf+1]='f';
              stringBoard[xf][yf+2]='s';
              stringBoard[xf][yf+3]='s';
            }

          }
        }

      }


      if(move == 'a'&& 0<yf){

        if(stringBoard[xf][yf-1]=='g'){
          stringBoard[xf][yf]='g';
          stringBoard[xf][yf-1]='f';
        }
        else if(stringBoard[xf][yf-1]=='h'){
          stringBoard[xf][yf]='g';
          stringBoard[xf][yf-1]='f';

        }
        else if (stringBoard[xf][yf-1]=='s' && 0<=yf-2){

          if(stringBoard[xf][yf-2]=='h'||stringBoard[xf][yf-2]=='g'){
            stringBoard[xf][yf]='g';
            stringBoard[xf][yf-1]='f';
            stringBoard[xf][yf-2]='s';
          }
          else if(stringBoard[xf][yf-2]=='s'&& 0<=yf-3){

            if(stringBoard[xf][yf-3]=='h'||stringBoard[xf][yf-3]=='g'){
              stringBoard[xf][yf]='g';
              stringBoard[xf][yf-1]='f';
              stringBoard[xf][yf-2]='s';
              stringBoard[xf][yf-3]='s';
            }

          }
        }








      }
      farPosition();

      returnHolePosition();



    }









  }


  Logic move1(String move){

    Logic l =  Logic.named(stringBoard);




    if(checkMove(move)){

      if(move == 'w' && 0<xf ){
        if( l.stringBoard[xf-1][yf]=='g'){
          l.stringBoard[xf][yf]='g';
          l.stringBoard[xf-1][yf]='f';
          return l;

        }
        else if( l.stringBoard[xf-1][yf]=='h'){
          l.stringBoard[xf][yf]='g';
          l.stringBoard[xf-1][yf]='f';
          return l;

        }
        else if ( l.stringBoard[xf-1][yf]=='s' && 0<= xf-2){

          if( l.stringBoard[xf-2][yf]=='h'|| l.stringBoard[xf-2][yf]=='g'){
            l.stringBoard[xf][yf]='g';
            l.stringBoard[xf-1][yf]='f';
            l.stringBoard[xf-2][yf]='s';
            return l;

          }
          else if( l.stringBoard[xf-2][yf]=='s'&& 0<= xf-3){

            if( l.stringBoard[xf-3][yf]=='h'|| l.stringBoard[xf-3][yf]=='g'){
              l.stringBoard[xf][yf]='g';
              l.stringBoard[xf-1][yf]='f';
              l.stringBoard[xf-2][yf]='s';
              l.stringBoard[xf-3][yf]='s';
              return l;

            }

          }
        }
      }


      if(move == 's'&& xf< l.stringBoard.length-1){
        if( l.stringBoard[xf+1][yf]=='g'){
          l.stringBoard[xf][yf]='g';
          l.stringBoard[xf+1][yf]='f';
          return l;

        }
        else if( l.stringBoard[xf+1][yf]=='h'){
          l.stringBoard[xf][yf]='g';
          l.stringBoard[xf+1][yf]='f';
          return l;


        }
        else if ( l.stringBoard[xf+1][yf]=='s' && xf+2<= l.stringBoard.length-1){

          if( l.stringBoard[xf+2][yf]=='h'|| l.stringBoard[xf+2][yf]=='g'){
            l.stringBoard[xf][yf]='g';
            l.stringBoard[xf+1][yf]='f';
            l.stringBoard[xf+2][yf]='s';
            return l;

          }
          else if( l.stringBoard[xf+2][yf]=='s'&& xf+3<= l.stringBoard.length-1){

            if( l.stringBoard[xf+3][yf]=='h'|| l.stringBoard[xf+3][yf]=='g'){
              l.stringBoard[xf][yf]='g';
              l.stringBoard[xf+1][yf]='f';
              l.stringBoard[xf+2][yf]='s';
              l.stringBoard[xf+3][yf]='s';
              return l;

            }

          }
        }

      }


      if(move == 'd'&& yf< l.stringBoard.length-1){
        if( l.stringBoard[xf][yf+1]=='g'){
          l.stringBoard[xf][yf]='g';
          l.stringBoard[xf][yf+1]='f';
          return l;

        }
        else if( l.stringBoard[xf][yf+1]=='h'){
          l.stringBoard[xf][yf]='g';
          l.stringBoard[xf][yf+1]='f';
          return l;

        }
        else if ( l.stringBoard[xf][yf+1]=='s' && yf+2<= l.stringBoard.length-1){

          if( l.stringBoard[xf][yf+2]=='h'|| l.stringBoard[xf][yf+2]=='g'){
            l.stringBoard[xf][yf]='g';
            l.stringBoard[xf][yf+1]='f';
            l.stringBoard[xf][yf+2]='s';
            return l;

          }
          else if( l.stringBoard[xf][yf+2]=='s'&& yf+3<= l.stringBoard.length-1){

            if( l.stringBoard[xf][yf+3]=='h'|| l.stringBoard[xf][yf+3]=='g'){
              l.stringBoard[xf][yf]='g';
              l.stringBoard[xf][yf+1]='f';
              l.stringBoard[xf][yf+2]='s';
              l. stringBoard[xf][yf+3]='s';
              return l;

            }

          }
        }

      }


      if(move == 'a'&& 0<yf){

        if( l.stringBoard[xf][yf-1]=='g'){
          l.stringBoard[xf][yf]='g';
          l.stringBoard[xf][yf-1]='f';
          return l;

        }
        else if( l.stringBoard[xf][yf-1]=='h'){
          l.stringBoard[xf][yf]='g';
          l.stringBoard[xf][yf-1]='f';
          return l;


        }
        else if ( l.stringBoard[xf][yf-1]=='s' && 0<=yf-2){

          if( l.stringBoard[xf][yf-2]=='h'|| l.stringBoard[xf][yf-2]=='g'){
            l.stringBoard[xf][yf]='g';
            l.stringBoard[xf][yf-1]='f';
            l. stringBoard[xf][yf-2]='s';
            return l;

          }
          else if( l.stringBoard[xf][yf-2]=='s'&& 0<=yf-3){

            if( l.stringBoard[xf][yf-3]=='h'|| l.stringBoard[xf][yf-3]=='g'){
              l.stringBoard[xf][yf]='g';
              l.stringBoard[xf][yf-1]='f';
              l.stringBoard[xf][yf-2]='s';
              l.stringBoard[xf][yf-3]='s';
              return l;

            }

          }
        }








      }
      farPosition();

      returnHolePosition();



    }









/////
    return l;

  }

  bool checkwin(){
    for(int i = 0;i<stringBoard.length;i++){
      for(int j = 0;j<stringBoard[i].length;j++){
        if (stringBoard[i][j]=='s'){
          int m;
          for (m=0;m<holes.length;m++) {
            if(i==holes[m].x && j==holes[m].y){
              break;
            }
          }
          if(m>=holes.length){
            return false;
          }

        }

      }
    }
    return true;
  }


    bool  checkloos(){
    for(int i = 0;i<stringBoard.length;i++){
      for(int j = 0;j<stringBoard[i].length;j++){
        if(stringBoard[i][j]=='s'){
          // board corners
          if((i==0&&j==0) || (i==0&&j==stringBoard.length-1)||(i==stringBoard.length-1&&j==0)||(i==stringBoard.length-1&&j==stringBoard.length-1)){
            return true;
          }




          //board sides
          else if ((i==0)){
            int m;
            for(m=0;m<holes.length;m++){
              if(holes[m].x==0){
                break;
              }
            }
            if(m>=holes.length){
              return true;
            }
          }
          else if ((j==0)){
            int m;
            for(m=0;m<holes.length;m++){
              if(holes[m].y==0){
                break;
              }
            }
            if(m>=holes.length){
              return true;
            }
          }
          else if ((i==stringBoard.length-1)){
            int m;
            for(m=0;m<holes.length;m++){
              if(holes[m].x==stringBoard.length-1){
                break;
              }
            }
            if(m>=holes.length){
              return true;
            }
          }
          else if ((j==stringBoard.length-1)){
            int m;
            for(m=0;m<holes.length;m++){
              if(holes[m].y==stringBoard.length-1){
                break;
              }
            }
            if(m>=holes.length){
              return true;
            }

          }














          // internal corners
          else if (stringBoard[i][j-1]=='x'&&stringBoard[i+1][j]=='x'&&stringBoard[i+1][j-1]=='x'){
            return true;
          }
          else if (stringBoard[i][j-1]=='x'&&stringBoard[i-1][j]=='x'&&stringBoard[i-1][j-1]=='x'){
            return true;
          }
          else if (stringBoard[i][j+1]=='x'&&stringBoard[i-1][j]=='x'&&stringBoard[i-1][j+1]=='x'){
            return true;
          }
          else if (stringBoard[i][j+1]=='x'&&stringBoard[i+1][j]=='x'&&stringBoard[i+1][j+1]=='x'){
            return true;
          }




          // internal sides
          else {

            int n;
            if(stringBoard[i-1][j]=='x'){
              for(n=0;n<stringBoard[i].length;n++){
                if(stringBoard[i-1][n]!='x'){
                  break;
                }

              }
              if (n>=stringBoard.length){
                int m;
                for(m=0;m<holes.length;m++){
                  if(holes[m].x==i){
                    break;
                  }
                }
                if(m>=holes.length){
                  return true;
                }
              }
            }

            else if(stringBoard[i+1][j]=='x'){
              for(n=0;n<stringBoard[i].length;n++){
                if(stringBoard[i+1][n]!='x'){
                  break;
                }

              }
              if (n>=stringBoard.length){
                int m;
                for(m=0;m<holes.length;m++){
                  if(holes[m].x==i){
                    break;
                  }
                }
                if(m>=holes.length){
                  return true;
                }
              }
            }


            else if(stringBoard[i][j-1]=='x'){
              for(n=0;n<stringBoard.length;n++){
                if(stringBoard[n][j-1]!='x'){
                  break;
                }

              }
              if (n>=stringBoard.length){
                int m;
                for(m=0;m<holes.length;m++){
                  if(holes[m].y==j){
                    break;
                  }
                }
                if(m>=holes.length){
                  return true;
                }
              }

            }


            else if(stringBoard[i][j+1]=='x'){
              for(n=0;n<stringBoard.length;n++){
                if(stringBoard[n][j+1]!='x'){
                  break;
                }

              }
              if (n>=stringBoard.length){
                int m;
                for(m=0;m<holes.length;m++){
                  if(holes[m].y==j){
                    break;
                  }
                }
                if(m>=holes.length){
                  return true;
                }
              }
            }




          }


        }
      }
    }
    return false;
  }



}




