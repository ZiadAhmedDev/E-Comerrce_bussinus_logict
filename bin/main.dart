import 'dart:io';

import 'package:test/Cart.dart';
import 'package:test/product.dart';

/* 
  loop
    prompt:view cart/ add item / checkout
    if selection == add item
      choose product
      add it to cart
      print cart
    else if selection == view cart
      print cart
    else if selection == checkout
      do  checkout 
      exit
    end
*/

const allProducts = [
  Product(id: 1, name: 'apples', price: 1.60),
  Product(id: 2, name: 'bananas', price: 0.70),
  Product(id: 3, name: 'courgettes', price: 1.0),
  Product(id: 4, name: 'grapes', price: 2.00),
  Product(id: 5, name: 'mushrooms', price: 0.80),
  Product(id: 6, name: 'potatoes', price: 1.50),
];
void main() {
  final cart = Cart();
  while (true) {
    stdout.write(
        'What do you want to do? (v)iew items, (a)dd item, (c)heckout: ');
    final line = stdin.readLineSync();
    if (line == "a") {
      final product = chooseProduct();
      if (product != null) {
        cart.addProduct(product);
        print(cart);
      }
    } else if (line == "v") {
      print(cart);
    } else if (line == "c") {
      if (checkout(cart)!) {
        break;
      }
    }
  }
}

Product? chooseProduct() {
  final productList =
      allProducts.map((product) => product.displayName).join('\n');
  stdout.write('Available Product:\n$productList\nYour choice:');
  final line = stdin.readLineSync();
  for (var product in allProducts) {
    if (product.initial == line) {
      return product;
    }
  }
  print('Not Found');
  return null;
}

bool? checkout(Cart cart) {
  if (cart.isEmpty) {
    print('cart is empty');
    return false;
  }
  final total = cart.total();
  print('Total: \$$total');
  stdout.write('Payment in cash:');
  final line = stdin.readLineSync();
  if (line == null || line.isEmpty) {
    return false;
  }
  final paid = double.tryParse(line);
  if (paid == null) {
    print('Don\'t joke with me, I want money');
    return false;
  }
  if (paid >= total) {
    final change = paid - total;
    print('change: \$${change.toStringAsFixed(2)}');
    return true;
  }
  if (paid < total) {
    print('The cash is not Enough');
    return false;
  }
}
