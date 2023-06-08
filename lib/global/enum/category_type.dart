import 'package:json_annotation/json_annotation.dart';

@JsonEnum(valueField: 'value')
enum CategoryType {
  daily('DAILY', '일상'),
  mart('MART', '마트'),
  hairShop('HAIR_SHOP', '미용실'),
  restaurant('RESTAURANT', '음식점'),
  cafe('CAFE', '카페'),
  hotel('HOTEL', '호텔'),
  pension('PENSION', '펜션');
  // daily('DAILY', '일상'),
  // meetup('MEETUP', '모임'),
  // drink('DRINK', '술한잔?'),
  // eat('EAT', '밥한끼?'),
  // trade('TRADE', '중고거래'),
  // information('INFORMATION', '정보공유');

  final String value;
  final String title;

  const CategoryType(this.value, this.title);
}
