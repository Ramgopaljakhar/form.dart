import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutterdemo/user.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';


class GetStorage {
  static init() {}
}

class MyForms extends StatelessWidget {
  
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {


  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ImagePicker picker = ImagePicker();
  XFile? image;


  late SharedPreferences sharedPreferences;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initialGetSaved();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Save DataModel Data JSON'),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: ListView(
          children: [
            Container(
              margin: const EdgeInsets.only(left: 5, top: 5, right: 5, bottom: 10,),
              decoration:
              BoxDecoration(border: Border.all(color: Colors.black)),
              child: Container(

                child: Row(
                  children: [
                    Container(
                        child: GestureDetector(
                          onTap: () {
                            _showPicker(context);
                          },
                          child: CircleAvatar(
                            radius: 55,
                            backgroundColor: Color(0xffFDCF09),
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
                        )),
                    Container(
                      height: 350,
                      width: MediaQuery.of(context).size.width - 125,
                      child: SingleChildScrollView(
                        child: Center(
                          child: Container(
                            width:700,
                            margin: EdgeInsets.only(left: 10, top: 15, right: 0, bottom: 0),

                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [

                                Padding(
                                  padding: const EdgeInsets.only(left: 20, top: 5, right: 5, bottom: 10,),
                                  child: Container(
                                    height: 60,
                                    width:500,
                                    child: TextField(
                                      controller: _name,
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          labelText: 'Enter name'
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Container(
                                    height: 60,
                                    width:500,
                                    child: TextField(
                                      controller: _email,
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          labelText: 'Enter Email'
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Container(
                                    height: 55,
                                    width:500,
                                    child: TextField(
                                      controller: _phone,
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          labelText: 'Enter Phone'
                                      ),
                                    ),
                                  ),
                                ),
                                ElevatedButton(onPressed: () {
                                  storeUserData();
                                }, child: Text('SAVE')),
                                ElevatedButton(onPressed: () {
                                  _name.value = TextEditingValue(text: '');
                                  _email.value = TextEditingValue(text: '');
                                  _phone.value = TextEditingValue(text: '');
                                  sharedPreferences.remove('userdata');
                                }, child: Text('SUBMIT'))
                              ],
                            ),
                          ),
                        ),
                      ),
                    )

                  ],
                ),

              ),
            ),
          ],
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
        var imageFile = File(pickedFile.path);
      });
    }
  }
}




