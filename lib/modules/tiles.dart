import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gupshup/views/coversationScreen.dart';
import 'package:gupshup/views/searchScreen.dart';
import 'package:gupshup/helper/helperfunctions.dart';

class BlankTile extends StatelessWidget {
   final bool searchButton;
  final String name;
  BlankTile({this.searchButton,this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 16,vertical: 8),
        child:ListTile(
          title:!searchButton ||(name.length==0) ?Text('Result will appear here')
              :Text('No Result for '+ '"'+name+'"'),

          leading: CircleAvatar(
              child:searchButton?
              Icon(Icons.youtube_searched_for):
              Icon(Icons.error_outline)
          ),
        )
    );
  }

}

class MessageTile extends StatelessWidget {
 final String message;
 final bool isSendByMe;
 MessageTile(this.message,this.isSendByMe);



  @override
  Widget build(BuildContext context) {

    return Container(
      padding: EdgeInsets.only(left: 5,right: 5,top: 5),
      width: MediaQuery.of(context).size.width,
      alignment: isSendByMe?Alignment.centerRight:Alignment.centerLeft,
      child:Container(

        padding: EdgeInsets.symmetric(horizontal: 24,vertical: 8),

        child: Text(message,style: TextStyle(
          fontSize: 20,
        ),),
        decoration:BoxDecoration(
            color: isSendByMe?Colors.blue:Colors.teal,
            borderRadius: isSendByMe?BorderRadius.only(
                topLeft: Radius.circular(23),
                topRight: Radius.circular(23),
                bottomLeft: Radius.circular(23)
            ):BorderRadius.only(
                bottomLeft: Radius.circular(23),
                bottomRight: Radius.circular(23),
                topRight: Radius.circular(23)
            )
        ),
      ),


    );
  }
}


class ChatRoomTile extends StatelessWidget {
  final String userName;
  final String chatRoomId;
  ChatRoomTile(this.userName,this.chatRoomId);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.pushReplacement(context,MaterialPageRoute(
          builder: (context)=>ConversationScreen(chatRoomId)
        ));
      },
      child: Container(
        padding: EdgeInsets.only(left: 8.0,top:10.0 ),

        child:Row(
          children: <Widget>[
            Container(
             alignment: Alignment.center,
              height: 65,
              width: 65,
              child: Text('${userName.substring(0,1).toUpperCase()}',
                  style: TextStyle(
                  fontSize: 35.0,
                  fontWeight:FontWeight.w800,

                  ),),

              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(40)

              ),
            ),
            SizedBox(width: 8,),
            Text(userName,style: TextStyle(fontSize: 20),)
          ],
        )
      ),
    );
  }
}



