// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;
import 'package:simple_tracking/core/di/register_module.dart' as _i702;
import 'package:simple_tracking/features/push/data/push_module.dart' as _i54;
import 'package:simple_tracking/features/push/domain/push_repository.dart'
    as _i596;
import 'package:simple_tracking/features/push/presentation/cubit/push_cubit.dart'
    as _i821;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModule = _$RegisterModule();
    final pushModule = _$PushModule();
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => registerModule.prefs(),
      preResolve: true,
    );
    gh.lazySingleton<_i361.Dio>(() => registerModule.dio());
    gh.lazySingleton<_i596.PushRepository>(() => pushModule.push());
    gh.factory<_i821.PushCubit>(
      () => _i821.PushCubit(gh<_i596.PushRepository>()),
    );
    return this;
  }
}

class _$RegisterModule extends _i702.RegisterModule {}

class _$PushModule extends _i54.PushModule {}
