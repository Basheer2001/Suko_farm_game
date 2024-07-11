
 import '../Logic/logic.dart';

class Board{
   List<List<String>> board =[];
   Board(List<List<String>> board ){
  // for(int i=0;i<board.length;i++){
  // for(int j=0;j<board.length;j++) {
  //   this.board[i][j]=board[i][j];
  //  // this.board[i] = board[i].clone();
  // }
  // }
     this.board=board;
  }
   List<List<String>> getBoard()
   {
        return board;
   }
   Boardl(Logic l){
  Board(l.stringBoard);
  }
   void printBoard (){
  for(int i =0;i<board.length;i++){
  print("   ");
  for(int j =0;j<board.length;j++){
  print( this.board[i][j]);
  print("   ");

  }
  print("\n \n");


  }
  }


}