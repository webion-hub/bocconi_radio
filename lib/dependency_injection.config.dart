// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:audio_service/audio_service.dart' as _i4;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i7;

import 'blocs/app_theme.dart' as _i3;
import 'blocs/blog.dart' as _i5;
import 'blocs/bottom_bar_bloc.dart' as _i6;
import 'modules/audio_handler_module.dart' as _i8;
import 'modules/shared_preferences_module.dart'
    as _i9; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
Future<_i1.GetIt> $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) async {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final audioHandlerModule = _$AudioHandlerModule();
  final sharedPreferencesModule = _$SharedPreferencesModule();
  gh.lazySingleton<_i3.AppTheme>(() => _i3.AppTheme.create());
  await gh.factoryAsync<_i4.AudioHandler>(() => audioHandlerModule.handler,
      preResolve: true);
  gh.singleton<_i5.Blog>(_i5.Blog(), dispose: (i) => i.dispose());
  gh.singleton<_i6.BottomBarBloc>(_i6.BottomBarBloc());
  gh.factoryAsync<_i7.SharedPreferences>(() => sharedPreferencesModule.prefs);
  return get;
}

class _$AudioHandlerModule extends _i8.AudioHandlerModule {}

class _$SharedPreferencesModule extends _i9.SharedPreferencesModule {}
