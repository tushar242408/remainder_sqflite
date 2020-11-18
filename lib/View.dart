import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_remainder/database.dart';
import 'package:flutter_remainder/var.dart';

import 'main.dart';
class View extends StatefulWidget {
  @override
  _ViewState createState() => _ViewState();
}

class _ViewState extends State<View> {
  int k=1;
  List<Map>  rr;
  bool load=true;
  final dbhelp=dbhelper.instance;
  @override
  void initState() {
    // TODO: implement initState
    add();
    super.initState();
  }
  add() async{
    List<Map<String,dynamic>> i=await dbhelp.alldata();
    setState(() {
      rr=i;
      load=false;
    });
    print(rr);



  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Remainder",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 25),),
              Text("app",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 17),)
            ],
          ),

        actions: [
          GestureDetector(
            onTap:(){
    showModalBottomSheet(context: context, builder: (BuildContext bc){
    return hb(b: k,);

    });
    },
              child: Icon(Icons.add)


          ),
        ],


      ),
      body: load?Center(child: CircularProgressIndicator(backgroundColor: Colors.grey,)): ListView.builder(
            itemCount:rr.length,
            itemBuilder: (context,index){
              return Hh(a:rr[index]['name'],b: rr[index]['remainder'],d: dbhelp,);
            }),



       );
  }
}
class Hh extends StatelessWidget {
  int c;
  var d;
 final String  a,b;
  Hh({this.a,this.b,this.d});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SizedBox(height: 5,),
         ListTile(
          hoverColor: Colors.grey,
          tileColor: Colors.white12,
          title: Text("$a"),
          subtitle: Text("$b"),
           trailing: GestureDetector(
             onTap: (){
               d.delete(b);
               Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> View()));
             },
             child: Icon(Icons.delete)),
        ),
          SizedBox(height: 5,),
          Divider(),

        ],  ),

    );
  }
}

