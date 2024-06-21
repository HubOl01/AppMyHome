class CallModel {
  final String id;
  final String city;
  final String name;
  final String description;
  final String email;
  final String street;
  final List<dynamic> tel;
  CallModel(
      {this.id = '',
      required this.city,
      required this.name,
      required this.description,
      required this.email,
      required this.street,
      required this.tel});

  CallModel copyWith({
    String? id,
    String? city,
    String? name,
    String? description,
    String? email,
    String? street,
    List<dynamic>? tel,
  }) =>
      CallModel(
          id: id ?? this.id,
          city: city ?? this.city,
          name: name ?? this.name,
          description: description ?? this.description,
          email: email ?? this.email,
          street: street ?? this.street,
          tel: tel ?? this.tel);

  Map<String, dynamic> toJson() => {
        'id': id,
        'city': city,
        'name': name,
        'description': description,
        'email': email,
        'street': street,
        'tel': tel,
      };

  static CallModel fromJson(Map<String, dynamic> json) => CallModel(
        id: json['id'],
        city: json['city'],
        name: json['name'],
        description: json['description'],
        email: json['email'],
        street: json['street'],
        tel: json['tel'],
      );
}
