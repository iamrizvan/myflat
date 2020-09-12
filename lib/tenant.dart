import 'package:cloud_firestore/cloud_firestore.dart';

class Tenant {
  String name;
  String package;
  String mobile;
  String joiningDate;

  List<Tenant> tenants = List<Tenant>();
  DocumentReference reference;

  Tenant(this.name, this.package, this.mobile, this.joiningDate);

 

  factory Tenant.fromSnapshot(DocumentSnapshot snapshot) {
    Tenant newTenant = Tenant.fromJson(snapshot.data);
    newTenant.reference = snapshot.reference;
    return newTenant;
  }

  factory Tenant.fromJson(Map<String, dynamic> json) => _TenantFromJson(json);

  Map<String, dynamic> toJson() => _TenantToJson(this);

  @override
  String toString() => "Tenant<$name>";
}

Map<String, dynamic> _TenantToJson(Tenant tenant) => <String, dynamic>{
      'name': tenant.name,
      'package': tenant.package,
      'mobile': tenant.mobile,
      'joiningDate': tenant.joiningDate,
    };

Tenant _TenantFromJson(Map<String, dynamic> json) {
  return Tenant(json['name'] as String, json['package'] as String,
      json['mobile'] as String, json['joiningDate'] as String);
}
