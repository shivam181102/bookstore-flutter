import 'package:bookstore/global/models/bookModel.dart';

class Cartbookmodel {
  Bookmodel product;
  int quantityToBuy;
  String id, Uname, Uemail, phone;
  List? Address;
  Cartbookmodel(
      {this.Address,
      required this.Uemail,
      required this.Uname,
      required this.id,
      required this.phone,
      required this.product,
      required this.quantityToBuy});
}
