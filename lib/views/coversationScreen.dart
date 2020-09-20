import 'package:flutter/material.dart';
import 'package:gupshup/helper/constants.dart';
import 'package:gupshup/services/database.dart';
import 'package:gupshup/widget/widget.dart';
import 'package:gupshup/modules/tiles.dart';

class ConversationScreen extends StatefulWidget {
  final String chatRoomId;
  ConversationScreen(this.chatRoomId);

  @override
  _ConversationScreenState createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {

  TextEditingController messageController=new TextEditingController();
  DatabaseMethods databaseMethods=new DatabaseMethods();

  Stream chatMessageStream;

 Widget ChatMessageList(){
  return StreamBuilder(
    stream: chatMessageStream,
    builder: (context,snapshot){

          return snapshot.hasData?ListView.builder(
              itemCount: snapshot.data.documents.length,
              itemBuilder: (context,index){
            return MessageTile(snapshot.data.documents[index].data()['message'],
                (snapshot.data.documents[index].data()['sendBy'])==Constants.myName);
          }
      ):Container();

    },
  );
 }


 sendMessage() {
   if (messageController.text.isNotEmpty) {
     Map<String, dynamic> messageMap = {
       'message': messageController.text,
       'sendBy': Constants.myName,
       'time':DateTime.now().millisecondsSinceEpoch
     };

     databaseMethods.addConversationMessages(widget.chatRoomId,messageMap);
      messageController.text="";
   }

 }


@override
  void initState() {
  chatMessageStream= databaseMethods.getConversationMessages(widget.chatRoomId);

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body:Container(
        child:Stack(
          children: <Widget>[
            ChatMessageList(),
            Container(
              alignment:Alignment.bottomCenter ,
              child: Container(
              //  color: Colors.white70,
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 18),

                child: Row(
                  children: <Widget>[
                    Expanded(
                        child: TextField(
                          controller: messageController,
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.black87
                          ),
                          decoration: InputDecoration(
                              hintText: 'Start Typing....',
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

                    RaisedButton(
                      padding: EdgeInsets.symmetric(horizontal: 50.0,vertical: 25.0),
                      child: Image.asset('./assets/images/send.png',height: 35,width:35,),
                      color: Colors.white,
                      elevation: 8.0,
                      shape: CircleBorder(),

                      onPressed: () {

                        sendMessage();

                      },
                    ),


                  ],
                ),
              ),
            ),
          ],
        )
      )
    );
  }
}
