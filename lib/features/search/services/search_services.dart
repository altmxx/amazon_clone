import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../../../constants/error_handling.dart';
import '../../../constants/global_variables.dart';
import '../../../constants/utils.dart';
import '../../../models/product.dart';
import '../../../providers/user_provider.dart';

class SearchServices {
  Future<List<Product>> fetchSearchedProduct({
    required BuildContext context,
    required String searchQuery,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Product> productList = [];
    try {
      var response = await http.get(
          Uri.parse('$uri/api/products/search/$searchQuery'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': userProvider.user.token,
          });
      // log("response body is");
      // log(response.body);
      // ignore: use_build_context_synchronously
      httpErrorHandling(
          response: response,
          context: context,
          onSuccess: () {
            for (int i = 0; i < jsonDecode(response.body).length; i++) {
              productList.add(Product.fromJson(jsonEncode(
                jsonDecode(response.body)[i],
              )));
              // log(productList[i].toString());
              // log(productList[i].price.toString());
            }
          });
    } catch (e) {
      showSnackbar(context, e.toString());
      log(e.toString());
    }
    return productList;
  }
}
