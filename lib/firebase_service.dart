import 'package:cloud_firestore/cloud_firestore.dart';
import './tenant.dart';

class FirebaseService{
  Firestore _fireStoreDataBase = Firestore.instance;

  //recieve the data
 
  Stream<List<Tenant>> getTenants() {
    return _fireStoreDataBase.collection('myflat')
        .snapshots()
        .map((snapShot) => snapShot.documents
        .map((document) => Tenant.fromJson(document.data))
        .toList());
  }
}
