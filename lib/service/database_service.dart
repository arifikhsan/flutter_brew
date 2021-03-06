import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_brew/model/brew.dart';
import 'package:flutter_brew/model/user.dart';

class DatabaseService {
  final String uid;

  final CollectionReference brewCollection =
      Firestore.instance.collection('brews');

  DatabaseService({this.uid});

  Future updateUserData(String sugars, String name, int strength) async {
    return await brewCollection.document(uid).setData({
      'sugars': sugars,
      'name': name,
      'strength': strength,
    });
  }

  List<Brew> _brewListFromShapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((document) {
      return Brew(
        name: document.data['name'] ?? '',
        sugars: document.data['sugars'] ?? '0',
        strength: document.data['strength'] ?? 0,
      );
    }).toList();
  }

  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      name: snapshot.data['name'],
      sugars: snapshot.data['sugars'],
      strength: snapshot.data['strength'],
    );
  }

  Stream<List<Brew>> get brews {
    return brewCollection.snapshots().map(_brewListFromShapshot);
  }

  Stream<UserData> get userData {
    return brewCollection.document(uid).snapshots().map(_userDataFromSnapshot);
  }
}
