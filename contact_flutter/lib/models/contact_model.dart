class ContactModel {
  int? id;
  String name;
  String phoneNumber;
  int ownerId;

  ContactModel({
    this.id,
    required this.name,
    required this.phoneNumber,
    required this.ownerId,
  });

  factory ContactModel.fromJson(Map<String, dynamic> json) {
    return ContactModel(
      id: json['id'] ?? json['id'],
      name: json['name'] ?? '',
      phoneNumber: json['phone_number'] ?? json['phoneNumber'] ?? '',
      ownerId: json['owner_id'] ?? json['ownerId'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'name': name,
      'phone_number': phoneNumber,
      'owner_id': ownerId,
    };
  }

  @override
  String toString() {
    return 'ContactModel{id: $id, name: $name, phoneNumber: $phoneNumber, ownerId: $ownerId}';
  }
}
