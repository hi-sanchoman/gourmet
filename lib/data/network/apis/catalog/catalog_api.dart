import 'dart:async';

import 'package:dio/dio.dart';
import 'package:esentai/data/network/constants/endpoints.dart';
import 'package:esentai/data/network/dio_client.dart';
import 'package:esentai/data/network/rest_client.dart';
import 'package:esentai/models/catalog/category_list.dart';
import 'package:esentai/models/catalog/gift.dart';
import 'package:esentai/models/catalog/gift_list.dart';
import 'package:esentai/models/catalog/product.dart';
import 'package:esentai/models/catalog/product_list.dart';
import 'package:esentai/models/catalog/search_list.dart';
import 'package:esentai/models/favorites/favorite_list.dart';
import 'package:esentai/models/gift/package_list.dart';
import 'package:esentai/models/gift/postcard_list.dart';
import 'package:esentai/models/info/banner.dart';
import 'package:esentai/models/info/banner_list.dart';
import 'package:esentai/models/info/info.dart';
import 'package:esentai/models/info/info_list.dart';
import 'package:esentai/models/message.dart';
import 'package:esentai/models/post/post_list.dart';

class CatalogApi {
  // dio instance
  final DioClient _dioClient;

  // rest-client instance
  final RestClient _restClient;

  // injecting dio instance
  CatalogApi(this._dioClient, this._restClient);

  /// Returns list in response
  Future<CategoryList> getCategories() async {
    try {
      final res = await _dioClient.get(Endpoints.getCategoryList);
      return CategoryList.fromJson(res);
    } catch (e) {
      // print(e.toString());
      throw e;
    }
  }

  // get products by subcategories
  Future<ProductList> getProducts(
      List<int> subcategories, String orderBy, String? token) async {
    var params = {
      "sub_categories_id": subcategories.join(","),
      'ordering': orderBy
    };

    Options? options = Options();
    if (token != null && token.isNotEmpty) {
      options = Options(headers: {"Authorization": "JWT $token"});
    }

    // print("data are: $params, $token, ${options?.headers}");

    try {
      final res = await _dioClient.get(Endpoints.getProducts,
          queryParameters: params, options: options);

      // print('res for products... $res');

      return ProductList.fromJson(res);
    } catch (e) {
      throw e;
    }
  }

  // search products
  Future<SearchList> searchProducts(String query, String? token) async {
    try {
      var params = {"search": query};

      var options;
      if (token != null && token.isNotEmpty)
        options = Options(headers: {"Authorization": "JWT $token"});

      final res = await _dioClient.get(Endpoints.searchProducts,
          queryParameters: params, options: options);

      // print('res for products... $res');

      return SearchList.fromMap(res);
    } catch (e) {
      return SearchList();
      // throw e;
    }
  }

  // get main gifts
  Future<GiftList> getMainGifts(String? token) async {
    try {
      var options;
      if (token != null && token.isNotEmpty)
        options = Options(headers: {"Authorization": "JWT $token"});

      final res =
          await _dioClient.get(Endpoints.getMainGifts, options: options);

      // print('res for gifts... $res');

      return GiftList.fromJson(res);
    } catch (e) {
      throw e;
    }
  }

  // get main products
  Future<ProductList> getMainProducts(String? token) async {
    try {
      var options;
      if (token != null && token.isNotEmpty)
        options = Options(headers: {"Authorization": "JWT $token"});

      final res =
          await _dioClient.get(Endpoints.getMainProducts, options: options);

      // print('res for products... $res');

      return ProductList.fromJson(res);
    } catch (e) {
      throw e;
    }
  }

  // get other products
  Future<ProductList> getOtherProducts(int productId, String? token) async {
    var params = {
      "product_id": productId,
      "page": {"size": 3}
    };

    try {
      var options;
      if (token != null && token.isNotEmpty)
        options = Options(headers: {"Authorization": "JWT $token"});

      final res = await _dioClient.get(Endpoints.getMainProducts,
          options: options, queryParameters: params);

      // print('res for products... $res');

      return ProductList.fromJson(res);
    } catch (e) {
      throw e;
    }
  }

  // get other gifts
  Future<ProductList> getOtherGifts(int giftId, String? token) async {
    var params = {
      "gift_id": giftId,
      "page": {"size": 3}
    };

    try {
      var options;
      if (token != null && token.isNotEmpty)
        options = Options(headers: {"Authorization": "JWT $token"});

      final res = await _dioClient.get(Endpoints.getMainGifts,
          options: options, queryParameters: params);

      // print('res for products... $res');

      return ProductList.fromJson(res);
    } catch (e) {
      throw e;
    }
  }

  // get favorites
  Future<FavoriteList> getFavorites(String token) async {
    try {
      final res = await _dioClient.get(Endpoints.getFavorites,
          options: Options(headers: {"Authorization": "JWT $token"}));
      return FavoriteList.fromJson(res);
    } catch (e) {
      throw e;
    }
  }

  // add to fav
  Future<Message> toggleFav(String token, int id, String type) async {
    var data;

    if (type == 'product') data = {'favorite_product': id};
    if (type == 'gift') data = {'favorite_gift': id};

    try {
      final res = await _dioClient.post(
          Endpoints.toggleFav.toString().replaceFirst(':id', id.toString()),
          data: data,
          options: Options(headers: {"Authorization": "JWT $token"}));

      // print('res is ... $res');

      return Message.fromMap(res);
    } catch (e) {
      throw e;
    }
  }

  // get info page
  Future<InfoList> getInfoPage(String slug) async {
    var params = {"slug": slug};
    try {
      final res =
          await _dioClient.get(Endpoints.getInfoPage, queryParameters: params);
      return InfoList.fromMap(res);
    } catch (e) {
      throw e;
    }
  }

  // get banners
  Future<BannerList> getBanners() async {
    try {
      final res = await _dioClient.get(Endpoints.getBanners);
      return BannerList.fromMap(res);
    } catch (e) {
      throw e;
    }
  }

  // get banner by id
  Future<BannerPage> getBannerById(int id) async {
    try {
      final res = await _dioClient.get(Endpoints.getBannerById
          .toString()
          .replaceFirst(':id', id.toString()));
      return BannerPage.fromMap(res);
    } catch (e) {
      throw e;
    }
  }

  // get product by id
  Future<Product> getProductById(int id) async {
    try {
      final res = await _dioClient.get(Endpoints.getProductById
          .toString()
          .replaceFirst(':id', id.toString()));
      return Product.fromMap(res);
    } catch (e) {
      throw e;
    }
  }

  // get banner by id
  Future<Gift> getGiftById(int id) async {
    try {
      final res = await _dioClient.get(
          Endpoints.getGiftById.toString().replaceFirst(':id', id.toString()));
      return Gift.fromMap(res);
    } catch (e) {
      throw e;
    }
  }

  // get packages
  Future<PackageList> getPackages() async {
    // Options? options = Options();
    // if (token != null && token.isNotEmpty) {
    //   options = Options(headers: {"Authorization": "JWT $token"});
    // }

    try {
      final res = await _dioClient.get(Endpoints.getPackages);

      return PackageList.fromMap(res);
    } catch (e) {
      throw e;
    }
  }

  // get postcards
  Future<PostcardList> getPostcards() async {
    // Options? options = Options();
    // if (token != null && token.isNotEmpty) {
    //   options = Options(headers: {"Authorization": "JWT $token"});
    // }

    try {
      final res = await _dioClient.get(Endpoints.getPostcards);

      return PostcardList.fromMap(res);
    } catch (e) {
      throw e;
    }
  }
}
