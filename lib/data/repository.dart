import 'dart:async';

import 'package:esentai/data/local/datasources/post/post_datasource.dart';
import 'package:esentai/data/sharedpref/constants/preferences.dart';
import 'package:esentai/data/sharedpref/shared_preference_helper.dart';
import 'package:esentai/models/address/address.dart';
import 'package:esentai/models/address/address_list.dart';
import 'package:esentai/models/auth/login_response.dart';
import 'package:esentai/models/auth/token_response.dart';
import 'package:esentai/models/catalog/category_list.dart';
import 'package:esentai/models/catalog/gift.dart';
import 'package:esentai/models/catalog/gift_list.dart';
import 'package:esentai/models/catalog/product.dart';
import 'package:esentai/models/catalog/product_list.dart';
import 'package:esentai/models/catalog/search_list.dart';
import 'package:esentai/models/catalog/search_result.dart';
import 'package:esentai/models/catalog/subcategory_list.dart';
import 'package:esentai/models/favorites/favorite_list.dart';
import 'package:esentai/models/gift/package_list.dart';
import 'package:esentai/models/gift/postcard_list.dart';
import 'package:esentai/models/info/banner.dart';
import 'package:esentai/models/info/banner_list.dart';
import 'package:esentai/models/info/info.dart';
import 'package:esentai/models/info/info_list.dart';
import 'package:esentai/models/message.dart';
import 'package:esentai/models/notification/notification_list.dart';
import 'package:esentai/models/order/order.dart';
import 'package:esentai/models/order/order_list.dart';
import 'package:esentai/models/order/order_result.dart';
import 'package:esentai/models/payment/creditcard_list.dart';
import 'package:esentai/models/post/post.dart';
import 'package:esentai/models/post/post_list.dart';
import 'package:esentai/models/user/user.dart';
import 'package:sembast/sembast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/order/rx_bonus.dart';
import 'local/constants/db_constants.dart';
import 'network/apis/catalog/catalog_api.dart';
import 'network/apis/posts/post_api.dart';
import 'network/apis/users/user_api.dart';

class Repository {
  // data source object
  final PostDataSource _postDataSource;

  // api objects
  final CatalogApi _catalogApi;
  final UserApi _userApi;

  // shared pref object
  final SharedPreferenceHelper _sharedPrefsHelper;

  // constructor
  Repository(this._catalogApi, this._userApi, this._sharedPrefsHelper,
      this._postDataSource);

  // Post: ---------------------------------------------------------------------
  // Future<PostList> getPosts() async {
  //   // check to see if posts are present in database, then fetch from database
  //   // else make a network call to get all posts, store them into database for
  //   // later use
  //   return await _postApi.getPosts().then((postsList) {
  //     postsList.posts?.forEach((post) {
  //       _postDataSource.insert(post);
  //     });

  //     return postsList;
  //   }).catchError((error) => throw error);
  // }

  // Future<List<Post>> findPostById(int id) {
  //   //creating filter
  //   List<Filter> filters = [];

  //   //check to see if dataLogsType is not null
  //   Filter dataLogTypeFilter = Filter.equals(DBConstants.FIELD_ID, id);
  //   filters.add(dataLogTypeFilter);

  //   //making db call
  //   return _postDataSource
  //       .getAllSortedByFilter(filters: filters)
  //       .then((posts) => posts)
  //       .catchError((error) => throw error);
  // }

  // Future<int> insert(Post post) => _postDataSource
  //     .insert(post)
  //     .then((id) => id)
  //     .catchError((error) => throw error);

  // Future<int> update(Post post) => _postDataSource
  //     .update(post)
  //     .then((id) => id)
  //     .catchError((error) => throw error);

  // Future<int> delete(Post post) => _postDataSource
  //     .update(post)
  //     .then((id) => id)
  //     .catchError((error) => throw error);

  // Login:---------------------------------------------------------------------
  Future<LoginResponse> login(String userId) async {
    return await _userApi.login(userId).catchError((e) {
      // print("login error repository: $e");
      throw e;
    });
  }

  // Activate user
  Future<LoginResponse> activateUser(String userId, String code) async {
    return await _userApi.activateUser(userId, code).catchError((e) {
      throw e;
    });
  }

  // Register
  Future<LoginResponse> register(
      String userId, String email, String fullName, String birthday) async {
    return await _userApi
        .register(userId, email, fullName, birthday)
        .catchError((e) {
      throw e;
    });
  }

  // Resend SMS
  Future<LoginResponse> resendSMS(String userId) async {
    return await _userApi.resendSMS(userId).catchError((e) {
      throw e;
    });
  }

