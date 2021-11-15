// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i5;

import 'blocs/app_theme.dart' as _i3;
import 'blocs/blog.dart' as _i4;
import 'modules/shared_preferences_module.dart'
    as _i6; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final sharedPreferencesModule = _$SharedPreferencesModule();
  gh.lazySingleton<_i3.AppTheme>(() => _i3.AppTheme.create());
  gh.singleton<_i4.Blog>(_i4.Blog(), dispose: (i) => i.dispose());
  gh.factoryAsync<_i5.SharedPreferences>(() => sharedPreferencesModule.prefs);
  return get;
}

class _$SharedPreferencesModule extends _i6.SharedPreferencesModule {}
