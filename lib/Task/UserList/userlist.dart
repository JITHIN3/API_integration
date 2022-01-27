import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:placeassingment/Task/UserList/json_userlist.dart';
import 'package:placeassingment/Task/User_Details/user_details.dart';

class UserList extends StatefulWidget {
  const UserList({Key? key}) : super(key: key);

  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "Customers",
            style: TextStyle(fontWeight: FontWeight.w200, fontSize: 25),
          ),
        ),
        backgroundColor: Color.fromARGB(255, 6, 13, 26),
        elevation: 1,
        shadowColor: Colors.blueGrey,
      ),
      body: FutureBuilder(
        future: getData(),
        builder: (context, AsyncSnapshot<List<Data>?> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context, int index) {
                Data user = snapshot.data!.elementAt(index);

                return Stack(children: [
                  ListTile(
                    leading: ClipRRect(
                      child: Container(
                        child: Image.network(user.picture!),
                        width: 40,
                        height: 40,
                      ),
                      borderRadius: BorderRadius.circular(40),
                    ),
                    title: Text(
                      user.firstName!,
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w300),
                    ),
                    subtitle: Text(
                      user.title!,
                      style: TextStyle(
                          color: Colors.white54, fontWeight: FontWeight.w200),
                    ),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => UserDetails(Userid: user.id!)));
                    },
                    trailing: IconButton(
                        onPressed: () {
                        },
                        icon: Icon(
                          Icons.more_vert_rounded,
                          color: Colors.white70,
                          size: 20,
                        )),
                  ),
                  Divider(
                    height: 2,
                    thickness: 0.2,
                    color: Colors.blueGrey,
                  )
                ]);
              },
            );
          } else {
            return const Center(
                child: CircularProgressIndicator(
              backgroundColor: Colors.blue,
            ));
          }
        },
      ),
      backgroundColor: Color.fromARGB(255, 6, 13, 26),
    );
  }

  //Getting Function

  Future<List<Data>?> getData() async {
    final result = await http.get(
        Uri.parse("https://dummyapi.io/data/v1/user?limit=10"),
        headers: {"app-id": "61dbf9b1d7efe0f95bc1e1a6"});
    final jsonData = jsonDecode(result.body);

    var data = Listjson.fromJson(jsonData).data;
    return data;
  }
}
