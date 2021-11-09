// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'catalog_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$CatalogStore on _CatalogStore, Store {
  final _$fetchCatalogsFutureAtom =
      Atom(name: '_CatalogStore.fetchCatalogsFuture');

  @override
  ObservableFuture<CategoryList?> get fetchCatalogsFuture {
    _$fetchCatalogsFutureAtom.reportRead();
    return super.fetchCatalogsFuture;
  }

  @override
  set fetchCatalogsFuture(ObservableFuture<CategoryList?> value) {
    _$fetchCatalogsFutureAtom.reportWrite(value, super.fetchCatalogsFuture, () {
      super.fetchCatalogsFuture = value;
    });
  }

  final _$catalogListAtom = Atom(name: '_CatalogStore.catalogList');

  @override
  CategoryList? get catalogList {
    _$catalogListAtom.reportRead();
    return super.catalogList;
  }

  @override
  set catalogList(CategoryList? value) {
    _$catalogListAtom.reportWrite(value, super.catalogList, () {
      super.catalogList = value;
    });
  }

  final _$searchListAtom = Atom(name: '_CatalogStore.searchList');

  @override
  SearchList? get searchList {
    _$searchListAtom.reportRead();
    return super.searchList;
  }

  @override
  set searchList(SearchList? value) {
    _$searchListAtom.reportWrite(value, super.searchList, () {
      super.searchList = value;
    });
  }

  final _$mainGiftsAtom = Atom(name: '_CatalogStore.mainGifts');

  @override
  GiftList? get mainGifts {
    _$mainGiftsAtom.reportRead();
    return super.mainGifts;
  }

  @override
  set mainGifts(GiftList? value) {
    _$mainGiftsAtom.reportWrite(value, super.mainGifts, () {
      super.mainGifts = value;
    });
  }

  final _$mainListAtom = Atom(name: '_CatalogStore.mainList');

  @override
  ProductList? get mainList {
    _$mainListAtom.reportRead();
    return super.mainList;
  }

  @override
  set mainList(ProductList? value) {
    _$mainListAtom.reportWrite(value, super.mainList, () {
      super.mainList = value;
    });
  }

  final _$productsListAtom = Atom(name: '_CatalogStore.productsList');

  @override
  ProductList? get productsList {
    _$productsListAtom.reportRead();
    return super.productsList;
  }

  @override
  set productsList(ProductList? value) {
    _$productsListAtom.reportWrite(value, super.productsList, () {
      super.productsList = value;
    });
  }

  final _$favoritesListAtom = Atom(name: '_CatalogStore.favoritesList');

  @override
  FavoriteList? get favoritesList {
    _$favoritesListAtom.reportRead();
    return super.favoritesList;
  }

  @override
  set favoritesList(FavoriteList? value) {
    _$favoritesListAtom.reportWrite(value, super.favoritesList, () {
      super.favoritesList = value;
    });
  }

  final _$bannerListAtom = Atom(name: '_CatalogStore.bannerList');

  @override
  BannerList? get bannerList {
    _$bannerListAtom.reportRead();
    return super.bannerList;
  }

  @override
  set bannerList(BannerList? value) {
    _$bannerListAtom.reportWrite(value, super.bannerList, () {
      super.bannerList = value;
    });
  }

  final _$currentBannerAtom = Atom(name: '_CatalogStore.currentBanner');

  @override
  BannerPage? get currentBanner {
    _$currentBannerAtom.reportRead();
    return super.currentBanner;
  }

  @override
  set currentBanner(BannerPage? value) {
    _$currentBannerAtom.reportWrite(value, super.currentBanner, () {
      super.currentBanner = value;
    });
  }

  final _$currentProductAtom = Atom(name: '_CatalogStore.currentProduct');

  @override
  Product? get currentProduct {
    _$currentProductAtom.reportRead();
    return super.currentProduct;
  }

  @override
  set currentProduct(Product? value) {
    _$currentProductAtom.reportWrite(value, super.currentProduct, () {
      super.currentProduct = value;
    });
  }

  final _$currentGiftAtom = Atom(name: '_CatalogStore.currentGift');

  @override
  Gift? get currentGift {
    _$currentGiftAtom.reportRead();
    return super.currentGift;
  }

  @override
  set currentGift(Gift? value) {
    _$currentGiftAtom.reportWrite(value, super.currentGift, () {
      super.currentGift = value;
    });
  }

  final _$successAtom = Atom(name: '_CatalogStore.success');

  @override
  bool get success {
    _$successAtom.reportRead();
    return super.success;
  }

  @override
  set success(bool value) {
    _$successAtom.reportWrite(value, super.success, () {
      super.success = value;
    });
  }

  final _$successProductsAtom = Atom(name: '_CatalogStore.successProducts');

  @override
  bool get successProducts {
    _$successProductsAtom.reportRead();
    return super.successProducts;
  }

  @override
  set successProducts(bool value) {
    _$successProductsAtom.reportWrite(value, super.successProducts, () {
      super.successProducts = value;
    });
  }

  final _$isLoadingAtom = Atom(name: '_CatalogStore.isLoading');

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  final _$pagesAtom = Atom(name: '_CatalogStore.pages');

  @override
  InfoList? get pages {
    _$pagesAtom.reportRead();
    return super.pages;
  }

  @override
  set pages(InfoList? value) {
    _$pagesAtom.reportWrite(value, super.pages, () {
      super.pages = value;
    });
  }

  final _$filterAtom = Atom(name: '_CatalogStore.filter');

  @override
  List<int>? get filter {
    _$filterAtom.reportRead();
    return super.filter;
  }

  @override
  set filter(List<int>? value) {
    _$filterAtom.reportWrite(value, super.filter, () {
      super.filter = value;
    });
  }

  final _$giftAtom = Atom(name: '_CatalogStore.gift');

  @override
  Product? get gift {
    _$giftAtom.reportRead();
    return super.gift;
  }

  @override
  set gift(Product? value) {
    _$giftAtom.reportWrite(value, super.gift, () {
      super.gift = value;
    });
  }

  final _$packageAtom = Atom(name: '_CatalogStore.package');

  @override
  Package? get package {
    _$packageAtom.reportRead();
    return super.package;
  }

  @override
  set package(Package? value) {
    _$packageAtom.reportWrite(value, super.package, () {
      super.package = value;
    });
  }

  final _$postcardAtom = Atom(name: '_CatalogStore.postcard');

  @override
  Postcard? get postcard {
    _$postcardAtom.reportRead();
    return super.postcard;
  }

  @override
  set postcard(Postcard? value) {
    _$postcardAtom.reportWrite(value, super.postcard, () {
      super.postcard = value;
    });
  }

  final _$packageListAtom = Atom(name: '_CatalogStore.packageList');

  @override
  PackageList? get packageList {
    _$packageListAtom.reportRead();
    return super.packageList;
  }

  @override
  set packageList(PackageList? value) {
    _$packageListAtom.reportWrite(value, super.packageList, () {
      super.packageList = value;
    });
  }

  final _$postcardListAtom = Atom(name: '_CatalogStore.postcardList');

  @override
  PostcardList? get postcardList {
    _$postcardListAtom.reportRead();
    return super.postcardList;
  }

  @override
  set postcardList(PostcardList? value) {
    _$postcardListAtom.reportWrite(value, super.postcardList, () {
      super.postcardList = value;
    });
  }

  final _$otherListAtom = Atom(name: '_CatalogStore.otherList');

  @override
  ProductList? get otherList {
    _$otherListAtom.reportRead();
    return super.otherList;
  }

  @override
  set otherList(ProductList? value) {
    _$otherListAtom.reportWrite(value, super.otherList, () {
      super.otherList = value;
    });
  }

  final _$getCategoryListAsyncAction =
      AsyncAction('_CatalogStore.getCategoryList');

  @override
  Future<dynamic> getCategoryList() {
    return _$getCategoryListAsyncAction.run(() => super.getCategoryList());
  }

  final _$getMainGiftsAsyncAction = AsyncAction('_CatalogStore.getMainGifts');

  @override
  Future<dynamic> getMainGifts() {
    return _$getMainGiftsAsyncAction.run(() => super.getMainGifts());
  }

  final _$getMainProductsAsyncAction =
      AsyncAction('_CatalogStore.getMainProducts');

  @override
  Future<dynamic> getMainProducts() {
    return _$getMainProductsAsyncAction.run(() => super.getMainProducts());
  }

  final _$getProductsAsyncAction = AsyncAction('_CatalogStore.getProducts');

  @override
  Future<dynamic> getProducts(
      List<int> subcategories, String orderBy, bool isActive) {
    return _$getProductsAsyncAction
        .run(() => super.getProducts(subcategories, orderBy, isActive));
  }

  final _$getOtherProductsAsyncAction =
      AsyncAction('_CatalogStore.getOtherProducts');

  @override
  Future<dynamic> getOtherProducts(int productId) {
    return _$getOtherProductsAsyncAction
        .run(() => super.getOtherProducts(productId));
  }

  final _$getOtherGiftsAsyncAction = AsyncAction('_CatalogStore.getOtherGifts');

  @override
  Future<dynamic> getOtherGifts(int giftId) {
    return _$getOtherGiftsAsyncAction.run(() => super.getOtherGifts(giftId));
  }

  final _$searchProductsAsyncAction =
      AsyncAction('_CatalogStore.searchProducts');

  @override
  Future<dynamic> searchProducts(String query) {
    return _$searchProductsAsyncAction.run(() => super.searchProducts(query));
  }

  final _$getInfoPageAsyncAction = AsyncAction('_CatalogStore.getInfoPage');

  @override
  Future<dynamic> getInfoPage(String slug) {
    return _$getInfoPageAsyncAction.run(() => super.getInfoPage(slug));
  }

  final _$getFavoritesAsyncAction = AsyncAction('_CatalogStore.getFavorites');

  @override
  Future<dynamic> getFavorites() {
    return _$getFavoritesAsyncAction.run(() => super.getFavorites());
  }

  final _$toggleFavAsyncAction = AsyncAction('_CatalogStore.toggleFav');

  @override
  Future<dynamic> toggleFav(int id, String type) {
    return _$toggleFavAsyncAction.run(() => super.toggleFav(id, type));
  }

  final _$getBannersAsyncAction = AsyncAction('_CatalogStore.getBanners');

  @override
  Future<dynamic> getBanners() {
    return _$getBannersAsyncAction.run(() => super.getBanners());
  }

  final _$getBannerAsyncAction = AsyncAction('_CatalogStore.getBanner');

  @override
  Future<dynamic> getBanner(int id) {
    return _$getBannerAsyncAction.run(() => super.getBanner(id));
  }

  final _$getProductAsyncAction = AsyncAction('_CatalogStore.getProduct');

  @override
  Future<dynamic> getProduct(int id) {
    return _$getProductAsyncAction.run(() => super.getProduct(id));
  }

  final _$getGiftAsyncAction = AsyncAction('_CatalogStore.getGift');

  @override
  Future<dynamic> getGift(dynamic id) {
    return _$getGiftAsyncAction.run(() => super.getGift(id));
  }

  final _$getPackagesAsyncAction = AsyncAction('_CatalogStore.getPackages');

  @override
  Future<dynamic> getPackages() {
    return _$getPackagesAsyncAction.run(() => super.getPackages());
  }

  final _$getPostcardsAsyncAction = AsyncAction('_CatalogStore.getPostcards');

  @override
  Future<dynamic> getPostcards() {
    return _$getPostcardsAsyncAction.run(() => super.getPostcards());
  }

  final _$_CatalogStoreActionController =
      ActionController(name: '_CatalogStore');

  @override
  dynamic setGift(Product? value) {
    final _$actionInfo = _$_CatalogStoreActionController.startAction(
        name: '_CatalogStore.setGift');
    try {
      return super.setGift(value);
    } finally {
      _$_CatalogStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setPackage(Package? value) {
    final _$actionInfo = _$_CatalogStoreActionController.startAction(
        name: '_CatalogStore.setPackage');
    try {
      return super.setPackage(value);
    } finally {
      _$_CatalogStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setPostcard(Postcard? value) {
    final _$actionInfo = _$_CatalogStoreActionController.startAction(
        name: '_CatalogStore.setPostcard');
    try {
      return super.setPostcard(value);
    } finally {
      _$_CatalogStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
fetchCatalogsFuture: ${fetchCatalogsFuture},
catalogList: ${catalogList},
searchList: ${searchList},
mainGifts: ${mainGifts},
mainList: ${mainList},
productsList: ${productsList},
favoritesList: ${favoritesList},
bannerList: ${bannerList},
currentBanner: ${currentBanner},
currentProduct: ${currentProduct},
currentGift: ${currentGift},
success: ${success},
successProducts: ${successProducts},
isLoading: ${isLoading},
pages: ${pages},
filter: ${filter},
gift: ${gift},
package: ${package},
postcard: ${postcard},
packageList: ${packageList},
postcardList: ${postcardList},
otherList: ${otherList}
    ''';
  }
}
