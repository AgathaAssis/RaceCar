class Brand {
  final int id;
  final String name;
  final String country;
  final int inauguratedIn;

  Brand(this.id, this.name, this.country, this.inauguratedIn);

  static fromJson(json) {
    return Brand(
      json['id'],
      json['name'],
      json['country'],
      json['inauguratedIn'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'country': country,
    'inauguratedIn': inauguratedIn,
  };
}