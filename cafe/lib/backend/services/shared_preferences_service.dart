import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  late final SharedPreferencesWithCache prefsWithCache;

  // function to initialize shared Preferences
  Future<void> initPrefs() async {
    prefsWithCache = await SharedPreferencesWithCache.create(
      cacheOptions: const SharedPreferencesWithCacheOptions(),
    );
  }

  // function to reset shared Preferences,
  // used, when a new customer wants to order
}
