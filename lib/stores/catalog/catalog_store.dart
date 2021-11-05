import 'package:esentai/data/repository.dart';
import 'package:esentai/data/sharedpref/constants/preferences.dart';
import 'package:esentai/models/catalog/category_list.dart';
import 'package:esentai/models/catalog/gift.dart';
import 'package:esentai/models/catalog/gift_list.dart';
import 'package:esentai/models/catalog/product.dart';
import 'package:esentai/models/catalog/product_list.dart';
import 'package:esentai/models/catalog/search_list.dart';
import 'package:esentai/models/favorites/favorite_list.dart';
import 'package:esentai/models/gift/package.dart';
import 'package:esentai/models/gift/package_list.dart';
import 'package:esentai/models/gift/postcard.dart';
import 'package:esentai/models/gift/postcard_list.dart';
import 'package:esentai/models/info/banner.dart';
import 'package:esentai/models/info/banner_list.dart';
import 'package:esentai/models/info/info.dart';
import 'package:esentai/models/info/info_list.dart';
import 'package:esentai/stores/error/error_store.dart';
import 'package:esentai/utils/dio/dio_error_util.dart';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'catalog_store.g.dart';

class CatalogStore = _CatalogStore with _$CatalogStore;

abstract class _CatalogStore with Store {
  // repository instance
  late Repository _repository;

  // store for handling errors
  final ErrorStore errorStore = ErrorStore();

  // constructor:---------------------------------------------------------------
  _CatalogStore(Repository repository) : this._repository = repository;

  // store variables:-----------------------------------------------------------
  static ObservableFuture<CategoryList?> emptyCatalogResponse =
      ObservableFuture.value(null);

  @observable
  ObservableFuture<CategoryList?> fetchCatalogsFuture =
      ObservableFuture<CategoryList?>(emptyCatalogResponse);

  @observable
  CategoryList? catalogList;

  @observable
  SearchList? searchList;

  @observable
  GiftList? mainGifts;

  @observable
  ProductList? mainList;

  @observable
  ProductList? productsList;

  @observable
  FavoriteList? favoritesList;

  @observable
  BannerList? bannerList;

  @observable
  BannerPage? currentBanner;

  @observable
  Product? currentProduct;

  @observable
  Gift? currentGift;

  @observable
  bool success = false;

  @observable
  bool successProducts = false;

  @observable
  bool isLoading = false;

  @observable
  InfoList? pages;

  @observable
  List<int>? filter;

  @observable
  Product? gift;

  @observable
  Package? package;

  @observable
  Postcard? postcard;

  @observable
  PackageList? packageList;

  @observable
  PostcardList? postcardList;

  @observable
  ProductList? otherList;

  // actions:-------------------------------------------------------------------
  @action
  setGift(Product? value) {
    gift = value;
  }

  @action
  setPackage(Package? value) {
    package = value;
  }

  @action
  setPostcard(Postcard? value) {
    postcard = value;
  }

  @action
  Future getCategoryList() async {
    isLoading = true;

    await _repository.getCategories().then((res) {
      // print("res from rep: $res");
      isLoading = false;
      success = true;
      catalogList = res;
    }).catchError((e) {
      isLoading = false;
      success = false;
      errorStore.errorMessage = e.toString();
    });
  }

  @action
  Future getMainGifts() async {
    isLoading = true;
    mainGifts = null;

    // token
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(Preferences.auth_token);

    await _repository.getMainGifts(token).then((res) {
      isLoading = false;
      successProducts = true;
      mainGifts = res;
    }).catchError((e) {
      isLoading = false;
      successProducts = false;
      errorStore.errorMessage = e.toString();
    });
  }

  @action
  Future getMainProducts() async {
    isLoading = true;
    mainList = null;

    // token
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(Preferences.auth_token);

    await _repository.getMainProducts(token).then((res) {
      isLoading = false;
      successProducts = true;
      mainList = res;
    }).catchError((e) {
      isLoading = false;
      successProducts = false;
      errorStore.errorMessage = e.toString();
    });
  }

  @action
  Future getProducts(List<int> subcategories, String orderBy) async {
    isLoading = true;
    productsList = null;

    // token
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(Preferences.auth_token);

    // print("token is ... $token");

    await _repository.getProducts(subcategories, orderBy, token).then((res) {
      isLoading = false;
      successProducts = true;
      productsList = res;
    }).catchError((e) {
      isLoading = false;
      successProducts = false;
      errorStore.errorMessage = e.toString();
    });
  }

  @action
  Future getOtherProducts(int productId) async {
    isLoading = true;
    otherList = null;

    // token
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(Preferences.auth_token);

    // print("token is ... $token");

    await _repository.getOtherProducts(productId, token).then((res) {
      isLoading = false;
      successProducts = true;
      otherList = res;
    }).catchError((e) {
      isLoading = false;
      successProducts = false;
      errorStore.errorMessage = e.toString();
    });
  }

  @action
  Future getOtherGifts(int giftId) async {
    isLoading = true;
    otherList = null;

    // token
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(Preferences.auth_token);

    // print("token is ... $token");

    await _repository.getOtherGifts(giftId, token).then((res) {
      isLoading = false;
      successProducts = true;
      otherList = res;
    }).catchError((e) {
      isLoading = false;
      successProducts = false;
      errorStore.errorMessage = e.toString();
    });
  }

