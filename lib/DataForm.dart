import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pet_track/locationTrack.dart';
import 'package:simple_shadow/simple_shadow.dart';

class DataForm extends StatefulWidget {
  const DataForm({super.key});

  @override
  State<DataForm> createState() => _DataFormState();
}

class _DataFormState extends State<DataForm> {
  Map<int,dynamic> fetchedData={};
  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isDataFetched=false,isLoading=false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  fetchData() async {
    if (formKey.currentState!.validate()) {
      setState(() {
        isLoading=true;
      });
      var db = FirebaseFirestore.instance;
      try {
        QuerySnapshot<Map<String, dynamic>> querySnapshot = await db.collection(_emailController.text).get();
        if (querySnapshot.docs.isEmpty) {
          isDataFetched=false;
          isLoading=false;
          print("No documents found.");
        } else {
          int index=0;
          for (var doc in querySnapshot.docs) {
            print(doc.data()["Email"]);
            fetchedData[index++]={
              "Photo":doc.data()["Photo"],
              "Name":doc.data()["Name"],
              "oneLine":doc.data()["oneLine"],
              "Email":doc.data()["Email"],
              "userEmail":_emailController.text,
            };
          }
          setState(() {
            isDataFetched=true;
            isLoading=false;
          });

        }
      } on FirebaseException catch (ex) {
        setState(() {
          isDataFetched=false;
          isLoading=false;
        });
        print(ex.message);
      } catch (e) {
        setState(() {
          isDataFetched=false;
          isLoading=false;
        });
        print("Error: $e");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Location Tracker"),
      //   centerTitle: true,
      //   backgroundColor: Color.fromRGBO(208, 187, 187, 0.8),
      // ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            color: Color(0xff352F44),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0,left: 8.0,right: 8.0,bottom: 6.0),
                        child: Text("Location Tracker",style: TextStyle(
                          color: Colors.white60,
                          fontSize: 28,
                          fontWeight: FontWeight.w400,
                        ),),
                      ),
                    ),
                    Divider(
                      thickness: 2,
                      indent: 10,
                      endIndent: 60,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: _emailController,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey
                            ),
                          )
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please Enter Your Email";
                          } else {
                            return null;
                          }
                        },
                        style: TextStyle(
                          color: Colors.white60
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    SimpleShadow(
                      child: ElevatedButton(
                        onPressed: () {
                          print('tap');
                          print('Email: ${_emailController.text}');
                          fetchData();
                        },
                        style: ButtonStyle(
                          backgroundColor:  MaterialStateProperty.all(Color(0xffDBD8E3)),
                          minimumSize: MaterialStateProperty.all(Size(MediaQuery.of(context).size.width/2, MediaQuery.of(context).size.height/17)),
                          shape:MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)
                          ),)
                        ),
                        child: SimpleShadow(
                          child: Text('Fetch',style: TextStyle(
                            fontSize: 20,
                            color: Colors.grey.shade800
                          ),),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: isDataFetched,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width/1.4,
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(219, 216, 227, 0.3),
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: SimpleShadow(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: Text("Your Pets",style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w400,
                                    color: Colors.white60
                                ),),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    isLoading==true ? CircularProgressIndicator() :Visibility(
                      visible: isDataFetched,
                      child: SimpleShadow(
                        child: Container(
                          height: MediaQuery.of(context).size.height/1.7,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: Color(0xff5C5470),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ListView.separated(itemBuilder: (context, index) {
          
                            return Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: ListTile(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) =>  locationTrack(
                                    petEmail:fetchedData[index]["Email"],
                                    email: fetchedData[index]["userEmail"],
                                  )));
                                },
                                leading: CircleAvatar(
                                  backgroundImage: NetworkImage(fetchedData[index]["Photo"]),
                                ),
                                title: Text(fetchedData[index]["Name"],
                                    style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w400,
                                        color: Colors.white60
                                    )
                                ),
                                subtitle: Text(fetchedData[index]["oneLine"],
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.grey.shade900
                                    )
                                ),
                                trailing: Icon(Icons.navigate_next_outlined),
                              ),
                            );
          
                          }, separatorBuilder: (context, index) {
                            return Divider(
                              thickness: 2,
                            );
                          }, itemCount: fetchedData.length),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
