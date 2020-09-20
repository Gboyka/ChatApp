import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gupshup/helper/authenticate.dart';
import 'package:gupshup/helper/constants.dart';
import 'package:gupshup/helper/helperfunctions.dart';
import 'package:gupshup/modules/tiles.dart';
import 'package:gupshup/services/auth.dart';
import 'package:gupshup/services/database.dart';
import 'package:gupshup/views/searchScreen.dart';
import 'package:gupshup/views/signin.dart';
import 'package:gupshup/widget/widget.dart';

class ChatRoom extends StatefulWidget{
  @override
  _ChatRoomState createState()=> _ChatRoomState();

}



class _ChatRoomState extends State<ChatRoom>{

  AuthMethods authMethods=new AuthMethods();
  DatabaseMethods databaseMethods=new DatabaseMethods();

  Stream chatRoomStream;

  Widget chatRoomList(){
    return StreamBuilder(
      stream: chatRoomStream,
      builder: (context,snapshot){
        return snapshot.hasData? ListView.builder(
            itemCount: snapshot.data.documents.length,
            itemBuilder: (context,index){
                  return ChatRoomTile(
                    snapshot.data.documents[index].data()['chatRoomId']
                        .toString()
                        .replaceAll("_", "")
                        .replaceAll(Constants.myName,""),
                      snapshot.data.documents[index].data()['chatRoomId']);
            }):Container();
      },
    );
  }
  @override
  void initState() {


    print("hello");

    getUserInfoGetChats();


    super.initState();
  }

  getUserInfoGetChats()async{
     Constants.myName=await HelperFunction.getUserNameSharedPreference();

    Stream snap= await databaseMethods.getChatRooms(Constants.myName);

     setState(() {
       chatRoomStream=snap;
     });


     }



  @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar:AppBar(

       title:Text('Chats'),
       actions: [
         GestureDetector(
           onTap: (){
              authMethods.signMeOut();
              Navigator.pushReplacement(context, MaterialPageRoute(
                builder:(context)=>Authenticate()
              )
              );
           },
         child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
                child:Icon(Icons.exit_to_app),

          ),
        ),
      ],
     ),
    body: chatRoomList(),
    floatingActionButton: FloatingActionButton(
         child:Icon(Icons.search),
         onPressed: (){
          Navigator.push(context, MaterialPageRoute(
            builder: (context)=>Search()
          ));
         },


   ),
   );
  }


}