import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';



class GetStorage {
  static init() {}
}

class TabsExample extends StatefulWidget {
  const TabsExample({Key? key}) : super(key: key);

  @override
  State<TabsExample> createState() => _TabsExampleState();
}

class _TabsExampleState extends State<TabsExample> {

  List<String> namelist = [] ;
  List<String> namelistNew = [] ;
  late SharedPreferences sharedPreferences;




  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    namelistfunction();
  }

  void namelistfunction() async {
    SharedPreferences pre = await SharedPreferences.getInstance();
    namelistNew = pre.getStringList("name") ?? [];


  }

  final TextEditingController _name = new TextEditingController();


  List<String> allMessages = [];
  TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: DefaultTabController(
          length: 3,
          child: Scaffold(
            appBar: AppBar(
              title: Text('Tabs'),
              bottom: const TabBar(
                tabs: [
                  Tab(icon: Text("1"),),
                  Tab(icon: Text("2"),),
                  Tab(icon: Text("3"),),
                ],),
            ),
            body: TabBarView(
              children: [
                Center(
                  child: ListView(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 5, right: 0, top: 15, bottom: 0),

                        child: Row(
                          children: [
                            Container(
                              height: 50,
                              width: 100,
                              margin: const EdgeInsets.only(left: 5, right: 0, top: 0, bottom: 0),
                              padding: const EdgeInsets.only(left: 25, top: 0, right: 0, bottom: 0,),

                              child: const Text("Name", style: TextStyle(
                                  fontSize: 18)),

                            ),
                            Container(
                              margin: EdgeInsets.only(left: 0,top: 5,right: 0,bottom: 0),
                              height: 80, width: 250,
                              child: TextField(
                                controller: _name,
                                decoration: const InputDecoration(
                                   contentPadding: EdgeInsets.only(top: 7, bottom: 5),
                                    border: OutlineInputBorder(),
                                    labelText: "",
                                    labelStyle: TextStyle(height:5,
                                      fontWeight: FontWeight.bold,
                                      fontSize:22,
                                      color: Colors.black,
                                    )
                                ),
                              ),
                            )
                          ],
                        ),


                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 0, top: 0, right: 10, bottom: 0),
                        width: 100,
                        alignment: Alignment.topRight,
                        child: ElevatedButton(
                          onPressed: () async {
                            setState(() {
                              namelist.add(_name.text);
                            });

                            SharedPreferences pre = await SharedPreferences.getInstance();
                            pre.setStringList("name", namelist) ?? "";

                            print(_name.text);

                          },
                          child: const Text('Submit'),

                        ),
                      )
                    ],
                  ),
                ),
                ListView.builder(
                    itemCount: namelist.length,
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      return  Container(

                        color:Colors.greenAccent[200],
                        margin: const EdgeInsets.only(
                            left: 5, right: 0, top: 10, bottom: 0),

                        child: Row(
                          children: [
                            Container(
                              height: 20,
                              width: 100,
                              margin: const EdgeInsets.only(
                                  left: 5, right: 0, top: 0, bottom: 0),
                              padding: const EdgeInsets.only(
                                left: 25, top: 0, right: 0, bottom: 0,),

                              child: const Text("Name", style: TextStyle(
                                  fontSize: 18)),

                            ),
                            Container(
                              padding: EdgeInsets.only(top: 23),
                              height: 70, width: 250,
                                child:Text(namelist[index],
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize:18,
                                    color: Colors.deepOrangeAccent,
                                ),)

                            )
                          ],
                        ),


                      );
                  }
                ),
                Center(
                  child: Container(
                    alignment: Alignment.center,
                    height: 200,
                    width:200,

                    decoration: BoxDecoration(
                      gradient:LinearGradient(colors:[Colors.blue,Colors.pink]),
                    border:Border.all(
                      color: Colors.greenAccent,
                      width: 4.0,
                      style:BorderStyle.solid,
                    ),
                  boxShadow:[
                    BoxShadow(
                      color:Colors.grey,
                      offset:Offset(4.0,5.0),
                      blurRadius:10.0,
                      spreadRadius:2.0
                    )
                  ]

                    ),
                    child: Text('Thank you'),),
                )
              ],

            )

          )
      ),

    );
  }


}

