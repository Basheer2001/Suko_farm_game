import 'package:flutter/material.dart';

import '../myApp.dart';

class Winner extends StatelessWidget {
  const Winner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          Container(
            child: Center(child: Text('Winner!',style: TextStyle(fontSize: 100),)),
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
