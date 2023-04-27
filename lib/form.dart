import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterdemo/user.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';


import 'imagepick.dart';


class MyForms extends StatefulWidget {
  const MyForms({Key? key}) : super(key: key);

  @override
  State<MyForms> createState() => _MyFormsState();
}

class _MyFormsState extends State<MyForms> {

  ImagePicker picker = ImagePicker();
  XFile? image;
  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();


  Map<String, dynamic>? get jsondatais => null;

  set _userImage(XFile _userImage) {}


  @override
  void initState() {
    //todo :implement initstate

    super.initState();
    initalGetSavedData();
  }

  Future<void> initalGetSavedData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    var N = jsonDecode(SharedPreferences.getInstance() as String);
    User user = User.fromJson(jsondatais!);
    print(N);
    // if(jsondatais.isNotEmpty){
    //   _name.value = TextEditingValue(text:User.name);
    //   _email.value = TextEditingValue(text:User.email);
    // }
  }

  Future<void> storedata() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    User user = User(_name.text, _email.text, _MyFormsState() as String?);

    String userdata = jsonEncode(user);
    print("helloUserdata $userdata");

    sharedPreferences.setString('userdata', userdata);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[

          IconButton(

            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MyApp1()));
            },
            icon: const Icon(Icons.refresh),
            color: Colors.black,
          ),
        ],
        backgroundColor: Colors.orange,
        title: const Text('Form'),
      ),
      body: Container(
        width: MediaQuery
            .of(context)
            .size
            .width,
        height: MediaQuery
            .of(context)
            .size
            .height,
        child: ListView(
          children: [
            Container(
              margin: const EdgeInsets.only(
                left: 10, top: 5, right: 10, bottom: 10,),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black)
              ),
              child: Row(
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
                      )
                  ),
                  Container(
                    height: 250,
                    width: MediaQuery
                        .of(context)
                        .size
                        .width - 250,


                    child: Column(
                      children: [
                        Form(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 40, top: 40, right: 0, bottom: 0),
                              child: Column(
                                children: <Widget>[
                                  TextField(
                                    controller: _name,
                                    decoration: const InputDecoration(
                                      hintText: "Enter name",
                                      labelText: AutofillHints.username,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  TextField(
                                    controller: _email,
                                    decoration: const InputDecoration(
                                      hintText: "Enter email",
                                      labelText: AutofillHints.email,
                                    ),
                                  ),

                                ],
                              ),

                            )),
                        Container(
                          margin: EdgeInsets.only(
                              left: 0, top: 15, right: 0, bottom: 0),
                          width: MediaQuery
                              .of(context)
                              .size
                              .width - 200,
                          alignment: Alignment.topRight,
                          child: Container(
                            height: 70,
                            width: 70,
                            child: ElevatedButton(
                                onPressed: () {
                                  print(image!.path);
                                },
                                child: Text("Submit")),
                          ),
                        ),

                      ],

                    ),
                  ),

                ],
              ),

            ),

          ],
        ),

      ),
    );
  }

  _showPicker(BuildContext context) async {
    PickedFile? pickedFile = (await ImagePicker().pickImage(
      source: ImageSource.gallery,
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