  // JWT create token
  Future<TokenResponse> getToken(String username, String password) async {
    return await _userApi.createJwtToken(username, password).catchError((e) {
      throw e;
    });
  }

  // get available bonuses
  Future<RxBonus> getBonuses(String token, dynamic data) async {
    return await _userApi.getBonuses(token, data).catchError((e) {
      throw e;
    });
  }

  // pay & receive bonuses
  Future<bool> processBonuses(String token, dynamic data) async {
    return await _userApi.processBonuses(token, data).catchError((e) {
      throw e;
    });
  }

  // get profile
  Future<User> getProfile(String token) async {
    return await _userApi.getProfile(token).catchError((e) {
      throw e;
    });
  }

  // update profile
  Future<User> updateProfile(
      String token, String username, String fullname, String email) async {
    return await _userApi
        .updateProfile(token, username, fullname, email)
        .catchError((e) {
      throw e;
    });
  }

  //
  // CATALOG
  //

  // get categories
  Future<CategoryList> getCategories() async {
    return await _catalogApi.getCategories().then((list) {
      list.items?.forEach((item) {
        // _catalogDataSource.insert(item);
      });

      return list;
    }).catchError((error) => throw error);
  }

  // get main gifts
  Future<GiftList> getMainGifts(String? token) async {
    return await _catalogApi.getMainGifts(token).then((list) {
      return list;
    });
  }

  // get main products
  Future<ProductList> getMainProducts(String? token) async {
    return await _catalogApi.getMainProducts(token).then((list) {
      // list.items?.forEach((item) {});

      return list;
    });
  }

  // get other products
  Future<ProductList> getOtherProducts(int productId, String? token) async {
    return await _catalogApi.getOtherProducts(productId, token).then((list) {
      // list.items?.forEach((item) {});

      return list;
    });
  }

  // get other gifts
  Future<ProductList> getOtherGifts(int id, String? token) async {
    return await _catalogApi.getOtherGifts(id, token).then((list) {
      // list.items?.forEach((item) {});

      return list;
    });
  }

  // get subcategories
  Future<SubcategoryList> getSubcategories(List<int> subcategories,
      String orderBy, bool isActive, String? token) async {
    return await _catalogApi
        .getSubcategories(subcategories, orderBy, isActive, token)
        .then((list) {
      // list.items?.forEach((item) {});

      return list;
    });
  }

  // get products
  Future<ProductList> getProducts(List<int> subcategories, String orderBy,
      bool isActive, String? token) async {
    return await _catalogApi
        .getProducts(subcategories, orderBy, isActive, token)
        .then((list) {
      // list.items?.forEach((item) {});

      return list;
    });
  }

  // get packages
  Future<PackageList> getPackages() async {
    return await _catalogApi.getPackages().then((list) {
      // list.items?.forEach((item) {});

      return list;
    });
  }

  // get postcards
  Future<PostcardList> getPostcards() async {
    return await _catalogApi.getPostcards().then((list) {
      // list.items?.forEach((item) {});

      return list;
    });
  }

  // get product by id
  Future<Product> getProduct(int id) async {
    return await _catalogApi.getProductById(id).then((res) {
      return res;
    }).catchError((e) => throw e);
  }

  // get gift by id
  Future<Gift> getGift(int id) async {
    return await _catalogApi.getGiftById(id).then((res) {
      return res;
    }).catchError((e) => throw e);
  }

  // search autocomplete
  Future<ProductList> autocomplete(
    String query,
  ) async {
    ProductList result = ProductList(items: []);
    ProductList products = ProductList();
    GiftList gifts = GiftList();

    products = await _catalogApi.autocomplete(query).then((list) {
      return list;
    });

    if (products.items != null) {
      result.items!.addAll(products.items!);
    }

    gifts = await _catalogApi.searchGifts(query, null).then((list) {
      return list;
    });

    if (gifts.items != null) {
      result.items!.addAll(gifts.items!);
    }

    return result;
  }

  // search products
  Future<SearchList> searchProducts(String query, String? token) async {
    SearchList result = SearchList(items: []);

    SearchList foundProducts = SearchList();
    GiftList foundGifts = GiftList();

    // found products
    foundProducts = await _catalogApi.searchProducts(query, token).then((list) {
      return list;
    });

    if (foundProducts.items != null) {
      result.items!.addAll(foundProducts.items!);
    }

    // found gifts
    foundGifts = await _catalogApi.searchGifts(query, token).then((list) {
      return list;
    });

    if (foundGifts.items != null) {
      List<Map<String, dynamic>> list = [];

      for (Product item in foundGifts.items!) {
        list.add({
          "id": item.id,
          "name": item.name,
          "main_image": item.mainImage,
          "price": "${item.price}",
          "amount": item.amount,
          "is_active": item.isActive,
          "is_liked": item.isLiked,
          "is_new": item.isNew,
          "item_type": item.itemType,
        });
      }

      SearchResult giftsResult =
          SearchResult(id: -1, name: 'Подарочные наборы', products: list);

      result.items?.add(giftsResult);
    }

    return result;
  }

