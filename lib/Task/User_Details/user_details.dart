import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:placeassingment/Task/UserList/userlist.dart';

import 'json_userdetails.dart';

class UserDetails extends StatefulWidget {
  String Userid;
  UserDetails({Key? key, required this.Userid}) : super(key: key);

  @override
  _UserDetailsState createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Text(
            "Customer Details",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w200),
          ),
        ),
        backgroundColor: Color.fromARGB(255, 6, 13, 26),
        elevation: 1,
        shadowColor: Colors.blueGrey,
      ),
      backgroundColor: Color.fromARGB(255, 6, 13, 26),
      body: FutureBuilder(
          future: getData(),
          builder: (BuildContext context, AsyncSnapshot<Detailsjson> snapshot) {
            if (snapshot.hasData) {
              Detailsjson details = snapshot.data!;
              return Center(
                child: Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(20)),
                  width: 300,
                  height: 400,
                  child: Card(
                    color: Colors.blueGrey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Center(
                          child: ClipRRect(
                            child: Container(
                              child: Image.network(details.picture!),
                              width: 72,
                              height: 72,
                            ),
                            borderRadius: BorderRadius.circular(40),
                          ),
                        ),

                        Divider(color: Colors.black38,thickness: 0.8),
                        Padding(
                          padding: const EdgeInsets.only(left: 2),
                          child: Text(
                            ' Name : ' + details.firstName! + details.lastName!,
                            style: TextStyle(
                                color: Colors.black54,
                                fontWeight: FontWeight.w400,
                                fontSize: 22),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(),
                          child: Text('Id : ' + details.id!,
                              style: TextStyle(
                                  color: Colors.deepPurple,
                                  fontWeight: FontWeight.w300,
                                  fontSize: 17)),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text('Email : ' + details.email!,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w200)),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 120),
                          child: Text('Gender  :  ' + details.gender!,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w200)),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: Text('Reg Date :  ' + details.registerDate!,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w200)),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 25),
                          child: Text('Update date : ' + details.updatedDate!,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w200)),
                        ),

                        ElevatedButton(
                          onPressed: () {


                            Navigator.of(context).pop(MaterialPageRoute(
                                builder: (context) => UserList()));
                          },
                          child: Text(
                            "Back",
                            style: TextStyle(fontWeight: FontWeight.w300),
                          ),
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.green),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(
                  color: Colors.blue,
                ),
              );
            }
          }),
    );
  }

  Future<Detailsjson> getData() async {
    final result = await http.get(
        Uri.parse("https://dummyapi.io/data/v1/user/" + widget.Userid),
        headers: {"app-id": "61dbf9b1d7efe0f95bc1e1a6"});
    final jsonData = jsonDecode(result.body);
    var userdata = Detailsjson.fromJson(jsonData);

    return userdata;
  }
}
