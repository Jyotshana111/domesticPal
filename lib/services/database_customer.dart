import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:domestic_pal/models/user.dart';

class DatabaseCustomerService {
  final String uid;
  DatabaseCustomerService({this.uid});

  //collection reference
  final CollectionReference customerCollection =
      Firestore.instance.collection('customers');
  Future updateCustomerUserData(
      String userCatagory, String name, String phone, String city) async {
    return await customerCollection.document(uid).setData({
      'userCatagory': userCatagory,
      'name': name,
      'phone': phone,
      'city': city
    });
  }

  Stream<QuerySnapshot> get customers {
    return customerCollection.snapshots();
  }

  //get user doc stream
  Stream<CustomerUserData> get customerUserData {
    return customerCollection
        .document(uid)
        .snapshots()
        .map(_customerUserDataFromSnapshot);
  }

  //user data from snapshot
  CustomerUserData _customerUserDataFromSnapshot(DocumentSnapshot snapshot) {
    return CustomerUserData(
      uid: uid,
      userCategory: snapshot.data['userCategory'],
      name: snapshot.data['name'],
      phone: snapshot.data['phone'],
      city: snapshot.data['city'],
    );
  }
}
