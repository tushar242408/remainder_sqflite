import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remainder/View.dart';
import 'package:flutter_remainder/database.dart';

void main() {
  runApp(MaterialApp(debugShowCheckedModeBanner: false,
      home: MyApp()));
}
class MyApp extends StatelessWidget {
  int k=0;
  @override
  final formkey= GlobalKey<FormState>();

  final dbhelp=dbhelper.instance;



  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
         mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Remainder",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 25),),
            Text("app",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 17),)
          ],
        )
      ),
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,

            children: [
              GestureDetector(
                onTap: (){
                  showModalBottomSheet(context: context, builder: (BuildContext bc){
                    return hb(b: k,);
                  });
                },
                child: Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width/2,
                  height: MediaQuery.of(context).size.height/12,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadiusDirectional.circular(10),
                  ),
                  child: Text("Adding Templates",style: TextStyle(color: Colors.white,fontSize: 25),),
                ),
              ),
              SizedBox(height: 10,),
              GestureDetector(
                onTap: ()=>
                Navigator.push(context, MaterialPageRoute(builder: (context)=> View())),
                child: Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width/2,
                  height: MediaQuery.of(context).size.height/12,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadiusDirectional.circular(10),
                  ),
                  child: Text("View privious",style: TextStyle(color: Colors.white,fontSize: 25),),
                ),
              )

            ],
          ),

        ),
      ),
    );
  }
}



class hb extends StatefulWidget {
  int b;
  hb({this.b});
  @override
  _hbState createState() => _hbState();
}

class _hbState extends State<hb> {

  final formkey= GlobalKey<FormState>();
  String Name,remainder;
  final dbhelp=dbhelper.instance;

  void insertdata() async{

    Map<String,dynamic> row={dbhelper.columnname:"$Name",
    dbhelper.columnremainder:"$remainder"};
      final id = await dbhelp.insert(row);
    print(id);
  }
  @override
  Widget build(BuildContext context) {
    return  Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextFormField(
            maxLength: 50,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
                fillColor: Colors.black,

                hintText: "Name"
            ),
            onChanged: (String value){
              print("$value");
              this.Name=value;
            },

          ),
          TextFormField(
            maxLength: 200,
            decoration: InputDecoration(
                fillColor: Colors.grey,

                hintText: "enter remaider"
            ),
            onChanged: (String value){
              print("$value");
              this.remainder=value;
            },





          ),
          SizedBox(height: 10,),

          GestureDetector(
            onTap: (){ insertdata();
            if(widget.b==1){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> View()));
            }
             else if(widget.b==0){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> MyApp()));
            }



            },
            child: Container(
              width:130,
              height: 40,
              decoration: BoxDecoration(
                  borderRadius:BorderRadiusDirectional.circular(20),
                  color: Colors.red
              ),
              child: Text("Add Data" ,style: TextStyle(
                fontSize: 17,
              ),textAlign: TextAlign.center,),
            ),
          ),],),);
  }
}