  @action
  Future searchProducts(String query) async {
    isLoading = true;
    searchList = null;

    // token
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(Preferences.auth_token);

    // print("token is ... $token");

    await _repository.searchProducts(query, token).then((res) {
      isLoading = false;
      successProducts = true;
      searchList = res;

      // print("searchlist $searchList");
    }).catchError((e) {
      isLoading = false;
      successProducts = false;
      errorStore.errorMessage = e.toString();
    });
  }

  @action
  Future getInfoPage(String slug) async {
    isLoading = true;

    await _repository.getInfoPage(slug).then((res) {
      isLoading = false;
      success = true;

      pages = res;
    }).catchError((e) {
      isLoading = false;
      success = false;
      errorStore.errorMessage = e.toString();
    });
  }

  @action
  Future getFavorites() async {
    isLoading = true;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(Preferences.auth_token);

    await _repository.getFavorites(token!).then((res) {
      isLoading = false;
      successProducts = true;
      favoritesList = res;
    }).catchError((e) {
      isLoading = false;
      successProducts = false;
      errorStore.errorMessage = e.toString();
    });
  }

  @action
  Future toggleFav(int id, String type) async {
    isLoading = true;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(Preferences.auth_token);

    await _repository.toggleFav(token!, id, type).then((res) async {
      isLoading = false;
      successProducts = true;

      // refresh favorites
      await getFavorites();

      // look for products
      if (favoritesList != null) {
        if (type == 'product') {
          // products (category, subcategory)
          if (productsList != null) {
            if (productsList!.items != null) {
              for (var item in productsList!.items!) {
                if (item.id == id) {
                  item.isLiked = !item.isLiked!;
                  // print('item found to be checked/unchekd');
                  break;
                }
              }
            }

            productsList = productsList!.copyWith(items: productsList!.items!);
          }

          // main list (home)
          if (mainList != null) {
            if (mainList!.items != null) {
              for (var item in mainList!.items!) {
                if (item.id == id) {
                  item.isLiked = !item.isLiked!;
                  // print('item found to be checked/unchekd');
                  break;
                }
              }
            }

            mainList = mainList!.copyWith(items: mainList!.items!);
          }

          // search list
          if (searchList != null) {
            if (searchList!.items != null) {
              for (var res in searchList!.items!) {
                if (res.products != null) {
                  for (var item in res.products!) {
                    if (item['id'] == id) {
                      item['is_liked'] = !item['is_liked']!;
                      // print('item found to be checked/unchekd');
                      break;
                    }
                  }
                }
              }

              searchList = searchList!.copyWith(items: searchList!.items!);
            }
          }

          // others (product page)
          if (otherList != null) {
            if (otherList!.items != null) {
              for (var item in otherList!.items!) {
                if (item.id == id) {
                  item.isLiked = !item.isLiked!;
                  // print('item found to be checked/unchekd');
                  break;
                }
              }
            }

            otherList = otherList!.copyWith(items: otherList!.items!);
          }
        }

        // when gift
        if (type == 'gift') {
          // main gifts (home)
          if (mainGifts != null) {
            if (mainGifts!.items != null) {
              for (var item in mainGifts!.items!) {
                if (item.id == id) {
                  item.isLiked = !item.isLiked!;
                  // print('item found to be checked/unchekd');
                  break;
                }
              }
            }

            mainGifts = mainGifts!.copyWith(items: mainGifts!.items!);
          }
        }
      }
    }).catchError((e) {
      isLoading = false;
      successProducts = false;
      errorStore.errorMessage = e.toString();
    });
  }

  @action
  Future getBanners() async {
    isLoading = true;

    await _repository.getBanners().then((res) {
      isLoading = false;
      successProducts = true;
      bannerList = res;
    }).catchError((e) {
      isLoading = false;
      successProducts = false;
      errorStore.errorMessage = e.toString();
    });
  }

  @action
  Future getBanner(int id) async {
    isLoading = true;

    await _repository.getBanner(id).then((res) {
      isLoading = false;
      success = true;
      currentBanner = res;
    }).catchError((e) {
      isLoading = false;
      success = false;
      errorStore.errorMessage = e.toString();
    });
  }

  @action
  Future getProduct(int id) async {
    isLoading = true;

    await _repository.getProduct(id).then((res) {
      isLoading = false;
      success = true;
      currentProduct = res;
    }).catchError((e) {
      isLoading = false;
      success = false;
      errorStore.errorMessage = e.toString();
    });
  }

  @action
  Future getGift(id) async {
    isLoading = true;

    await _repository.getGift(id).then((res) {
      isLoading = false;
      success = true;
      currentGift = res;
    }).catchError((e) {
      isLoading = false;
      success = false;
      errorStore.errorMessage = e.toString();
    });
  }

  @action
  Future getPackages() async {
    isLoading = true;
    packageList = null;

    await _repository.getPackages().then((res) {
      isLoading = false;
      successProducts = true;
      packageList = res;
    }).catchError((e) {
      isLoading = false;
      successProducts = false;
      errorStore.errorMessage = e.toString();
    });
  }

  @action
  Future getPostcards() async {
    isLoading = true;
    postcardList = null;

    await _repository.getPostcards().then((res) {
      isLoading = false;
      successProducts = true;
      postcardList = res;
    }).catchError((e) {
      isLoading = false;
      successProducts = false;
      errorStore.errorMessage = e.toString();
    });
  }
}
