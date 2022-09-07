import 'package:crepes/constants/constants.dart';
import 'package:intl/intl.dart';

class GlobalService {
  String getImage(String imageUrlSuffix) {
    return '$imageUrlPrefix$imageUrlSuffix';
  }
}

final numberFormat = NumberFormat("##,##0.00", "en_US");
String formatDollars(int money) {
  return '\$${numberFormat.format(money / 100)}';
}

int getTotalPrice(quantity, price) {
  return quantity * price;
}