  // get favorites
  Future<FavoriteList> getFavorites(String token) async {
    return await _catalogApi.getFavorites(token).then((list) {
      return list;
    }).catchError((e) {
      // print("error favs: " + e.toString());
      // throw e;
    });
  }

  // toggle favorites
  Future<Message> toggleFav(String token, int id, String type) async {
    return await _catalogApi.toggleFav(token, id, type).then((res) {
      return res;
    }).catchError((e) {
      // print("error favs: " + e.toString());
      // throw e;
    });
  }

  // get info page
  Future<InfoList> getInfoPage(String slug) async {
    return await _catalogApi.getInfoPage(slug).then((res) {
      // list.items?.forEach((item) {});
      return res;
    });
  }

  // get banners
  Future<BannerList> getBanners() async {
    return await _catalogApi.getBanners().then((res) {
      return res;
    }).catchError((e) => throw e);
  }

  // get banner by id
  Future<BannerPage> getBanner(int id) async {
    return await _catalogApi.getBannerById(id).then((res) {
      return res;
    }).catchError((e) => throw e);
  }

  //
  // ORDERS
  //

  // create order
  Future<OrderResult> createOrder(
      String token, Map<String, dynamic> data) async {
    return await _userApi.createOrder(token, data).then((res) {
      return res;
    }).catchError((e) => throw e);
  }

  // get orders
  Future<OrderList> getOrders(String token) async {
    return await _userApi.getOrders(token).then((list) {
      return list;
    }).catchError((e) => throw e);
  }

  // get order details
  Future<Order> getOrderById(String token, int id) async {
    return await _userApi.getOrder(token, id).then((res) {
      return res;
    }).catchError((e) => throw e);
  }

  // submit review
  Future<Order> submitReview(String token, String review, int orderId) async {
    return await _userApi.submitReview(token, review, orderId).then((res) {
      return res;
    }).catchError((e) => throw e);
  }

  //
  // CREDIT CARD
  //

  // list cards
  Future<CardList> getCards(String token) async {
    return await _userApi.getCards(token).then((list) {
      return list;
    }).catchError((e) => throw e);
  }

  // add card -> get link
  Future<Message> addCard(String token) async {
    return await _userApi.addCard(token).then((res) {
      return res;
    }).catchError((e) => throw e);
  }

  // delete card
  Future<Message> deleteCard(String token, String id) async {
    return await _userApi.deleteCard(token, id).then((res) {
      return res;
    }).catchError((e) => throw e);
  }

  //
  // ADDRESS
  //

  // get addresses
  Future<AddressList> getAddresses(String token) async {
    return await _userApi.getAddresses(token).then((list) {
      return list;
    }).catchError((e) => throw e);
  }

  // delete address
  Future<bool> deleteAddress(String token, int id) async {
    return await _userApi.deleteAddress(token, id).then((res) {
      return res;
    }).catchError((e) => throw e);
  }

  // add address
  Future<Address> addAddress(String token, Map<String, Object> data) async {
    return await _userApi.addAddress(token, data).then((res) {
      return res;
    }).catchError((e) => throw e);
  }

  // get notifications
  Future<NotificationList> getNotifications(String? token) async {
    return await _userApi.getNotifications(token!).then((list) {
      return list;
    });
  }

  // delete notification
  Future<bool> deleteNotification(String token, int id) async {
    return await _userApi.deleteNotification(token, id).then((res) {
      return res;
    }).catchError((e) => throw e);
  }

  // delete notifications
  Future<bool> deleteAllNotifications(String token) async {
    return await _userApi.deleteAllNotifications(token).then((res) {
      return res;
    }).catchError((e) => throw e);
  }

  Future<void> saveIsLoggedIn(bool value) =>
      _sharedPrefsHelper.saveIsLoggedIn(value);

  Future<bool> get isLoggedIn => _sharedPrefsHelper.isLoggedIn;

  // Theme: --------------------------------------------------------------------
  Future<void> changeBrightnessToDark(bool value) =>
      _sharedPrefsHelper.changeBrightnessToDark(value);

  bool get isDarkMode => _sharedPrefsHelper.isDarkMode;

  // Language: -----------------------------------------------------------------
  Future<void> changeLanguage(String value) =>
      _sharedPrefsHelper.changeLanguage(value);

  String? get currentLanguage => _sharedPrefsHelper.currentLanguage;
}
