import 'package:flutter/material.dart';
import 'package:untitled4/myApp.dart';

class Looser extends StatelessWidget {
  const Looser({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          Container(
            child: Center(child: Text('Game Over!',style: TextStyle(fontSize: 70),)),
          ),
          SizedBox(height: 50,),
          IconButton(
              onPressed: (){
                Navigator.push(context,MaterialPageRoute(builder:(context) => MyHomePage() ));
              },
              icon: Icon(Icons.refresh_outlined,size: 50,))

        ],
      ),
    );
  }
}
