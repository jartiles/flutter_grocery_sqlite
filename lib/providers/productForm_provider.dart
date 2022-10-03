import 'package:flutter/material.dart';

class ProductFormProvider extends ChangeNotifier {
  GlobalKey<FormState> productsFormKey = GlobalKey<FormState>();
  String productName = '';
  double productPrice = 0;
  int productQty = 1;

  increaseDecrease(bool increase) {
    if (increase) {
      productQty++;
    } else if (productQty > 1) {
      productQty--;
    }
    notifyListeners();
  }

  reset() {
    productName = '';
    productPrice = 0;
    productQty = 1;
  }

  bool isValidForm() => productsFormKey.currentState?.validate() ?? false;
}
