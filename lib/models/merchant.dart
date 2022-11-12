import 'package:json_annotation/json_annotation.dart';

/// This allows the `Merchant` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'merchant.g.dart';

/// An annotation for the code generator to know that this class needs the
/// JSON serialization logic to be generated.
@JsonSerializable()
class Merchant {
  Merchant({
    required this.id,
    required this.merchantName,
    required this.name,
    required this.email,
    this.phone,
    this.avatar,
  });

  int id;
  String merchantName;
  String name;
  String email;

  @JsonKey(defaultValue: '')
  String? phone;

  @JsonKey(defaultValue: '')
  String? avatar;

  /// A necessary factory constructor for creating a new Merchant instance
  /// from a map. Pass the map to the generated `_$MerchantFromJson()` constructor.
  /// The constructor is named after the source class, in this case, Merchant.
  factory Merchant.fromJson(Map<String, dynamic> json) =>
      _$MerchantFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$MerchantToJson`.
  Map<String, dynamic> toJson() => _$MerchantToJson(this);
}
