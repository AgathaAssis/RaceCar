// ignore_for_file: file_names

class RaceCar {
  final int id;
  final int brandId;
  final String name;
  final int year;
  final String color;
  final int price;
  final String imageURL;

  RaceCar(this.id, this.brandId, this.name, this.year, this.color, this.price, this.imageURL);

  static RaceCar fromJson(json) {
    return RaceCar(
      json['id'],
      json['brandId'],
      json['name'],
      json['year'],
      json['color'],
      json['price'],
      json['imageURL'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'brandId': brandId,
    'name': name,
    'year': year,
    'color': color,
    'price': price,
    'imageURL': imageURL,
  };
}
