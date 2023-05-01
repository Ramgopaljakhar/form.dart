
import 'package:flutter/material.dart';

import 'desing.dart';


class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.orange,
            title: const Text('First Screen'),
          ),
          body: Center(
            child:ElevatedButton(
                child:const Text("Show Login page"),
                onPressed:() {
                  showDialog(context:context,builder:(context){
                    return Container(
                      child:Padding(
                        padding: const EdgeInsets.all(16.0),
                        child:SingleChildScrollView(
                          child:Card(
                            child:Column(
                              children:<Widget> [
                                Form(
                                    child:Padding(
                                      padding:const EdgeInsets.all(16.0),
                                      child:Column(
                                        children: const <Widget>[
                                          TextField(
                                            decoration:InputDecoration(
                                              hintText:"Enter Username",labelText:AutofillHints.username,
                                            ),
                                          ),
                                          SizedBox(
                                            height:20,
                                          ),
                                          TextField(
                                            obscureText: true,
                                            decoration:InputDecoration(
                                              hintText:"Enter Password",
                                              labelText:AutofillHints.password,
                                            ),
                                          )
                                        ],
                                      ),

                                    )),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                      height: 50,
                                      width: 500,
                                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                      child: ElevatedButton(
                                        child:Text("Login "),

                                        onPressed: () {
                                          Navigator.push(context, MaterialPageRoute(builder: (context) =>MyApp()));

                                        },


                                      )
                                  ),
                                ),
                              ],

                            ),
                          ),
                        ),
                      ),
                    );// container
                  });
                }
            ),//ElevatedButton
          ),//container


          endDrawer: Drawer(
            child:ListView(
              children:const <Widget> [
                DrawerHeader(child:Text("Hey i'm drawer",style:TextStyle(color: Colors.white),),
                  decoration:BoxDecoration(color: Colors.purple),
                ),
                ListTile(
                  leading:Icon(Icons.person),
                  title:Text("Account"),
                  subtitle:Text("personal"),
                  trailing:Icon(Icons.edit),

                ),
                ListTile(
                  leading:Icon(Icons.email),
                  title:Text("Email"),
                  subtitle:Text("Ram1234@gmail.com"),
                  trailing: Icon(Icons.send_and_archive),
                )
              ],
            ),
          ),
        ) // appBar

    );
  }
}
