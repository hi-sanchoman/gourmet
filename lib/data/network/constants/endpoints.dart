class Endpoints {
  Endpoints._();

  // base url
  static const String baseUrl = "https://185.100.67.85/api";
  static const String serverUrl = "https://185.100.67.85/";

  // static const String baseUrl = "https://admin-esentai.kz/api";
  // static const String serverUrl = "https://admin-esentail.kz/";

  // 185.100.67.85

  // receiveTimeout
  static const int receiveTimeout = 15000;

  // connectTimeout
  static const int connectionTimeout = 30000;

  // booking endpoints
  static const String getPosts = baseUrl + "/posts";

  // users
  static const String login = baseUrl + "/users/login/";
  static const String register = baseUrl + "/users/";
  // static const String resendSMS = baseUrl + "/users/resend_activation/";
  static const String activateUser = baseUrl + "/users/user-activate/";
  static const String createJwtToken = baseUrl + "/jwt/create/";

  static const String userData = baseUrl + "/users/me/";
  static const String updateProfile = baseUrl + "/users/me/";

  // FCM device
  static const String fcmDevice = baseUrl + '/devices/';

  // address
  static const String getAddresses = baseUrl + "/address/";
  static const String createAddress = baseUrl + "/address/";
  static const String deleteAddress = baseUrl + '/address/:id/';

  // catalog
  static const String getMainGifts = baseUrl + '/main-gifts/';
  static const String getMainProducts = baseUrl + '/main-products/';
  static const String getCategoryList = baseUrl + "/category-list/";
  static const String getProducts = baseUrl + "/products/";
  static const String getProductById = baseUrl + "/products/:id/";
  static const String getGiftById = baseUrl + "/gifts/:id/";
  static const String getInfoPage = baseUrl + "/admin/content/";
  static const String getBanners = baseUrl + "/admin/banner/";
  static const String getBannerById = baseUrl + '/admin/banner/:id/';
  static const String searchProducts = baseUrl + "/subcategory-list/";
  static const String getPackages = baseUrl + "/admin/package/";
  static const String getPostcards = baseUrl + "/admin/postcard/";

  // orders
  static const String ordersHistory = baseUrl + '/order-history';
  static const String orderDetails = baseUrl + '/order-history/:id/';
  static const String createOrder = baseUrl + "/order-create/";
  static const String updateOrder = baseUrl + '/order/:id/';

  // cards
  static const String getCards = baseUrl + '/paybox/card-list/';
  static const String addCard = baseUrl + '/paybox/card-add/';
  static const String deleteCard = baseUrl + '/paybox/card-delete/';

  // favorites
  static const String getFavorites = baseUrl + '/favorites/';
  static const String toggleFav = baseUrl + '/favorites/';
}
