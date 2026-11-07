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
import 'package:simple_tracking/features/route/data/kakao_route_api.dart'
    as _i1019;
import 'package:simple_tracking/features/route/data/route_repository_impl.dart'
    as _i314;
import 'package:simple_tracking/features/route/domain/find_route_use_cases.dart'
    as _i621;
import 'package:simple_tracking/features/route/domain/route_repository.dart'
    as _i1013;

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
    gh.lazySingleton<_i1019.KakaoRouteApi>(
      () => _i1019.KakaoRouteApi(gh<_i361.Dio>()),
    );
    gh.factory<_i821.PushCubit>(
      () => _i821.PushCubit(gh<_i596.PushRepository>()),
    );
    gh.lazySingleton<_i1013.RouteRepository>(
      () => _i314.RouteRepositoryImpl(gh<_i1019.KakaoRouteApi>()),
    );
    gh.factory<_i621.FindCarRouteUseCase>(
      () => _i621.FindCarRouteUseCase(gh<_i1013.RouteRepository>()),
    );
    gh.factory<_i621.FindWalkingRouteUseCase>(
      () => _i621.FindWalkingRouteUseCase(gh<_i1013.RouteRepository>()),
    );
    gh.factory<_i621.FindTransitRoutesUseCase>(
      () => _i621.FindTransitRoutesUseCase(gh<_i1013.RouteRepository>()),
    );
    return this;
  }
}

class _$RegisterModule extends _i702.RegisterModule {}

class _$PushModule extends _i54.PushModule {}
