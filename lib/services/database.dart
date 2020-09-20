import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods{

 Future getUserByUsername(String username)async {
    return  await FirebaseFirestore.instance.collection('users')
      .where("name", isEqualTo: username).get();
 }

 getUserByEmail(String userEmail) async{
  return await FirebaseFirestore.instance.collection('users')
      .where("email", isEqualTo: userEmail).get();
 }

  uploadUserInfo(userMap){
   FirebaseFirestore.instance.collection('users').add(userMap);

  }


 createChatRooms(String chatRoomId,chatRoomMap){
  FirebaseFirestore.instance
      .collection(('chatRooms'))
      .doc(chatRoomId)
      .set(chatRoomMap).catchError((e){
   print (e.toString);
  });
}

addConversationMessages(String chatRoomId,messageMap){

   FirebaseFirestore.instance
      .collection('chatRooms')
      .doc(chatRoomId).collection('chats')
      .add(messageMap).catchError((e){print(e.toString());});
 }

getConversationMessages(String chatRoomId){

  return   FirebaseFirestore.instance
      .collection('chatRooms')
      .doc(chatRoomId).collection('chats').orderBy('time',descending: false)
      .snapshots();

 }

 getChatRooms(String userName)
 {
  return  FirebaseFirestore.instance
      .collection('chatRooms')
      .where('users',arrayContains: userName)
      .snapshots();
 }



}