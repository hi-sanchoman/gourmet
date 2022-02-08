import 'package:esentai/data/local/datasources/post/post_datasource.dart';
import 'package:esentai/data/navigation_service.dart';
import 'package:esentai/data/network/apis/catalog/catalog_api.dart';
import 'package:esentai/data/network/apis/posts/post_api.dart';
import 'package:esentai/data/network/apis/users/user_api.dart';
import 'package:esentai/data/network/dio_client.dart';
import 'package:esentai/data/network/rest_client.dart';
import 'package:esentai/data/repository.dart';
import 'package:esentai/data/sharedpref/shared_preference_helper.dart';
import 'package:esentai/di/module/local_module.dart';
import 'package:esentai/di/module/network_module.dart';
import 'package:esentai/stores/cart/cart_store.dart';
import 'package:esentai/stores/cart/gift_store.dart';
import 'package:esentai/stores/catalog/catalog_store.dart';
import 'package:esentai/stores/error/error_store.dart';
import 'package:esentai/stores/form/form_store.dart';
import 'package:esentai/stores/language/language_store.dart';
import 'package:esentai/stores/order/order_store.dart';
import 'package:esentai/stores/post/post_store.dart';
import 'package:esentai/stores/theme/theme_store.dart';
import 'package:esentai/stores/user/user_store.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:sembast/sembast.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

Future<void> setupLocator() async {
  // factories:-----------------------------------------------------------------
  getIt.registerFactory(() => ErrorStore());
  getIt.registerFactory(() => FormStore(getIt<Repository>()));

  // async singletons:----------------------------------------------------------
  getIt.registerSingletonAsync<Database>(() => LocalModule.provideDatabase());
  getIt.registerSingletonAsync<SharedPreferences>(
      () => LocalModule.provideSharedPreferences());

  // singletons:----------------------------------------------------------------
  getIt.registerSingleton(
      SharedPreferenceHelper(await getIt.getAsync<SharedPreferences>()));
  getIt.registerSingleton<Dio>(
      NetworkModule.provideDio(getIt<SharedPreferenceHelper>()));
  getIt.registerSingleton(DioClient(getIt<Dio>()));
  getIt.registerSingleton(RestClient());
  getIt.registerLazySingleton(() => NavigationService());

  // api's:---------------------------------------------------------------------
  getIt.registerSingleton(PostApi(getIt<DioClient>(), getIt<RestClient>()));
  getIt.registerSingleton(UserApi(getIt<DioClient>(), getIt<RestClient>()));
  getIt.registerSingleton(CatalogApi(getIt<DioClient>(), getIt<RestClient>()));

  // data sources
  getIt.registerSingleton(PostDataSource(await getIt.getAsync<Database>()));

  // repository:----------------------------------------------------------------
  getIt.registerSingleton(Repository(
    getIt<CatalogApi>(),
    getIt<UserApi>(),
    getIt<SharedPreferenceHelper>(),
    getIt<PostDataSource>(),
  ));

  // stores:--------------------------------------------------------------------
  getIt.registerSingleton(LanguageStore(getIt<Repository>()));
  getIt.registerSingleton(PostStore(getIt<Repository>()));
  getIt.registerSingleton(CatalogStore(getIt<Repository>()));
  getIt.registerSingleton(OrderStore(getIt<Repository>()));
  getIt.registerSingleton(ThemeStore(getIt<Repository>()));
  getIt.registerSingleton(UserStore(getIt<Repository>()));
  getIt.registerSingleton(CartStore());
  getIt.registerSingleton(GiftStore());
}
