import 'dart:convert';
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutterdemo/user.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import 'OpeartionClasss.dart';
import 'lists.dart';

class ListExample extends StatefulWidget {
  const ListExample({Key? key}) : super(key: key);

  @override
  State<ListExample> createState() => _ListExampleState();
}

class _ListExampleState extends State<ListExample> {

  List<User> a = [] ;

  ImagePicker picker = ImagePicker();
  XFile? image;
  bool _status = true;
  late SharedPreferences sharedPreferences;

  get arrData => arrData;



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initialGetSaved();
    quesValueE();
  }

  quesValueE(){
    var user = OpeartionClasss.fromJson(quesValue);
    print(user);
  }
  void initialGetSaved() async {


    sharedPreferences = await SharedPreferences.getInstance();

    // Read the data, decode it and store it in map structure
    Map<String, dynamic> jsondatais = jsonDecode(
        sharedPreferences.getString('userdata')!);

    var user = User.fromJson(jsondatais);

    if (jsondatais.isNotEmpty) {
      print(user.name);
      print(user.email);

      _name.value = TextEditingValue(text: user.name);
      _email.value = TextEditingValue(text: user.email);
      _phone.value = TextEditingValue(text: user.phone);
    }
  }

  void storeUserData() {
    //store the user entered data in user object
    User user1 = new User(_name.text, _email.text, _phone.text);

    // encode / convert object into json string
    String user = jsonEncode(user1);

    print(user);

    //save the data into sharedPreferences using key-value pairs
    sharedPreferences.setString('userdata', user);
  }


  TextEditingController _name = new TextEditingController();
  TextEditingController _email = new TextEditingController();
  TextEditingController _phone = new TextEditingController();

  List<String> allMessages = [];
  TextEditingController _textEditingController = TextEditingController();
  @override


  Widget build(BuildContext context) {
   int arrData =1;
    return Scaffold(
      appBar: AppBar(
        actions: <Widget> [

          IconButton(

            onPressed:() {
              Navigator.push(context, MaterialPageRoute(builder: (context) => ListExample()));
            },
            icon:const Icon(Icons.refresh),
            color:Colors.black,
          ),
        ],
        title: Text('ListView.builder'),
      ),
      body:Container(
        height:MediaQuery.of(context).size.height,
        width:MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row  (
                children: [
                  Container(
                      child: Center(
                        child: GestureDetector(
                          onTap: () {
                            _showPicker(context);
                          },
                          child: CircleAvatar(
                            radius: 55,
                            backgroundColor: Color(0xffFDCF09),
                            backgroundImage:AssetImage("assets/images/pexels-photo-39811.jpeg"),
                            child: image != null
                                ? ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: Image.file(
                                File(image!.path),
                                width: 100,
                                height: 100,
                                fit: BoxFit.fitHeight,
                             ),
                             )
                              : Container(
                              decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(50)),
                              width: 100,
                              height: 100,
                              child: Icon(
                                Icons.camera_alt,
                                color: Colors.grey[800],
                              ),
                            ),
                          ),
                        ),
                      )),
                  Container(
                    height: 400,
                    width: MediaQuery.of(context).size.width -125,
                    child: Column(
                        children: [
                          Form(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10, top: 40, right: 0, bottom: 0),
                              child: Column(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20, top: 5, right: 5, bottom: 10,),
                                    child: Container(
                                      height: 55,
                                      width:300,
                                      child: TextField(
                                        controller: _name,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          labelText: 'Enter name',
                                          labelStyle:TextStyle(
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Container(
                                      height: 55,
                                      width:300,
                                      child: TextField(
                                        controller: _email,
                                        decoration: InputDecoration(
                                            border: OutlineInputBorder(),
                                            labelText: 'Enter Email',
                                            labelStyle:TextStyle(color:Colors.black)
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Container(
                                      height: 55,
                                      width:300,
                                      child: TextField(
                                        controller: _phone,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          labelText: 'Enter Phone',
                                          labelStyle: TextStyle(
                                            color: Colors.black, //<-- SEE HERE
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 5, top: 5, right: 2, bottom: 0),
                                    width: MediaQuery.of(context).size.width - 200,
                                    alignment: Alignment.topRight,
                                    child: Container(
                                      height:100,
                                      width: 100,
                                      child:ElevatedButton(onPressed: () {
                                        a.add(User(_name.text, _email.text, _phone.text));
                                        // print(_name.text);
                                        // print(_email.text);
                                        // print(_phone.text);
                                        // storeUserData();
                                      }, child: Text('SAVE')),
                                    ),
                                  ),


                                ],
                              ),
                            ),
                          )
                        ]
                    ),
                  ),
                ],
              ),
              ListView.builder(
                itemCount: a.length,
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      // width: MediaQuery.of(context).size.width,
                      // height: MediaQuery.of(context).size.height,
                      child: Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(left:5, top: 5, right: 5, bottom: 10,
                              ),
                              decoration:
                              BoxDecoration(border: Border.all(color: Colors.black)),
                              child: Row(
                                children: [
                                  Container(
                                      child: Center(
                                        child: CircleAvatar(
                                          radius: 55,
                                          backgroundColor: Color(0xffFDCF09),
                                          child: image != null
                                              ? ClipRRect (
                                            borderRadius: BorderRadius.circular(50),
                                            child: Image.file(
                                              File(image!.path),
                                              width: 100,
                                              height: 100,
                                              fit: BoxFit.fitHeight,
                                            ),
                                          )
                                              : Container(
                                            decoration: BoxDecoration(
                                                color: Colors.grey[200],
                                                borderRadius: BorderRadius.circular(50)),
                                            width: 100,
                                            height: 100,
                                            child: Icon(
                                              Icons.camera_alt,
                                              color: Colors.grey[800],
                                            ),
                                          ),
                                        ),
                                      )),
                                  Container(
                                    // height: 400,
                                    width: MediaQuery.of(context).size.width -125,
                                    child: Column(
                                        children: [
                                          Form(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10, top: 40, right: 0, bottom: 0),
                                              child: Column(
                                                children: <Widget>[
                                                  Padding(
                                                    padding: const EdgeInsets.only(left: 20, top: 5, right: 5, bottom: 10,),
                                                    child: Container(
                                                      height: 55,
                                                      width:300,
                                                      child:Text(a[index].name),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.all(16.0),
                                                    child: Container(
                                                      height: 55,
                                                      width:300,
                                                      child:Text(a[index].email),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.all(16.0),
                                                    child: Container(
                                                      height: 55,
                                                      width:300,
                                                      child: Text(a[index].phone),
                                                    ),
                                                  ),


                                                ],
                                              ),
                                            ),
                                          )
                                        ]
                                    ),
                                  ),
                                ],
                              ),

                            ),

                          ]
                      ),
                    );
                  }
              ),
            ],
          ),
        ),
      ),
    );
  }
  _showPicker(BuildContext context) async {
    PickedFile? pickedFile = (await ImagePicker().pickImage(
      source: ImageSource.camera,
      maxWidth: 150,
      maxHeight: 150,
    )) as PickedFile?;
    if (pickedFile != null) {
      setState(() {
        // var imageFile = File.new(pickedFile.path as List<Object>);
      });
    }
  }
}





