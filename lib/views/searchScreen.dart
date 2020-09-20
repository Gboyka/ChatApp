import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gupshup/helper/constants.dart';
import 'package:gupshup/helper/helperfunctions.dart';
import 'package:gupshup/modules/tiles.dart';
import 'package:gupshup/services/database.dart';
import 'package:gupshup/views/coversationScreen.dart';
import 'package:gupshup/widget/widget.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

String _myName;

class _SearchState extends State<Search> {

  TextEditingController searchTextEditingController = new TextEditingController();
  DatabaseMethods databaseMethods = new DatabaseMethods();
  QuerySnapshot searchSnapshot;
  int resultLength = 0;

  final snackBar=SnackBar(content: Text("Hello ${Constants.myName}"));


  Future initiateSearch() async {
    if(searchTextEditingController.text!=Constants.myName) {
      await databaseMethods
          .getUserByUsername(searchTextEditingController.text)
          .then((value) {
        setState(() {
          searchSnapshot = value;
          resultLength = searchSnapshot.docs.length;
        });
        // print(value);
      });
    }

  }

  @override
  void initState(){
    //
    getUserInfo();

    super.initState();
  }


  getUserInfo() async {
    Constants.myName = await HelperFunction.getUserNameSharedPreference();

  }

  createConversation(String userName) {


      String chatRoomId = getChatRoomID(userName, Constants.myName);
      List<String> users = [userName, Constants.myName];

      Map<String, dynamic>chatRoomMap = {
        "users": users,
        "chatRoomId": chatRoomId
      };
      databaseMethods.createChatRooms(chatRoomId, chatRoomMap);
      Navigator.push(context, MaterialPageRoute(
          builder: (context) => ConversationScreen(chatRoomId)
      ));


  }

  Widget searchList() {
    return resultLength != 0 ? ListView.builder(
        shrinkWrap: true,
        itemCount: searchSnapshot.docs.length,
        itemBuilder: (context, index) {
          return SearchTile(
            userName: searchSnapshot.docs[index].data()["name"],
            userEmail: searchSnapshot.docs[index].data()["email"],
          );
        }
    ) : BlankTile(
      searchButton: true,
      name: searchTextEditingController.text,

    );
  }


  Widget SearchTile({String userName, String userEmail}) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: ListTile(
            title: Text(userName),
            subtitle: Text(userEmail),
            leading: CircleAvatar(
                child: Icon(Icons.account_circle)
            ),
            trailing: GestureDetector(
              child: Icon(Icons.message),
              onTap: () {
                createConversation(userName);
              },
            )
        )
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search chat'),
      ),
      body: Container(
        // padding: EdgeInsets.only(left: 16),
        child: Column(
          children: [
            Container(
              color: Colors.white70,
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 18),

              child: Row(
                children: <Widget>[
                  Expanded(
                      child: TextField(
                        controller: searchTextEditingController,
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.black87
                        ),
                        decoration: InputDecoration(
                            hintText: '  Username ...',
                            hintStyle: TextStyle(
                                color: Colors.black45, fontSize: 20),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(
                                    15.0)),
                                borderSide: BorderSide(color: Colors.black)
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                                borderRadius: BorderRadius.all(Radius.circular(
                                    15.0))
                            )

                        ),

                      )
                  ),

                  GestureDetector(
                    // onTap: ,
                    child: Container(
                      height: 60,
                      width: 60,
                      padding: EdgeInsets.symmetric(horizontal: 16,),
                      child: InkWell(
                        child: Icon(Icons.search, size: 40,),
                        onTap: () {
                          if(searchTextEditingController.text!=Constants.myName)
                          initiateSearch();
                          else
                          print("hey");

                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(

                child: Column(
                    children: [
                      //  BlankTile(searchButton:false),
                      searchList()

                    ])
            )
          ],

        ),
      ),
    );
  }


  getChatRoomID(String u1, String u2) {
  //  if (u1.substring(0, 1).codeUnitAt(0) > u2.substring(0, 1).codeUnitAt(0))
     // return "$u2\_$u1";
   // else
      return "$u1\_$u2";
  }


}
